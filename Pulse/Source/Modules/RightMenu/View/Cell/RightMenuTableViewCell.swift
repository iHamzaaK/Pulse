
//
//  RightMenuTableViewCell.swift
//  Halal
//
//  Created by Hamza Khan on 19/11/2019.
//  Copyright © 2019 Hamza. All rights reserved.
//

import UIKit

final class RightMenuTableViewCell: UITableViewCell {
  var cellViewModel : RightMenuCellModel!{
    didSet{
      lblTitle.text = cellViewModel.value
      lblTitle.changeLanguage()
    }
  }
  @IBOutlet weak var lblTitle : BaseUILabel!
  @IBOutlet weak var imgTitle : UIImageView!

  override func awakeFromNib() {
    super.awakeFromNib()
  }

  func configCell(viewModel : RightMenuCellModel){
    self.cellViewModel = viewModel
  }
}
