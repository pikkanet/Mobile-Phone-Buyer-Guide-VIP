//
//  ProductListInteractor.swift
//  Mobile Phone Buyer Guide Clean
//
//  Created by Pikkanet Chokwattanapornchai on 2/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol ProductListInteractorInterface {
  func doGetPhoneList(request: ProductList.Mobile.Request)
  func sortPhoneList(request: ProductList.SortMobile.Request)
  func filterPhoneList(request: ProductList.Filter.Request)
  func deletePhoneList(request: ProductList.DeleteRow.Request)
  func addToFavourite(request: ProductList.AddToFavourite.Request)
}

class ProductListInteractor: ProductListInteractorInterface {
  
  var presenter: ProductListPresenterInterface!
  var worker: ProductListWorker?
  var mobiles: MobileResponse?
  var tmp_mobiles: MobileResponse?
  var fav_mobiles: MobileResponse?
  
  // MARK: - Business logic
  
  func setIsFavouriteToFalse(){
    for i in 0...self.mobiles!.count-1 {
      self.mobiles![i].isFavourite = false
    }
    self.tmp_mobiles = self.mobiles
  }
  
  func doGetPhoneList(request: ProductList.Mobile.Request) {
    worker?.getPhone({ [weak self] (result) in
      switch result {
      case .success(let data):
        self?.mobiles = data
        self?.setIsFavouriteToFalse()
        let response = ProductList.Mobile.Response(mobileList: Result.success(self!.mobiles!))
        self?.presenter.presentMobile(response: response)
      case .failure(let error):
        let response = ProductList.Mobile.Response(mobileList: Result.failure(error))
        self?.presenter.presentMobile(response: response)
      }
    })
  }
  
  func sortPhoneList(request: ProductList.SortMobile.Request) {
    switch request.type {
    case .priceLowToHigh:
      self.mobiles?.sort(by: { $0.price < $1.price})
      let response = ProductList.Mobile.Response(mobileList: Result.success(self.mobiles!))
      self.presenter.presentMobile(response: response)
    case .priceHighToLow:
      self.mobiles?.sort(by: { $0.price > $1.price })
      let response = ProductList.Mobile.Response(mobileList: Result.success(self.mobiles!))
      self.presenter.presentMobile(response: response)
    case .rate:
      self.mobiles?.sort(by: { $0.rating > $1.rating })
      let response = ProductList.Mobile.Response(mobileList: Result.success(self.mobiles!))
      self.presenter.presentMobile(response: response)
    }
  }
  
  func filterPhoneList(request: ProductList.Filter.Request) {
    switch request.type {
    case .All:
      self.mobiles = self.tmp_mobiles
      let response = ProductList.Mobile.Response(mobileList: Result.success(self.mobiles!))
      self.presenter.presentMobile(response: response)
    case .Favourite:
      self.tmp_mobiles = self.mobiles
      self.fav_mobiles = self.mobiles?.filter({ (data) -> Bool in
        return data.isFavourite == true
      })
      self.mobiles = self.fav_mobiles
      let response = ProductList.Mobile.Response(mobileList: Result.success(self.mobiles ?? []))
      self.presenter.presentMobile(response: response)
    }
  }
  
  func deletePhoneList(request: ProductList.DeleteRow.Request) {
    let i = self.tmp_mobiles?.firstIndex(where: { $0.name == self.mobiles?[request.index].name})
    self.tmp_mobiles?[i!].isFavourite = false
    self.mobiles?.remove(at: request.index)
    let response = ProductList.Mobile.Response(mobileList: Result.success(self.mobiles!))
    self.presenter.presentMobile(response: response)
  }
  
  func addToFavourite(request: ProductList.AddToFavourite.Request) {
    self.mobiles?[request.index].isFavourite = true
    let response = ProductList.Mobile.Response(mobileList: Result.success(self.mobiles!))
    self.presenter.presentMobile(response: response)
  }
}
