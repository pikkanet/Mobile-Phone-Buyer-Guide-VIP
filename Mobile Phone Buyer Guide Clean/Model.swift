//
//  Model.swift
//  Mobile Phone Buyer Guide Clean
//
//  Created by Pikkanet Chokwattanapornchai on 3/9/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import Foundation

enum Result<T> {
  case success(T)
  case failure(Error)
}

struct NewMobile {
  let id: Int
  let thumbImageURL: String
  let brand, name, price, rating: String
  var isFavourite: Bool? = false
  let mobileResponseDescription: String
}
