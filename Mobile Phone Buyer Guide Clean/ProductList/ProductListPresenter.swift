//
//  ProductListPresenter.swift
//  Mobile Phone Buyer Guide Clean
//
//  Created by Pikkanet Chokwattanapornchai on 2/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol ProductListPresenterInterface {
  func presentSomething(response: ProductList.Something.Response)
  func presentMobile(response: ProductList.Mobile.Response)
}

class ProductListPresenter: ProductListPresenterInterface {
  weak var viewController: ProductListViewControllerInterface!

  // MARK: - Presentation logic

  func presentSomething(response: ProductList.Something.Response) {
    // NOTE: Format the response from the Interactor and pass the result back to the View Controller. The resulting view model should be using only primitive types. Eg: the view should not need to involve converting date object into a formatted string. The formatting is done here.

    let viewModel = ProductList.Something.ViewModel()
    viewController.displaySomething(viewModel: viewModel)
  }
  
  func presentMobile(response: ProductList.Mobile.Response) {
//    let models = ProductList.Mobile.ViewModel.NewMobile(id: Int, thumbImageURL: <#T##String#>, brand: <#T##String#>, name: <#T##String#>, price: <#T##String#>, rating: <#T##String#>, isFavourite: <#T##Bool?#>, mobileResponseDescription: <#T##String#>)
    switch response.mobileList {
    case .success(let data):
      let models = data.map { (mobile) -> ProductList.Mobile.ViewModel.NewMobile in
        let rate:String = "rating: \(mobile.rating)"
        let price:String = "price: $\(mobile.price)"
        
        return ProductList.Mobile.ViewModel.NewMobile(id: mobile.id, thumbImageURL: mobile.thumbImageURL, brand: mobile.brand, name: mobile.name, price: price, rating: rate, isFavourite: mobile.isFavourite, mobileResponseDescription: mobile.mobileResponseDescription)
      }
      let viewModel = ProductList.Mobile.ViewModel(displayMobile: models)
      viewController.displayMobile(viewModel: viewModel)
    case .failure(let error):
      print(error)
    }
  }
}
