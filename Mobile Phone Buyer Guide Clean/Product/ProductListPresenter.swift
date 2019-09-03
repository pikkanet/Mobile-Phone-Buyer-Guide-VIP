//
//  ProductListPresenter.swift
//  Mobile Phone Buyer Guide Clean
//
//  Created by Pikkanet Chokwattanapornchai on 2/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol ProductListPresenterInterface {
  func presentMobile(response: ProductList.Mobile.Response)
}

class ProductListPresenter: ProductListPresenterInterface {
  weak var viewController: ProductListViewControllerInterface!

  // MARK: - Presentation logic

 
  
  func presentMobile(response: ProductList.Mobile.Response) {
//    let models = ProductList.Mobile.ViewModel.NewMobile(id: Int, thumbImageURL: <#T##String#>, brand: <#T##String#>, name: <#T##String#>, price: <#T##String#>, rating: <#T##String#>, isFavourite: <#T##Bool?#>, mobileResponseDescription: <#T##String#>)
    switch response.mobileList {
    case .success(let data):
      let models = data.map { (mobile) -> NewMobile in
        let rate:String = "rating: \(mobile.rating)"
        let price:String = "price: $\(mobile.price)"
        
        return NewMobile(id: mobile.id, thumbImageURL: mobile.thumbImageURL, brand: mobile.brand, name: mobile.name, price: price, rating: rate, isFavourite: mobile.isFavourite, mobileResponseDescription: mobile.mobileResponseDescription)
      }
      let viewModel = ProductList.Mobile.ViewModel(displayMobile: models)
      viewController.displayMobile(viewModel: viewModel)
    case .failure(let error):
      print(error)
    }
  }
}
