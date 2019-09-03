//
//  ProductListRouter.swift
//  Mobile Phone Buyer Guide Clean
//
//  Created by Pikkanet Chokwattanapornchai on 2/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol ProductListRouterInput {
  func navigateToSomewhere()
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

  func navigateToSomewhere() {
    // NOTE: Teach the router how to navigate to another scene. Some examples follow:

    // 1. Trigger a storyboard segue
    // viewController.performSegueWithIdentifier("ShowSomewhereScene", sender: nil)

    // 2. Present another view controller programmatically
    // viewController.presentViewController(someWhereViewController, animated: true, completion: nil)

    // 3. Ask the navigation controller to push another view controller onto the stack
    // viewController.navigationController?.pushViewController(someWhereViewController, animated: true)

    // 4. Present a view controller from a different storyboard
    // let storyboard = UIStoryboard(name: "OtherThanMain", bundle: nil)
    // let someWhereViewController = storyboard.instantiateInitialViewController() as! SomeWhereViewController
    // viewController.navigationController?.pushViewController(someWhereViewController, animated: true)
  }

  // MARK: - Communication

  func passDataToNextScene(segue: UIStoryboardSegue, data: NewMobile) {
    // NOTE: Teach the router which scenes it can communicate with
    print(data)
    if segue.identifier == "showDetail" {
      passDataToSomewhereScene(segue: segue)
    }
  }

  func passDataToSomewhereScene(segue: UIStoryboardSegue) {
    // NOTE: Teach the router how to pass data to the next scene

    // let someWhereViewController = segue.destinationViewController as! SomeWhereViewController
    // someWhereViewController.interactor.model = viewController.interactor.model
  }
}