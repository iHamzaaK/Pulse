//
//  CategoriesCollectionViewCell.swift
//  Pulse
//
//  Created by Hamza Khan on 10/11/2020.
//

import UIKit

final class CategoriesCollectionViewCell: UICollectionViewCell {
  var categoryID : Int!
  var categoryDescription : String!
  var parentID : Int!
  var children : [CategoriesChild]!
  var cellViewModel : CategoryCellViewModel!{
    didSet{
      self.lblTitle.text = cellViewModel.name
      categoryID = cellViewModel.id
      categoryDescription = cellViewModel.description
      parentID = cellViewModel.parent
      children = cellViewModel.child
      if let bgImageURL = cellViewModel.getBgImageURLForCell() {
        Utilities.getImageFromURL(imgView: imgBg, url: bgImageURL){ (_) in
        }
      }
      if let imgSmallURL = cellViewModel.getImageForCategoryLogo() {
        Utilities.getImageFromURL(imgView: imgSmall, url: imgSmallURL){ (_) in
        }
      }
    }
  }

  @IBOutlet weak var lblTitle : BaseUILabel!
  @IBOutlet weak var imgViewLayer : BaseUIImageView!
  @IBOutlet weak var imgBg : BaseUIImageView!
  @IBOutlet weak var imgSmall : BaseUIImageView!
  @IBOutlet weak var widthConstraintSmall : NSLayoutConstraint!
  @IBOutlet weak var cellContentView: UIView!
  @IBOutlet weak var subscribedView: UIView!
  override func awakeFromNib() {
    super.awakeFromNib()
    subscribedView.isHidden = true
    self.translatesAutoresizingMaskIntoConstraints  = false
    cellContentView.translatesAutoresizingMaskIntoConstraints = false
  }
  override func layoutSubviews() {
    super.layoutSubviews()
  }

  func showSubscription(isSubscribed: Bool){
    subscribedView.isHidden = !isSubscribed
  }
}
