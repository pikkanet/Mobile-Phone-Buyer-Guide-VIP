//
//  ProductEntity.swift
//  Mobile Phone Buyer Guide Clean
//
//  Created by Pikkanet Chokwattanapornchai on 3/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import Foundation


// MARK: - MobileImageResponseElement
struct MobileImageResponseElement: Codable {
  let mobileID: Int
  var url: String
  let id: Int
  
  enum CodingKeys: String, CodingKey {
    case mobileID = "mobile_id"
    case url, id
  }
}

typealias MobileImageResponse = [MobileImageResponseElement]
