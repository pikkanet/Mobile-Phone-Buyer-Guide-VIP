//
//  ProductPresenter.swift
//  Mobile Phone Buyer Guide Clean
//
//  Created by Pikkanet Chokwattanapornchai on 3/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit

protocol ProductPresenterInterface {
  func presentData(viewModel: Product.SetData.ViewModel)
  func presentImage(response: Product.GetImage.Response)
}

class ProductPresenter: ProductPresenterInterface {
  weak var viewController: ProductViewControllerInterface!

  // MARK: - Presentation logic
  
  func presentData(viewModel: Product.SetData.ViewModel) {
    viewController.displayMobile(viewModel: viewModel)
  }
  
  func presentImage(response: Product.GetImage.Response) {
    switch response.images {
    case .success(let data):
      let viewModel = Product.GetImage.ViewModel(displayImages: data)
      viewController.displayImages(viewModel: viewModel)
    case .failure(let error):
      let errorModel = Product.GetImage.ErrorModel(displayError: error)
      viewController.displayError(errorModel: errorModel)
    }
  }
  
}
