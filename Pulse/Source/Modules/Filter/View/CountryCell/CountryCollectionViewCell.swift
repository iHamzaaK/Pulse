//
//  CountryCollectionViewCell.swift
//  Pulse
//
//  Created by Hamza Khan on 07.03.22.
//

import UIKit

protocol CountryCollectionProtocol: AnyObject {
  func didSelectCountry(row: Int) -> Void
}

final class CountryCollectionViewCell: UICollectionViewCell {
  weak var delegate: CountryCollectionProtocol!
  private var row: Int = -1

  @IBOutlet var lblCountry : UILabel!
  @IBOutlet var imgViewCountry : UIImageView!
  @IBOutlet var view : UIView!
  @IBOutlet private var maxWidthConstraint: NSLayoutConstraint! {
    didSet {
      maxWidthConstraint.isActive = false
    }
  }
  
  var cellViewModel: CountriesCellViewModel! {
    didSet {
      lblCountry.text = cellViewModel.country
      if cellViewModel.isSelected {
        view.backgroundColor = Utilities.hexStringToUIColor(hex: "58CFF6")
      }
      else {
        view.backgroundColor = UIColor.lightGray
      }
    }
  }

  var maxWidth: CGFloat? = nil {
    didSet {
      guard let maxWidth = maxWidth else {
        return
      }
      maxWidthConstraint.isActive = true
      maxWidthConstraint.constant = maxWidth
    }
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    delegate.didSelectCountry(row: row)
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    contentView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      contentView.leftAnchor.constraint(equalTo: leftAnchor),
      contentView.rightAnchor.constraint(equalTo: rightAnchor),
      contentView.topAnchor.constraint(equalTo: topAnchor),
      contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
    configView()
  }

  func configCell(viewModel: CountriesCellViewModel, row: Int, width: CGFloat){
    cellViewModel = viewModel
    self.row = row
    let size = viewModel.country.size(withAttributes: [
      NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17)
    ])
  }

  func configView(){
    view.layer.cornerRadius = 10
    view.layer.backgroundColor = UIColor.lightGray.cgColor
  }
}
