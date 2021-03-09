//
//  SubCategoryTableViewCell.swift
//  Pulse
//
//  Created by Hamza Khan on 05/12/2020.
//

import UIKit

class SubCategoryTableViewCell: UITableViewCell {
    var categoryID : Int!
    var categoryDescription : String!
    var parentID : Int!
    @IBOutlet weak var lblTitle : BaseUILabel!
    var cellViewModel : CategoryCellViewModel!{
        didSet{
            self.lblTitle.text = cellViewModel.name
            categoryID = cellViewModel.id
            categoryDescription = cellViewModel.description
            parentID = cellViewModel.parent
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
