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
  
  struct Filter {
    struct Request {
      enum FilterType {
        case All
        case Favourite
      }
      let type: FilterType
    }
  }
  
  struct DeleteRow {
    struct Request {
      let index: Int
    }
  }
  
  struct AddToFavourite {
    struct Request {
      let index: Int
    }
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
  }
  
  struct Mobile {
    /// Data struct sent to Interactor
    struct Request {}
    /// Data struct sent to Presenter
    struct Response {
      let mobileList: Result<MobileResponse, Error>
    }
    /// Data struct sent to ViewController
    struct ViewModel {
      let displayMobile: [NewMobile]
    }
    
    struct ErrorModel {
      let errorModel: Error
    }
  }
}

enum ApiError:Error {
  case CallFail
}
