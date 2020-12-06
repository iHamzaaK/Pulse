//
//  TopStoriesTableViewCell.swift
//  Pulse
//
//  Created by Hamza Khan on 08/11/2020.
//

import UIKit
import ReadMoreTextView
protocol TopStoriesCellProtocol : class {
    func didTapOnBtnDeleteCommentImage()->Void
    func didTapOnBtnSendComment()->Void
    func didTapOnBtnAddPhoto()->Void
    func didTapOnBtnLike()->Void
    func didTapOnBtnShare()->Void
    func didTapOnBtnComment()->Void


}
class TopStoriesTableViewCell: UITableViewCell {
    
   
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
    var hideCommentView : Bool = false{
        didSet{
            commentView.isHidden = hideCommentView
            if hideCommentView{
                heightConstraintCommentView.constant = 0
            }
        }
    }
    
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
//            if commentImage.image == nil{
                commentImage.isHidden = true
                btnDeleteCommentImage.isHidden = true
                
//            }
        }
    }
    weak var delegate : TopStoriesCellProtocol!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        commentImage.isHidden = true
        heightConstraintCommentImage.constant = 0
        bottomConstraintCommentImage.constant = 0
        btnDeleteCommentImage.isHidden = true
        if DesignUtility.isIPad{
            self.leadingConstraintContentView.constant = DesignUtility.convertToRatio(30, sizedForIPad: true, sizedForNavi: false)
            self.trailingConstraintContentView.constant = DesignUtility.convertToRatio(30, sizedForIPad: true, sizedForNavi: false)
            self.heightConstraintVideoView.constant = DesignUtility.convertToRatio(295, sizedForIPad: true, sizedForNavi: false)
            self.heightConstraintCommentView.constant = DesignUtility.convertToRatio(53, sizedForIPad: true, sizedForNavi: false)

        }
      
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
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
