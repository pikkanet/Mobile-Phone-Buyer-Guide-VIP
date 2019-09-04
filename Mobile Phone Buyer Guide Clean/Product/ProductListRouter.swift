//
//  ProductListRouter.swift
//  Mobile Phone Buyer Guide Clean
//
//  Created by Pikkanet Chokwattanapornchai on 2/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol ProductListRouterInput {
  func navigateToDetailPage(data: NewMobile)
}

class ProductListRouter: ProductListRouterInput {
  
  weak var viewController: ProductListViewController!

  // MARK: - Navigation
  
  func navigateToDetailPage(data: NewMobile) {
    let storyboard = UIStoryboard(name: "ProductDetail", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "productDetail") as! ProductViewController
    vc.interactor.mobile = data
    viewController.navigationController?.pushViewController(vc, animated: true)
  }

  // MARK: - Communication

}
