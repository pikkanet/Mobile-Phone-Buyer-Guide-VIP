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
  func displaySomething(viewModel: ProductList.Something.ViewModel)
  func displayMobile(viewModel: ProductList.Mobile.ViewModel)
}

class ProductListViewController: UIViewController, ProductListViewControllerInterface {
  var interactor: ProductListInteractorInterface!
  var router: ProductListRouter!
  var displayTableView: [ProductList.Mobile.ViewModel.NewMobile] = []
  
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
    doSomethingOnLoad()
    doGetPhoneListOnLoad()
  }
  
  // MARK: - Event handling
  
  func setupNavigationBar() {
    let sort = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(onSort))
    navigationItem.rightBarButtonItems = [sort]
  }
  
  func setupTableView() {
    mTableView.register(UINib(nibName: MobileListsTableViewCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: MobileListsTableViewCell.identifier)
//    mTableView.estimatedRowHeight = 110
//    mTableView.rowHeight = UITableView.automaticDimension
  }
  
  func doGetPhoneListOnLoad() {
    let request = ProductList.Mobile.Request()
    interactor.doGetPhoneList(request: request)
  }
  
  
  func doSomethingOnLoad() {
    // NOTE: Ask the Interactor to do some work
    
    let request = ProductList.Something.Request()
    interactor.doSomething(request: request)
  }
  
  // MARK: - Display logic
  
  func displaySomething(viewModel: ProductList.Something.ViewModel) {
    // NOTE: Display the result from the Presenter
    
    // nameTextField.text = viewModel.name
  }
  
  func displayMobile(viewModel: ProductList.Mobile.ViewModel) {
//    print(viewModel)
    self.displayTableView = viewModel.displayMobile
//    print(self.displayTableView)
    self.mTableView.reloadData()
  }
  
  // MARK: - Router
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    router.passDataToNextScene(segue: segue)
  }
  
  @IBAction func unwindToProductListViewController(from segue: UIStoryboardSegue) {
    print("unwind...")
    router.passDataToNextScene(segue: segue)
  }
  
  func sortMobiles(type: ProductList.SortMobile.Request.SortType){
    let request = ProductList.SortMobile.Request(type: type)
    interactor.sortPhoneList(request: request)
  }
  
}

extension ProductListViewController {
  
  @objc func onSort(){
    let alert = UIAlertController(title: "Sort", message: "", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Price low to high", style: .default, handler: {(_: UIAlertAction!) in
      self.sortMobiles(type: ProductList.SortMobile.Request.SortType.priceLowToHigh)
      self.mTableView.reloadData()
    }))
    alert.addAction(UIAlertAction(title: "Price high to low", style: .default, handler: {(_: UIAlertAction!) in
      self.sortMobiles(type: ProductList.SortMobile.Request.SortType.priceHighToLow)
      self.mTableView.reloadData()
    }))
    alert.addAction(UIAlertAction(title: "Rating", style: .default, handler: {(_: UIAlertAction!) in
      self.sortMobiles(type: ProductList.SortMobile.Request.SortType.rate)
      self.mTableView.reloadData()
    }))
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    self.present(alert, animated: true)
  }
  
  @IBAction func onClickAll(_ sender: Any) {
    print("All")
    self.isFavorite = false
    self.mTableView.reloadData()
    self.mAllButton.alpha = 0.78
    self.mFavouriteButton.alpha = 0.38
  }
  
  @IBAction func onClickFavorite(_ sender: Any) {
    print("Fav")
    self.isFavorite = true
    self.mTableView.reloadData()
    self.mAllButton.alpha = 0.38
    self.mFavouriteButton.alpha = 0.78
  }
}

extension ProductListViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.displayTableView.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: MobileListsTableViewCell.identifier, for: indexPath) as? MobileListsTableViewCell else {
      fatalError("Wrong Cell")
    }
    let viewModel = displayTableView[indexPath.row]
    cell.setCell(with: viewModel)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    print(indexPath.row)
  }
  
  func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    if(self.isFavorite!){
      return UITableViewCell.EditingStyle.delete
    }
    return UITableViewCell.EditingStyle.none
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      self.mTableView.deleteRows(at: [indexPath], with: .fade)
    }
    self.mTableView.reloadData()
  }
  
}
