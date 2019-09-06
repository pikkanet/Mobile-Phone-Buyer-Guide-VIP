//
//  ProductDetailPresenterTests.swift
//  Mobile Phone Buyer Guide Clean
//
//  Created by Pikkanet Chokwattanapornchai on 6/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

@testable import Mobile_Phone_Buyer_Guide_Clean
import XCTest

class ProductDetailPresenterTests: XCTestCase {
  
  // MARK: - Subject under test
  
  var sut: ProductPresenter!
  
  // MARK: - Test lifecycle
  
  override func setUp() {
    super.setUp()
    setupProductDetailPresenter()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  // MARK: - Test setup
  
  func setupProductDetailPresenter() {
    sut = ProductPresenter()
  }
  
  class ProductViewControllerInterfaceSpy: ProductViewControllerInterface {
    var viewModel: Product.SetData.ViewModel!
    var imageModel: Product.GetImage.ViewModel!
    var errorModel: Product.GetImage.ErrorModel!
    
    var isDisplayMobile = false
    var isDisplayImage = false
    var isDisplayError = false
    
    func displayMobile(viewModel: Product.SetData.ViewModel) {
      isDisplayMobile = true
      self.viewModel = viewModel
    }
    
    func displayImages(viewModel: Product.GetImage.ViewModel) {
      isDisplayImage = true
      self.imageModel = viewModel
    }
    
    func displayError(errorModel: Product.GetImage.ErrorModel) {
      isDisplayError = true
      self.errorModel = errorModel
    }
    
  }
  
  // MARK: - Test doubles
  
  // MARK: - Tests
  
  func testGetDataFromProductPageSuccess() {
    // Given
    let productViewControllerInterfaceSpy = ProductViewControllerInterfaceSpy()
    sut.viewController = productViewControllerInterfaceSpy

    // When
    let mobile = NewMobile(id: 1, thumbImageURL: "Url", brand: "Nike", name: "Foam", price: "price: $19.99", rating: "rating: 4.5", isFavourite: true, mobileResponseDescription: "Nike")
    let viewmodel = Product.SetData.ViewModel(displayMobile: mobile)
    sut.presentData(viewModel: viewmodel)
    
    // Then
    XCTAssert(productViewControllerInterfaceSpy.isDisplayMobile)
//    XCTAssert(sut.viewController.i)
    
  }
}
