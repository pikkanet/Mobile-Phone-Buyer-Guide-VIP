//
//  ProductListPresenterTests.swift
//  Mobile Phone Buyer Guide Clean
//
//  Created by Pikkanet Chokwattanapornchai on 4/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

@testable import Mobile_Phone_Buyer_Guide_Clean
import XCTest

class ProductListPresenterTests: XCTestCase {

  // MARK: - Subject under test

  var sut: ProductListPresenter!

  // MARK: - Test lifecycle

  override func setUp() {
    super.setUp()
    setupProductListPresenter()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Test setup

  func setupProductListPresenter() {
    sut = ProductListPresenter()
  }

  // MARK: - Test doubles
  
  class ProductListViewControllerSpy: ProductListViewControllerInterface {
    
    var viewModel: ProductList.Mobile.ViewModel!
    var errorModel: ProductList.Mobile.ErrorModel!
    
    var displayMobileCalled = false
    var displayErrorCalled = false
    
    func displayMobile(viewModel: ProductList.Mobile.ViewModel) {
      displayMobileCalled = true
      self.viewModel = viewModel
    }
    
    func displayError(errorModel: ProductList.Mobile.ErrorModel) {
      displayErrorCalled = true
      self.errorModel = errorModel
    }
    
    
  }

  // MARK: - Tests

  func testDisplayMobileListSuccess() {
    // Given
    let productListViewControllerSpy = ProductListViewControllerSpy()
    sut.viewController = productListViewControllerSpy

    // When
    let elements = MobileResponseElement.init(rating: 4.6, id: 1, thumbImageURL: "URL", price: 19.99, brand: "Nike", name: "Foam", isFavourite: true, mobileResponseDescription: "EiEi")
    let response = ProductList.Mobile.Response(mobileList: Result.success([elements]))
    sut.presentMobile(response: response)

    // Then
    let displayMobiles = productListViewControllerSpy.viewModel.displayMobile
    for displayMobile in displayMobiles {
      XCTAssertEqual(displayMobile.rating, "rating: 4.6")
      XCTAssertEqual(displayMobile.id, 1)
      XCTAssertEqual(displayMobile.thumbImageURL, "URL")
      XCTAssertEqual(displayMobile.price, "price: $19.99")
      XCTAssertEqual(displayMobile.brand, "Nike")
      XCTAssertEqual(displayMobile.name, "Foam")
      XCTAssertEqual(displayMobile.isFavourite, true)
      XCTAssertEqual(displayMobile.mobileResponseDescription, "EiEi")
    }
  }
  
  func testDisplayMobileListFailure() {
    // Given
    let productListViewControllerSpy = ProductListViewControllerSpy()
    sut.viewController = productListViewControllerSpy
    
    // When
    let response = ProductList.Mobile.Response(mobileList: Result.failure(ApiError.CallFail))
    sut.presentMobile(response: response)
//
    // Then
//    let displayError = productListViewControllerSpy.errorModel.errorModel
    XCTAssert(productListViewControllerSpy.displayErrorCalled)
    
  }
}
