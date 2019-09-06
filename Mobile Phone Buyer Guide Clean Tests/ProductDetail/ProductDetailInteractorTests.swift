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
  
  class ProductWorkerSpy: ProductWorker {
    
    var isSuccess = false
    
    override func getPhoneImages(index: Int, _ completion: @escaping (Result<MobileImageResponse, Error>) -> Void) {
      if isSuccess {
        let response = MobileImageResponseElement(mobileID: 1, url: "Url", id: 1)
        completion(.success([response]))
      }else {
        completion(.failure(ApiError.CallFail))
      }
    }
  }
  
  class ProductPresenterSpy: ProductPresenterInterface {
    
    var isPresentDataCalled = false
    var isPresentImageCalled = false
    
    func presentData(viewModel: Product.SetData.ViewModel) {
      isPresentDataCalled = true
    }
    
    func presentImage(response: Product.GetImage.Response) {
      isPresentImageCalled = true
    }
  }

  // MARK: - Tests

  func testSetupDataCall() {
    // Given
    let presenter = ProductPresenterSpy()
    sut.presenter = presenter
    
    // When
    let request = Product.SetData.Request()
    sut.mobile = NewMobile(id: 1, thumbImageURL: "Url", brand: "Nike", name: "Foam", price: "19.99", rating: "1.9", isFavourite: true, mobileResponseDescription: "FoamFoam")
    sut.setupData(request: request)
    
    // Then
    XCTAssert(presenter.isPresentDataCalled)
  }
  
  func testCallImageSuccess() {
    // given
    let presenter = ProductPresenterSpy()
    sut.presenter = presenter
    let worker = ProductWorkerSpy(store: ProductStore())
    worker.isSuccess = true
    sut.worker = worker
    
    // when
    sut.mobile = NewMobile(id: 1, thumbImageURL: "Url", brand: "Nike", name: "Foam", price: "19.99", rating: "1.9", isFavourite: true, mobileResponseDescription: "FoamFoam")
    let request = Product.GetImage.Request()
    sut.getImageFromApi(request: request)
    
    // then
    XCTAssert(presenter.isPresentImageCalled)
  }
  
  func testCallImageFailure() {
    // given
    let presenter = ProductPresenterSpy()
    sut.presenter = presenter
    let worker = ProductWorkerSpy(store: ProductStore())
    worker.isSuccess = false
    sut.worker = worker
    
    // when
    sut.mobile = NewMobile(id: 1, thumbImageURL: "Url", brand: "Nike", name: "Foam", price: "19.99", rating: "1.9", isFavourite: true, mobileResponseDescription: "FoamFoam")
    let request = Product.GetImage.Request()
    sut.getImageFromApi(request: request)
    
    // then
    XCTAssert(presenter.isPresentImageCalled)
  }
  
}
