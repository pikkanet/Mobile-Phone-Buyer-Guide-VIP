//
//  ProductDetailInteractorTests.swift
//  Mobile Phone Buyer Guide Clean
//
//  Created by Pikkanet Chokwattanapornchai on 6/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

@testable import Mobile_Phone_Buyer_Guide_Clean
import XCTest

class ProductDetailInteractorTests: XCTestCase {

  // MARK: - Subject under test

  var sut: ProductInteractor!

  // MARK: - Test lifecycle

  override func setUp() {
    super.setUp()
    setupProductDetailInteractor()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Test setup

  func setupProductDetailInteractor() {
    sut = ProductInteractor()
  }

  // MARK: - Test doubles

  // MARK: - Tests

  func testSomething() {
    // Given

    // When

    // Then
  }
}
