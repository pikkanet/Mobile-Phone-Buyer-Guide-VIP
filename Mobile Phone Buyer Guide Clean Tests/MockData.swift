//
//  MockProductList.swift
//  Mobile Phone Buyer Guide Clean Tests
//
//  Created by Pikkanet Chokwattanapornchai on 6/9/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

@testable import Mobile_Phone_Buyer_Guide_Clean
import XCTest

struct Seeds {
  struct Products {
    static let mobileElement = MobileResponseElement(rating: 3.5, id: 1, thumbImageURL: "String", price: 19.99, brand: "Nike", name: "Nike", isFavourite: true, mobileResponseDescription: "String")
    static let mobileElement2 = MobileResponseElement(rating: 4.5, id: 2, thumbImageURL: "String", price: 9.00, brand: "Nike", name: "Nike", isFavourite: false, mobileResponseDescription: "String")
    static let mobileElement3 = MobileResponseElement(rating: 2.5, id: 3, thumbImageURL: "String", price: 15.99, brand: "Nike", name: "Nike", isFavourite: false, mobileResponseDescription: "String")
    static let mobileElement4 = MobileResponseElement(rating: 2.0, id: 4, thumbImageURL: "String", price: 15.99, brand: "Nike", name: "Nike", isFavourite: true, mobileResponseDescription: "String")
    
    static let mobiles = [mobileElement, mobileElement2, mobileElement3]
  }
}
