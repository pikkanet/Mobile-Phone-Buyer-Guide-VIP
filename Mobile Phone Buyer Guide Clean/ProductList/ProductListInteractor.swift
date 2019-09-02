//
//  ProductListInteractor.swift
//  Mobile Phone Buyer Guide Clean
//
//  Created by Pikkanet Chokwattanapornchai on 2/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol ProductListInteractorInterface {
  func doSomething(request: ProductList.Something.Request)
  func doGetPhoneList(request: ProductList.Mobile.Request)
  func sortPhoneList(request: ProductList.SortMobile.Request)
  var model: Entity? { get }
  var mobiles: [MobileResponse]? { get set }
}

class ProductListInteractor: ProductListInteractorInterface {
  var mobiles: [MobileResponse]?
  
  var presenter: ProductListPresenterInterface!
  var worker: ProductListWorker?
  var model: Entity?
//  var mobiles: MobileResponse?
  
  // MARK: - Business logic
  
  func doSomething(request: ProductList.Something.Request) {
    worker?.doSomeWork { [weak self] in
      if case let Result.success(data) = $0 {
        // If the result was successful, we keep the data so that we can deliver it to another view controller through the router.
        self?.model = data
      }
      
      // NOTE: Pass the result to the Presenter. This is done by creating a response model with the result from the worker. The response could contain a type like UserResult enum (as declared in the SCB Easy project) with the result as an associated value.
      let response = ProductList.Something.Response()
      self?.presenter.presentSomething(response: response)
    }
  }
  
  func doGetPhoneList(request: ProductList.Mobile.Request) {
    worker?.getPhone({ [weak self] (result) in
      switch result {
      case .success(let data):
        let response = ProductList.Mobile.Response(mobileList: Result.success(data))
        self?.mobiles = [data]
        self?.presenter.presentMobile(response: response)
      case .failure(let error):
        let response = ProductList.Mobile.Response(mobileList: Result.failure(error))
        print(error)
      }
    })
  }
  
  func sortPhoneList(request: ProductList.SortMobile.Request) {
    switch request.type {
    case .priceLowToHigh:
      print("Low")
    case .priceHighToLow:
      print("High")
    case .rate:
      print("Rate")
    }
  }
}
