//
//  ProductListViewController.swift
//  Mobile Phone Buyer Guide Clean
//
//  Created by Pikkanet Chokwattanapornchai on 2/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import Kingfisher
import UIKit

protocol ProductListViewControllerInterface: class {
  func displayMobile(viewModel: ProductList.Mobile.ViewModel)
  func displayError(errorModel: ProductList.Mobile.ErrorModel)
}

protocol MyCellDelegate: class {
  func didTapButtonInCell(_ cell: MobileListsTableViewCell)
}

class ProductListViewController: UIViewController, ProductListViewControllerInterface {
  var interactor: ProductListInteractorInterface!
  var router: ProductListRouter!
  var displayTableView: [NewMobile] = []
  
  @IBOutlet weak var mAllButton:UIButton!
  @IBOutlet weak var mFavouriteButton:UIButton!
  
  var selectedIndex:Int?
  var id:Int?
  var isFavorite:Bool? = false
  
  @IBOutlet weak var mTableView: UITableView!
  
  
  // MARK: - Object lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configure(viewController: self)
  }
  
  // MARK: - Configuration
  
  private func configure(viewController: ProductListViewController) {
    let router = ProductListRouter()
    router.viewController = viewController
    
    let presenter = ProductListPresenter()
    presenter.viewController = viewController
    
    let interactor = ProductListInteractor()
    interactor.presenter = presenter
    interactor.worker = ProductListWorker(store: ProductListStore())
    
    viewController.interactor = interactor
    viewController.router = router
  }
  
  // MARK: - View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupNavigationBar()
    setupTableView()
    doGetPhoneListOnLoad()
  }
  
  // MARK: - Event handling
  
  func setupNavigationBar() {
    let sort = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(onSort))
    navigationItem.rightBarButtonItems = [sort]
  }
  
  func setupTableView() {
    mTableView.register(UINib(nibName: MobileListsTableViewCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: MobileListsTableViewCell.identifier)
  }
  
  func doGetPhoneListOnLoad() {
    let request = ProductList.Mobile.Request()
    interactor.doGetPhoneList(request: request)
  }
  
  func displayMobile(viewModel: ProductList.Mobile.ViewModel) {
    self.displayTableView = viewModel.displayMobile
    mTableView.estimatedRowHeight = 500
    mTableView.rowHeight = UITableView.automaticDimension
    self.mTableView.reloadData()
  }
  
  func displayError(errorModel: ProductList.Mobile.ErrorModel) {
    showErrorAlert(error: errorModel.errorModel)
  }
  
  func sortMobiles(type: ProductList.SortMobile.Request.SortType){
    let request = ProductList.SortMobile.Request(type: type)
    interactor.sortPhoneList(request: request)
  }
  
  
  func showErrorAlert(error: Error) {
    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
    present(alert, animated: true, completion: nil)
  }
  
}

extension ProductListViewController {
  
  @objc func onSort(){
    let alert = UIAlertController(title: "Sort", message: "", preferredStyle: .alert)
    let sortType = ProductList.SortMobile.Request.SortType.self
    alert.addAction(UIAlertAction(title: "Price low to high", style: .default, handler: {(_: UIAlertAction!) in
      self.sortMobiles(type: sortType.priceLowToHigh)
      self.mTableView.reloadData()
    }))
    alert.addAction(UIAlertAction(title: "Price high to low", style: .default, handler: {(_: UIAlertAction!) in
      self.sortMobiles(type: sortType.priceHighToLow)
      self.mTableView.reloadData()
    }))
    alert.addAction(UIAlertAction(title: "Rating", style: .default, handler: {(_: UIAlertAction!) in
      self.sortMobiles(type: sortType.rate)
      self.mTableView.reloadData()
    }))
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    self.present(alert, animated: true)
  }
  
  @IBAction func onClickAll(_ sender: Any) {
    let request = ProductList.Filter.Request(type: ProductList.Filter.Request.FilterType.All)
    interactor.filterPhoneList(request: request)
    self.isFavorite = false
    self.mTableView.reloadData()
    self.mAllButton.alpha = 0.78
    self.mFavouriteButton.alpha = 0.38
  }
  
  @IBAction func onClickFavorite(_ sender: Any) {
    let request = ProductList.Filter.Request(type: ProductList.Filter.Request.FilterType.Favourite)
    interactor.filterPhoneList(request: request)
    self.isFavorite = true
    self.mTableView.reloadData()
    self.mAllButton.alpha = 0.38
    self.mFavouriteButton.alpha = 0.78
  }
}

extension ProductListViewController: UITableViewDataSource, UITableViewDelegate, MyCellDelegate {
  func didTapButtonInCell(_ cell: MobileListsTableViewCell) {
    let request = ProductList.AddToFavourite.Request(index: cell.favouriteButton.tag)
    interactor.addToFavourite(request: request)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.displayTableView.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: MobileListsTableViewCell.identifier, for: indexPath) as? MobileListsTableViewCell else {
      fatalError("Wrong Cell")
    }
    let viewModel = displayTableView[indexPath.row]
    cell.setCell(with: viewModel)
    cell.favouriteButton.tag = indexPath.row
    cell.delegate = self as MyCellDelegate
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    router.navigateToDetailPage(data: displayTableView[indexPath.row])
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    if(self.isFavorite!){
      return UITableViewCell.EditingStyle.delete
    }
    return UITableViewCell.EditingStyle.none
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let request = ProductList.DeleteRow.Request(index: indexPath.row)
      interactor.deletePhoneList(request: request)
    }
    self.mTableView.reloadData()
  }
  
}
