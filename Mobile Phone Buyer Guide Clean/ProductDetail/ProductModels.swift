//
//  ProductModels.swift
//  Mobile Phone Buyer Guide Clean
//
//  Created by Pikkanet Chokwattanapornchai on 3/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

struct Product {
  /// This structure represents a use case
  
  struct SetData {
    struct Request {}
    struct Response {
      let mobile: NewMobile
    }
    struct ViewModel {
      let displayMobile: NewMobile
    }
  }
  
  struct GetImage {
    /// Data struct sent to Interactor
    struct Request {}
    /// Data struct sent to Presenter
    struct Response {
      let images: Result<MobileImageResponse>
    }
    /// Data struct sent to ViewController
    struct ViewModel {
      let displayImages: MobileImageResponse
    }
    struct ErrorModel {
      let displayError: Error
    }
  }

}
