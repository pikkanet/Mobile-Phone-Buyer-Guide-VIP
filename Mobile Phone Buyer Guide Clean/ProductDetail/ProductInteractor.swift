//
//  ProductInteractor.swift
//  Mobile Phone Buyer Guide Clean
//
//  Created by Pikkanet Chokwattanapornchai on 3/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol ProductInteractorInterface {
  var mobile : NewMobile? { get set }
  func setupData(request: Product.SetData.Request)
  func getImage(request: Product.GetImage.Request)
}

class ProductInteractor: ProductInteractorInterface {
  var mobile: NewMobile?

  var presenter: ProductPresenterInterface!
  var worker: ProductWorker?

  // MARK: - Business logic

  func setupData(request: Product.SetData.Request) {
    let response = Product.SetData.ViewModel(displayMobile: mobile!)
    presenter.presentData(viewModel: response)
  }
  
  func getImage(request: Product.GetImage.Request) {
    worker?.getPhoneImages(index: mobile!.id, { (result) in
      switch result {
      case .success(let data):
        let response = Product.GetImage.Response(images: Result.success(data))
        self.presenter.presentImage(response: response)
//        print(data)
      case .failure(let error):
        let response = Product.GetImage.Response(images: Result.failure(error))
        self.presenter.presentImage(response: response)
      }
      
    })
//    worker?.getPhoneImages({ [weak self] (result) in
//      switch result {
//      case .success(let data):
//        let response = ProductList.Mobile.Response(mobileList: Result.success(self!.mobiles!))
//        self?.presenter.presentMobile(response: response)
//      case .failure(let error):
//        let response = ProductList.Mobile.Response(mobileList: Result.failure(error))
//        print(error)
//      }
//    })
  }
}
