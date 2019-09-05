//
//  ProductListStore.swift
//  Mobile Phone Buyer Guide Clean
//
//  Created by Pikkanet Chokwattanapornchai on 2/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import Alamofire
import Foundation

/*

 The ProductListStore class implements the ProductListStoreProtocol.

 The source for the data could be a database, cache, or a web service.

 You may remove these comments from the file.

 */

class ProductListStore: ProductListStoreProtocol {
  
  func getMobiles(_ completion: @escaping ( Result<MobileResponse, Error>) -> Void){
    guard let url = URL(string: "https://scb-test-mobile.herokuapp.com/api/mobiles/") else {
      return
    }
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    AF.request(request).responseJSON { response in
      switch response.result {
      case .success(_):
        do {
          let decoder = JSONDecoder()
          guard let data = response.data else {
            return
          }
          let result = try decoder.decode(MobileResponse.self, from: data)
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
