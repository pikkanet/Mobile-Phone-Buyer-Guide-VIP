//
//  ProductListWorker.swift
//  Mobile Phone Buyer Guide Clean
//
//  Created by Pikkanet Chokwattanapornchai on 2/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol ProductListStoreProtocol {
//  func getData(_ completion: @escaping (Result<Entity>) -> Void)
  func getMobiles(_ completion: @escaping (Result<MobileResponse, Error>) -> Void)
}

class ProductListWorker {

  
  var store: ProductListStoreProtocol

  init(store: ProductListStoreProtocol) {
    self.store = store
  }

  // MARK: - Business Logic

  func getPhone(_ completion: @escaping (Result<MobileResponse, Error>) -> Void) {
    store.getMobiles {
      completion($0)
    }
  }
  
}
