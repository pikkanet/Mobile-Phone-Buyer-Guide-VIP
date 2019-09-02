//
//  MobileListsTableViewCell.swift
//  TestCleanSwift
//
//  Created by Pikkanet Chokwattanapornchai on 31/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import UIKit

class MobileListsTableViewCell: UITableViewCell {
  
  @IBOutlet weak var productNameLabel:UILabel!
  @IBOutlet weak var productDescriptionLabel:UILabel!
  @IBOutlet weak var productRateLabel:UILabel!
  @IBOutlet weak var productPriceLabel:UILabel!
  @IBOutlet weak var favouriteButton:UIButton!
  @IBOutlet weak var productImageView:UIImageView!
  
  static let identifier = "MobileListsTableViewCell"
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func setCell(with viewModel: ProductList.Mobile.ViewModel.NewMobile) {
    productNameLabel.text = viewModel.name
    productRateLabel.text = viewModel.rating
    productPriceLabel.text = viewModel.price
    productDescriptionLabel.text = viewModel.mobileResponseDescription
    let image = UIImage(named: "Image_not_Found")
    productImageView.kf.setImage(with: URL(string: viewModel.thumbImageURL), placeholder: image)
  }
  
}
