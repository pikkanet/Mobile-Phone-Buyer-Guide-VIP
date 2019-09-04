//
//  ProductListInteractorTests.swift
//  Mobile Phone Buyer Guide Clean
//
//  Created by Pikkanet Chokwattanapornchai on 4/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

@testable import Mobile_Phone_Buyer_Guide_Clean
import XCTest

class ProductListInteractorTests: XCTestCase {

  // MARK: - Subject under test

  var sut: ProductListInteractor!

  // MARK: - Test lifecycle

  override func setUp() {
    super.setUp()
    setupProductListInteractor()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Test setup

  func setupProductListInteractor() {
    sut = ProductListInteractor()
  }

  // MARK: - Test doubles

  // MARK: - Tests

  func testSomething() {
    // Given

    // When

    // Then
  }
}
