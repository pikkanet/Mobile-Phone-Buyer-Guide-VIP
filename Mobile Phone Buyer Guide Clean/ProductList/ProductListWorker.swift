//
//  ProductListWorker.swift
//  Mobile Phone Buyer Guide Clean
//
//  Created by Pikkanet Chokwattanapornchai on 2/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol ProductListStoreProtocol {
  func getData(_ completion: @escaping (Result<Entity>) -> Void)
  func getMobiles(_ completion: @escaping (Result<MobileResponse>) -> Void)
}

class ProductListWorker {

  
  var store: ProductListStoreProtocol

  init(store: ProductListStoreProtocol) {
    self.store = store
  }

  // MARK: - Business Logic

  func doSomeWork(_ completion: @escaping (Result<Entity>) -> Void) {
    // NOTE: Do the work
    store.getData {
      // The worker may perform some small business logic before returning the result to the Interactor
      completion($0)
    }
  }

  func getPhone(_ completaion: @escaping (Result<MobileResponse>) -> Void) {
    store.getMobiles {
      completaion($0)
    }
  }
  
}
