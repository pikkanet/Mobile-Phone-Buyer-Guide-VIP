//
//  ProductStore.swift
//  Mobile Phone Buyer Guide Clean
//
//  Created by Pikkanet Chokwattanapornchai on 3/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import Alamofire
import Foundation

/*

 The ProductStore class implements the ProductStoreProtocol.

 The source for the data could be a database, cache, or a web service.

 You may remove these comments from the file.

 */

class ProductStore: ProductStoreProtocol {
  func getImages(index: Int,_ completion: @escaping (Result<MobileImageResponse, Error>) -> Void) {
    guard let url = URL(string: "https://scb-test-mobile.herokuapp.com/api/mobiles/\(index)/images/") else {
      return
    }
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    AF.request(request).responseJSON { response in
      switch response.result {
      case .success(_):
        do {
          guard let data = response.data else {
            return
          }
          let decoder = JSONDecoder()
          let result = try decoder.decode(MobileImageResponse.self, from: data)
          completion(Result.success(result))
        } catch let error{
          completion(Result.failure(error))
        }
      case let .failure(error):
        completion(Result.failure(error))
      }
    }
  }
  
}
