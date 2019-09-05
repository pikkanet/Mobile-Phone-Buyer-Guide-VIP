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
  
  class ProductListInteractorInterfaceSpy: ProductListInteractorInterface {
    
    var doGetPhoneListCalled = false
    var sortPhoneListCalled = false
    var filterPhoneListCalled = false
    var deletePhoneListCalled = false
    var addToFavouriteCalled = false
    
    func doGetPhoneList(request: ProductList.Mobile.Request) {
      doGetPhoneListCalled = true
    }
    
    func sortPhoneList(request: ProductList.SortMobile.Request) {
      sortPhoneListCalled = true
    }
    
    func filterPhoneList(request: ProductList.Filter.Request) {
      filterPhoneListCalled = true
    }
    
    func deletePhoneList(request: ProductList.DeleteRow.Request) {
      deletePhoneListCalled = true
    }
    
    func addToFavourite(request: ProductList.AddToFavourite.Request) {
      addToFavouriteCalled = true
    }
    
  }

  // MARK: - Tests

  func testSomething() {
    // Given

    // When

    // Then
  }
}
