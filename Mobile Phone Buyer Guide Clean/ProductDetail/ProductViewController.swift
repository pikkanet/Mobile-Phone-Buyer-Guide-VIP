//
//  ProductViewController.swift
//  Mobile Phone Buyer Guide Clean
//
//  Created by Pikkanet Chokwattanapornchai on 3/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import UIKit
import Kingfisher

protocol ProductViewControllerInterface: class {
  func displayMobile(viewModel: Product.SetData.ViewModel)
  func displayImages(viewModel: Product.GetImage.ViewModel)
  func displayError(errorModel: Product.GetImage.ErrorModel)
}

class ProductViewController: UIViewController, ProductViewControllerInterface {
  var interactor: ProductInteractorInterface!
  var router: ProductRouter!
  
  var mobileImageResponse: MobileImageResponse = []

  @IBOutlet weak var mProductRate: UILabel!
  @IBOutlet weak var mProductPrice: UILabel!
  @IBOutlet weak var mProductDescription: UILabel!
  @IBOutlet weak var mCollectionView: UICollectionView!
  
  // MARK: - Object lifecycle

  override func awakeFromNib() {
    super.awakeFromNib()
    configure(viewController: self)
  }

  // MARK: - Configuration

  private func configure(viewController: ProductViewController) {
    let router = ProductRouter()
    router.viewController = viewController

    let presenter = ProductPresenter()
    presenter.viewController = viewController

    let interactor = ProductInteractor()
    interactor.presenter = presenter
    interactor.worker = ProductWorker(store: ProductStore())

    viewController.interactor = interactor
    viewController.router = router
  }

  // MARK: - View lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupData()
    self.getMobileImage()
  }

  // MARK: - Event handling
  
  // MARK: - Router
  
  func setupData() {
    let request = Product.SetData.Request()
    interactor.setupData(request: request)
  }
  
  func getMobileImage() {
    let request = Product.GetImage.Request()
    interactor.getImageFromApi(request: request)
  }

  func displayMobile(viewModel: Product.SetData.ViewModel) {
    title = viewModel.displayMobile.name
    mProductDescription.text = viewModel.displayMobile.mobileResponseDescription
    mProductPrice.text = viewModel.displayMobile.price
    mProductRate.text = viewModel.displayMobile.rating
  }
  
  func displayImages(viewModel: Product.GetImage.ViewModel) {
    self.mobileImageResponse = viewModel.displayImages
    self.mCollectionView.reloadData()
  }
  
  func displayError(errorModel: Product.GetImage.ErrorModel) {
    showErrorAlert(error: errorModel.displayError)
  }
  
  func showErrorAlert(error: Error) {
    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
    present(alert, animated: true, completion: nil)
  }
  
}

extension ProductViewController:UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.mobileImageResponse.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductImageCollectionViewCell.identifier, for: indexPath) as? ProductImageCollectionViewCell else {
      return UICollectionViewCell()
    }
    let item = self.mobileImageResponse[indexPath.row]
    let image = UIImage(named: "image_not_found")
    if (item.url.contains("http://") || (item.url.contains("https://"))){
      cell.mImage.kf.setImage(with: URL(string: item.url), placeholder: image)
    } else {
      cell.mImage.kf.setImage(with: URL(string: "http://" + item.url), placeholder: image)
    }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: UIScreen.main.bounds.width/2, height: (UIScreen.main.bounds.height * 0.35) - 44)
  }
  
}
