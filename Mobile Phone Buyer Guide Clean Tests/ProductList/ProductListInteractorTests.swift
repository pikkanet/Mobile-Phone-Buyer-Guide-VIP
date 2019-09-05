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

  // clear mem
  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Test setup

  func setupProductListInteractor() {
    sut = ProductListInteractor()
  }

  // MARK: - Test doubles
  
  class ProductListWorkerSpy: ProductListWorker {
    var getMobilesCalled = false
    
    override func getPhone(_ completion: @escaping (Result<MobileResponse, Error>) -> Void) {
      getMobilesCalled = true
      let response = MobileResponseElement.init(rating: 4.6, id: 1, thumbImageURL: "URL", price: 19.99, brand: "Nike", name: "Foam", isFavourite: true, mobileResponseDescription: "EiEi")
      completion(.success([response]))
    }
  }
  
  class ProductListPresenterSpy: ProductListPresenterInterface{
    var presentMobileCalled = false
    
    func presentMobile(response: ProductList.Mobile.Response) {
      presentMobileCalled = true
    }
    
  }

  // MARK: - Tests

  func testCallPhoneList() {
    // Given
    // input
    let productListPresentSpy = ProductListPresenterSpy()
    sut.presenter = productListPresentSpy
    let productListWorkerSpy = ProductListWorkerSpy(store: ProductListStore())
    sut.worker = productListWorkerSpy
    
    // When
    let request = ProductList.Mobile.Request()
    sut.doGetPhoneList(request: request)

    // Then
    XCTAssertTrue(productListWorkerSpy.getMobilesCalled)
    
  }
}
