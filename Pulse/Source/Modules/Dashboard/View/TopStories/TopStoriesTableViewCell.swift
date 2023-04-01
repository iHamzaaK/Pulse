//
//  TopStoriesTableViewCell.swift
//  Pulse
//
//  Created by Hamza Khan on 08/11/2020.
//

import UIKit
import ReadMoreTextView

protocol TopStoriesCellProtocol : AnyObject {
  func didTapOnBtnDeleteCommentImage()->Void
  func didTapOnBtnSendComment()->Void
  func didTapOnBtnAddPhoto()->Void
  func didTapOnBtnLike()->Void
  func didTapOnBtnShare()->Void
  func didTapOnBtnComment()->Void
}

final class TopStoriesTableViewCell: UITableViewCell {
  var hideCommentView : Bool = false{
    didSet{
      commentView.isHidden = hideCommentView
      if hideCommentView{
        heightConstraintCommentView.constant = 0
      }
    }
  }
  weak var delegate : TopStoriesCellProtocol!

  @IBOutlet weak var heightConstraintCommentView: NSLayoutConstraint!
  @IBOutlet weak var commentView: BaseUIView!
  @IBOutlet weak var txtComment: BaseUITextfield!
  @IBOutlet weak var lblNewsType: BaseUILabel!
  @IBOutlet weak var lblDate: BaseUILabel!
  @IBOutlet weak var lblTitle: BaseUILabel!
  @IBOutlet weak var leadingConstraintContentView: BaseLayoutConstraint!
  @IBOutlet weak var heightConstraintVideoView: BaseLayoutConstraint!
  @IBOutlet weak var trailingConstraintContentView: BaseLayoutConstraint!
  @IBOutlet weak var bottomConstraintCommentImage: NSLayoutConstraint!
  @IBOutlet weak var heightConstraintCommentImage: NSLayoutConstraint!
  @IBOutlet weak var txtViewDetail: UITextView!
  @IBOutlet weak var btnSendComment: UIButton!{
    didSet{
      btnSendComment.addTarget(self, action: #selector(self.didTapOnDeleteButton), for: .touchUpInside)
    }
  }
  @IBOutlet weak var btnAddPhoto: UIButton!{
    didSet{
      btnAddPhoto.addTarget(self, action: #selector(self.didTapOnDeleteButton), for: .touchUpInside)
    }
  }
  @IBOutlet weak var btnBookmark: BaseUIButton!{
    didSet{
      btnBookmark.addTarget(self, action: #selector(self.didTapOnDeleteButton), for: .touchUpInside)
    }
  }
  @IBOutlet weak var btnShare: BaseUIButton!{
    didSet{
      btnShare.addTarget(self, action: #selector(self.didTapOnDeleteButton), for: .touchUpInside)
    }
  }
  @IBOutlet weak var btnLike: BaseUIButton!{
    didSet{
      btnLike.addTarget(self, action: #selector(self.didTapOnDeleteButton), for: .touchUpInside)
    }
  }
  @IBOutlet weak var btnDeleteCommentImage : BaseUIButton!{
    didSet{
      btnDeleteCommentImage.addTarget(self, action: #selector(self.didTapOnDeleteButton), for: .touchUpInside)
    }
  }
  @IBOutlet weak var commentImage: UIImageView!{
    didSet{
      commentImage.layer.borderWidth = 1
      commentImage.layer.borderColor = UIColor.gray.cgColor
      commentImage.isHidden = true
      btnDeleteCommentImage.isHidden = true
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    commentImage.isHidden = true
    heightConstraintCommentImage.constant = 0
    bottomConstraintCommentImage.constant = 0
    btnDeleteCommentImage.isHidden = true
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

  func configCell(){
    hideCommentView = false
  }

  func configCellForInterest(){
    hideCommentView = true
  }

  func configCelllForBookmarks(){
    hideCommentView = true
  }

  func configCellForVideos(){
    hideCommentView = true
  }

  @objc private func didTapOnBtnLike(){
    delegate.didTapOnBtnLike()
  }

  @objc private func didTapOnBtnShare(){
    delegate.didTapOnBtnShare()
  }

  @objc private func didTapOnBtnComment(){
    delegate.didTapOnBtnComment()
  }

  @objc private func didTapOnBtnSendComment(){
    delegate.didTapOnBtnSendComment()
  }

  @objc private func didTapOnBtnAddPhoto(){
    delegate.didTapOnBtnAddPhoto()
  }

  @objc private func didTapOnDeleteButton(){
    delegate.didTapOnBtnDeleteCommentImage()
  }
}
