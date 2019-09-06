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
  
  // not success
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
    //then
    XCTAssertTrue(presenter.presentMobileCalled)
  }
  
  func testClickAllButton() {
    // given
    let mobilesArray = Seeds.Products.mobiles
    //    let tmp = mobilesArray
    sut.mobiles = mobilesArray
    sut.tmp_mobiles = mobilesArray
    
    //when
    let request = ProductList.Filter.Request(type: .All)
    sut.filterPhoneList(request: request)
    
    //then
    XCTAssertEqual(sut.mobiles?.count, 3)
  }
  
  //  func test
  
  func testClickFavouriteButton() {
    // given
    let mobilesArray = Seeds.Products.mobiles
    sut.mobiles = mobilesArray
    sut.tmp_mobiles = mobilesArray
    
    //when
    let request = ProductList.Filter.Request(type: .Favourite)
    sut.filterPhoneList(request: request)
    
    //then
    XCTAssertEqual(sut.mobiles?.count, 1)
  }
  
  func testSortPriceHighToLow() {
    // given
    let mobilesArray = Seeds.Products.mobiles
    sut.mobiles = mobilesArray
    sut.tmp_mobiles = mobilesArray
    
    // when
    let request = ProductList.SortMobile.Request(type: .priceHighToLow)
    sut.sortPhoneList(request: request)
    
    // then
    let expectedResult: MobileResponse = [Seeds.Products.mobileElement, Seeds.Products.mobileElement3, Seeds.Products.mobileElement2]
    XCTAssertEqual(sut.mobiles, expectedResult)
    
  }
  
  func testSortPriceLowToHigh() {
    // given
    let mobilesArray = Seeds.Products.mobiles
    sut.mobiles = mobilesArray
    sut.tmp_mobiles = mobilesArray
    
    // when
    let request = ProductList.SortMobile.Request(type: .priceLowToHigh)
    sut.sortPhoneList(request: request)
    
    // then
    let expectedResult: MobileResponse = [Seeds.Products.mobileElement2, Seeds.Products.mobileElement3, Seeds.Products.mobileElement]
    XCTAssertEqual(sut.mobiles, expectedResult)
  }
  
  func testSortPriceRate() {
    // given
    let mobilesArray = Seeds.Products.mobiles
    sut.mobiles = mobilesArray
    sut.tmp_mobiles = mobilesArray
    
    // when
    let request = ProductList.SortMobile.Request(type: .rate)
    sut.sortPhoneList(request: request)
    
    // then
    let expectedResult: MobileResponse = [Seeds.Products.mobileElement2, Seeds.Products.mobileElement, Seeds.Products.mobileElement3]
    XCTAssertEqual(sut.mobiles, expectedResult)
  }
  
  func testClickFavouriteInUnfavourite() {
    // given
    let mobilesArray = Seeds.Products.mobiles
    sut.mobiles = mobilesArray
    let index = 1
    // when
    let request = ProductList.AddToFavourite.Request(index: index)
    sut.addToFavourite(request: request)
    
    // then
    if let result = sut.mobiles?[index].isFavourite{
      XCTAssertTrue(result)
    }
  }
  
  func testClickFavouriteInFavourite() {
    // given
    let mobilesArray = Seeds.Products.mobiles
    sut.mobiles = mobilesArray
    let index = 0
    
    // when
    let request = ProductList.AddToFavourite.Request(index: index)
    sut.addToFavourite(request: request)
    
    // then
    if let result = sut.mobiles?[index].isFavourite{
      XCTAssertFalse(result)
    }
  }

  func testRemoveFromFavourite() {
    // given
    let mobilesArray = [Seeds.Products.mobileElement, Seeds.Products.mobileElement4]
    sut.mobiles = mobilesArray
    sut.tmp_mobiles = Seeds.Products.mobiles
    let index = 0
    let mobileCount = sut.mobiles?.count
    
    // when
    let request = ProductList.DeleteRow.Request(index: index)
    sut.deletePhoneList(request: request)
    
    // then
    let expectedMobileCount = mobileCount! - 1
    XCTAssertEqual(sut.mobiles?.count, expectedMobileCount )
    
  }
  
}
