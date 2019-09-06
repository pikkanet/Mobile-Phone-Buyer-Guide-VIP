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
    sut.presenter = ProductListPresenterSpy()
    sut.worker = ProductListWorkerSpy(store: ProductListStore())
  }
  
  // MARK: - Test doubles
  
  class ProductListWorkerSpy: ProductListWorker {
    
    var isSuccess = true
    var isDataEmpty = false
    var getMobilesCalled = false
    
    override func getPhone(_ completion: @escaping (Result<MobileResponse, Error>) -> Void) {
      //getMobilesCalled = true
//      if isDataEmpty {
////        var response = MobileResponse()
////        response = nil
//        completion(.success(MobileResponse()))
//      }
      let response = MobileResponseElement.init(rating: 4.6, id: 1, thumbImageURL: "URL", price: 19.99, brand: "Nike", name: "Foam", isFavourite: true, mobileResponseDescription: "EiEi")
      if isSuccess {
        completion(.success([response]))
      } else {
        completion(.failure(ApiError.CallFail))
      }
    }
    
  }
  
  class ProductListPresenterSpy: ProductListPresenterInterface {
    var presentMobileCalled = false
    var isCallSuccess = false
    
    func presentMobile(response: ProductList.Mobile.Response) {
      presentMobileCalled = true
    }
    
  }
  
  // MARK: - Tests
  
  func testCallPhoneListSuccess() {
    // Given
    let presenter = ProductListPresenterSpy()
    sut.presenter = presenter
  
    
    // When
    let request = ProductList.Mobile.Request()
    sut.doGetPhoneList(request: request)
    
    // Then
    XCTAssertTrue(presenter.presentMobileCalled)
  }
  
  func testCallPhoneListSuccessButEmptyData() {
    // given
    let presenter = ProductListPresenterSpy()
    
    sut.presenter = presenter
    let worker = ProductListWorkerSpy(store: ProductListStore())
    worker.isDataEmpty = true
    sut.worker = worker
    // When
    let request = ProductList.Mobile.Request()
    sut.doGetPhoneList(request: request)
    sut.mobiles = nil
    //    sut.presenter.
    
    //then
    XCTAssertTrue(presenter.presentMobileCalled)
    
  }
  
  func testCallPhoneListFailureWhenCallApi() {
    //given
    let presenter = ProductListPresenterSpy()
    sut.presenter = presenter
    let worker = ProductListWorkerSpy(store: ProductListStore())
    worker.isSuccess = false
    sut.worker = worker
  
    // When
    let request = ProductList.Mobile.Request()
    sut.doGetPhoneList(request: request)
//    sut.presenter.
    
    //then
    XCTAssertTrue(presenter.presentMobileCalled)
  }
  
  func testClickAllButton() {
    // given
    let mobileElement = MobileResponseElement(rating: 3.5, id: 1, thumbImageURL: "String", price: 19.99, brand: "Nike", name: "Nike", isFavourite: true, mobileResponseDescription: "String")
    let mobileElement2 = MobileResponseElement(rating: 4.5, id: 2, thumbImageURL: "String", price: 9.99, brand: "Nike", name: "Nike", isFavourite: false, mobileResponseDescription: "String")
    let mobilesArray = [mobileElement, mobileElement2]
    //    let tmp = mobilesArray
    sut.mobiles = mobilesArray
    sut.tmp_mobiles = mobilesArray
    
    //when
    let request = ProductList.Filter.Request(type: .All)
    sut.filterPhoneList(request: request)
    
    //then
    XCTAssertEqual(sut.mobiles?.count, 2)
  }
  
  //  func test
  
  func testClickFavouriteButton() {
    // given
    let mobileElement = MobileResponseElement(rating: 3.5, id: 1, thumbImageURL: "String", price: 19.99, brand: "Nike", name: "Nike", isFavourite: true, mobileResponseDescription: "String")
    let mobileElement2 = MobileResponseElement(rating: 4.5, id: 2, thumbImageURL: "String", price: 9.99, brand: "Nike", name: "Nike", isFavourite: false, mobileResponseDescription: "String")
    let mobilesArray = [mobileElement, mobileElement2]
    //    let tmp = mobilesArray
    sut.mobiles = mobilesArray
    sut.tmp_mobiles = mobilesArray
    
    //when
    let request = ProductList.Filter.Request(type: .Favourite)
    sut.filterPhoneList(request: request)
    
    //then
    XCTAssertEqual(sut.mobiles?.count, 1)
  }
  
  
}
