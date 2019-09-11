//
//  ProductListModels.swift
//  Mobile Phone Buyer Guide Clean
//
//  Created by Pikkanet Chokwattanapornchai on 2/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

struct ProductList {
  
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
      let displayMobile: [MobileViewModel]
    }
    
    struct ErrorModel {
      let errorModel: Error
    }
  }
}

struct MobileViewModel {
  let id: Int
  let thumbImageURL: String
  let brand, name, price, rating: String
  var isFavourite: Bool? = false
  let mobileResponseDescription: String
}

enum ApiError:Error {
  case CallFail
}
