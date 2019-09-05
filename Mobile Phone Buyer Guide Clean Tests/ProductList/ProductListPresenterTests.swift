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
  
  class ProductListPresenterInterfaceSpy: ProductListPresenterInterface{
    
    var presentMobileCalled = false
    
    func presentMobile(response: ProductList.Mobile.Response) {
      presentMobileCalled = true
    }
    
  }

  // MARK: - Tests

  func testSomething() {
    // Given

    // When

    // Then
  }
}
