//
//  ProductWorker.swift
//  Mobile Phone Buyer Guide Clean
//
//  Created by Pikkanet Chokwattanapornchai on 3/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol ProductStoreProtocol {
//  func getData(_ completion: @escaping (Result<Entity>) -> Void)
  func getImages(index: Int, _ completion: @escaping (Result<MobileImageResponse>) -> Void)
}

class ProductWorker {

  var store: ProductStoreProtocol

  init(store: ProductStoreProtocol) {
    self.store = store
  }

  // MARK: - Business Logic
  func getPhoneImages(index: Int, _ completion: @escaping (Result<MobileImageResponse>) -> Void) {
    store.getImages(index: index) {
      completion($0)
    }
  }
  
}
