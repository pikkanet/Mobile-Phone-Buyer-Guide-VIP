//
//  ProductListEntity.swift
//  Mobile Phone Buyer Guide Clean
//
//  Created by Pikkanet Chokwattanapornchai on 2/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import Foundation

//
// The entity or business object
//


struct MobileResponseElement: Codable {
  let rating: Double
  let id: Int
  let thumbImageURL: String
  let price: Double
  let brand, name: String
  var isFavourite: Bool
  let mobileResponseDescription: String
  
  enum CodingKeys: String, CodingKey {
    case rating, id, thumbImageURL, price, brand, name, isFavourite
    case mobileResponseDescription = "description"
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.isFavourite = try container.decodeIfPresent(Bool.self, forKey: .isFavourite) ?? false
    self.rating = try container.decodeIfPresent(Double.self, forKey: .rating) ?? 0.0
    self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
    self.thumbImageURL = try container.decodeIfPresent(String.self, forKey: .thumbImageURL) ?? ""
    self.price = try container.decodeIfPresent(Double.self, forKey: .price) ?? 0.0
    self.brand = try container.decodeIfPresent(String.self, forKey: .brand) ?? ""
    self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
    self.mobileResponseDescription = try container.decodeIfPresent(String.self, forKey: .mobileResponseDescription) ?? ""
  }
  
  init(rating: Double, id: Int, thumbImageURL: String, price: Double, brand: String, name: String,isFavourite: Bool, mobileResponseDescription: String) {
    self.rating = rating
    self.id = id
    self.thumbImageURL = thumbImageURL
    self.price = price
    self.brand = brand
    self.name = name
    self.isFavourite = isFavourite
    self.mobileResponseDescription = mobileResponseDescription
  }
  
}

typealias MobileResponse = [MobileResponseElement]

extension MobileResponseElement: Equatable {
  static func == (lhs: MobileResponseElement, rhs: MobileResponseElement) -> Bool {
    return lhs.name == rhs.name &&
      lhs.brand == rhs.brand &&
      lhs.mobileResponseDescription == rhs.mobileResponseDescription &&
      lhs.id == rhs.id &&
      lhs.isFavourite == rhs.isFavourite &&
      lhs.rating == rhs.rating &&
      lhs.price == rhs.price &&
      lhs.thumbImageURL == rhs.thumbImageURL
  }
}

