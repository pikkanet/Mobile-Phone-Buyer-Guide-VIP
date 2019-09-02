//
//  ProductListModels.swift
//  Mobile Phone Buyer Guide Clean
//
//  Created by Pikkanet Chokwattanapornchai on 2/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

struct ProductList {
  /// This structure represents a use case
  struct Something {
    /// Data struct sent to Interactor
    struct Request {}
    /// Data struct sent to Presenter
    struct Response {}
    /// Data struct sent to ViewController
    struct ViewModel {}
  }
  
  struct SortMobile {
    struct Request {
      enum SortType {
        case priceLowToHigh
        case priceHighToLow
        case rate
      }
      let type: SortType
    }
    /// Data struct sent to Presenter
    struct Response {}
    /// Data struct sent to ViewController
    struct ViewModel {}
  }
  
  struct Mobile {
    /// Data struct sent to Interactor
    struct Request {}
    /// Data struct sent to Presenter
    struct Response {
      let mobileList: Result<MobileResponse>
    }
    /// Data struct sent to ViewController
    struct ViewModel {
      struct NewMobile {
        let id: Int
        let thumbImageURL: String
        let brand, name, price, rating: String
        var isFavourite: Bool? = false
        let mobileResponseDescription: String
      }
      
      let displayMobile: [NewMobile]
    }
  }
}
