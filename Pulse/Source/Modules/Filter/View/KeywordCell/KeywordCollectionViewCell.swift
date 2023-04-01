//
//  KeywordCollectionViewCell.swift
//  Pulse
//
//  Created by Hamza Khan on 07.03.22.
//

import UIKit

protocol KeywordCollectionDelegate: AnyObject {
  func didTapOnCancel(row: Int) -> Void
}

final class KeywordCollectionViewCell: UICollectionViewCell {
  weak var delegate: KeywordCollectionDelegate!
  private var row: Int = -1
  var cellViewModel: KeywordCellViewModel! {
    didSet {
      lblKeyword.text = cellViewModel.keyword
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

  @IBOutlet var btnCancel : UIButton!
  @IBOutlet var lblKeyword : UILabel!
  @IBOutlet var view : UIView!
  @IBOutlet private var maxWidthConstraint: NSLayoutConstraint! {
    didSet {
      maxWidthConstraint.isActive = false
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    contentView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      contentView.leftAnchor.constraint(equalTo: leftAnchor),
      contentView.rightAnchor.constraint(equalTo: rightAnchor),
      contentView.topAnchor.constraint(equalTo: topAnchor),
      contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
    configView()
    btnCancel.addTarget(self, action: #selector(self.didTapOnBtnCancel), for: .touchUpInside)
  }

  func configCell(viewModel: KeywordCellViewModel, row: Int, cellWidth: CGFloat){
    cellViewModel = viewModel
    self.row = row
  }

  func configView(){
    view.layer.cornerRadius = 10
  }
  
  @objc func didTapOnBtnCancel() {
    delegate.didTapOnCancel(row: row)
  }

}
