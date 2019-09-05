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
    if let displayMobile = mobile {
      let response = Product.SetData.ViewModel(displayMobile: displayMobile)
      presenter.presentData(viewModel: response)
    }
  }
  
  func getImage(request: Product.GetImage.Request) {
    guard let id = mobile?.id else {
      return
    }
    worker?.getPhoneImages(index: id, { [weak self] (result) in
      switch result {
      case let .success(data):
        let response = Product.GetImage.Response(images: Result.success(data))
        self?.presenter.presentImage(response: response)
      case let .failure(error):
        let response = Product.GetImage.Response(images: Result.failure(error))
        self?.presenter.presentImage(response: response)
      }
    })

  }
}
