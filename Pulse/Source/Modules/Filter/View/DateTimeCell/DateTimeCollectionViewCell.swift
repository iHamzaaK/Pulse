//
//  DateTimeCollectionViewCell.swift
//  Pulse
//
//  Created by Hamza Khan on 07.03.22.
//

import UIKit

protocol DateTimeCollectionProtocol: AnyObject {
  func didSelectTime(row: Int) -> Void
}

final class DateTimeCollectionViewCell: UICollectionViewCell {
  @IBOutlet var view : UIView!
  weak var delegate: DateTimeCollectionProtocol!
  @IBOutlet var lblDateTime : UILabel!
  private var row: Int = -1
  var cellViewModel: DateTimeCellViewModel! {
    didSet {
      lblDateTime.text = cellViewModel.dateTime
      if cellViewModel.isSelected {
        view.backgroundColor = Utilities.hexStringToUIColor(hex: "58CFF6")
      }
      else {
        view.backgroundColor = UIColor.lightGray

      }
    }
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    delegate.didSelectTime(row: row)
  }
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    self.configView()
  }
  func configCell(viewModel: DateTimeCellViewModel, row: Int){
    cellViewModel = viewModel
    self.row = row
  }
  func configView(){
    view.layer.cornerRadius = 10
    view.layer.backgroundColor = UIColor.lightGray.cgColor
  }
}
