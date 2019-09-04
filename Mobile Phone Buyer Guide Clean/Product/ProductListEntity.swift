//
//  ProductListEntity.swift
//  Mobile Phone Buyer Guide Clean
//
//  Created by Pikkanet Chokwattanapornchai on 2/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import Foundation

/*

 The Entity class is the business object.
 The Result enumeration is the domain model.

 1. Rename this file to the desired name of the model.
 2. Rename the Entity class with the desired name of the model.
 3. Move this file to the Models folder.
 4. If the project already has a declaration of Result enumeration, you may remove the declaration from this file.
 5. Remove the following comments from this file.

 */


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
}

typealias MobileResponse = [MobileResponseElement]
