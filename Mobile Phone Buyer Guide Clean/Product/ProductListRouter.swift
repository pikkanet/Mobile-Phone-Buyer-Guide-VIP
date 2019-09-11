//
//  ProductListRouter.swift
//  Mobile Phone Buyer Guide Clean
//
//  Created by Pikkanet Chokwattanapornchai on 2/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol ProductListRouterInput {
  func navigateToDetailPage(data: MobileViewModel)
}

class ProductListRouter: ProductListRouterInput {
  
  weak var viewController: ProductListViewController!

  // MARK: - Navigation
  
  func navigateToDetailPage(data: MobileViewModel) {
    let storyboard = UIStoryboard(name: "ProductDetail", bundle: nil)
    guard let productViewController = storyboard.instantiateViewController(withIdentifier: "productDetail") as? ProductViewController else {
      return
    }
    productViewController.interactor.mobile = data
    viewController.navigationController?.pushViewController(productViewController, animated: true)
  }

  // MARK: - Communication

}
