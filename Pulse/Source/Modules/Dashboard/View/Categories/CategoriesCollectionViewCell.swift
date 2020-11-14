//
//  CategoriesCollectionViewCell.swift
//  Pulse
//
//  Created by Hamza Khan on 10/11/2020.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellContentView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.translatesAutoresizingMaskIntoConstraints  = false
        cellContentView.translatesAutoresizingMaskIntoConstraints = false

    }

}
