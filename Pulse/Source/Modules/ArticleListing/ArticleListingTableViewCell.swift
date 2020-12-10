//
//  ArticleListingTableViewCell.swift
//  Pulse
//
//  Created by Hamza Khan on 05/12/2020.
//

import UIKit
import ReadMoreTextView
import MMPlayerView
import AVFoundation

protocol ArticleListingCellProtocol : class {
    func didTapOnBtnLike(cellViewModel : ArticleListingCellViewModel)->Void
    func didTapOnBtnShare(cellViewModel : ArticleListingCellViewModel)->Void
    func didTapOnBtnComment(cellViewModel : ArticleListingCellViewModel)->Void
    func didTapOnBtnBookmark(row: Int)->Void
    func didTapOnPlay(row: Int , isPlaying: Bool)->Void

}
class ArticleListingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var heightConstraintCommentView: NSLayoutConstraint!
    @IBOutlet weak var commentView: BaseUIView!
    @IBOutlet weak var txtComment: BaseUITextfield!
    @IBOutlet weak var lblNewsType: BaseUILabel!
    @IBOutlet weak var lblDate: BaseUILabel!
    @IBOutlet weak var lblDescription: BaseUILabel!
    @IBOutlet weak var lblTotalLikes: BaseUILabel!
    @IBOutlet weak var btnPlay : BaseUIButton!{
        didSet{
            btnPlay.isHidden = true
            btnPlay.addTarget(self, action: #selector(self.didTapOnPlay), for: .touchUpInside)
        }
    }

    @IBOutlet weak var lblTitle: BaseUILabel!
    @IBOutlet weak var leadingConstraintContentView: BaseLayoutConstraint!
    @IBOutlet weak var heightConstraintVideoView: BaseLayoutConstraint!
    @IBOutlet weak var trailingConstraintContentView: BaseLayoutConstraint!
    @IBOutlet weak var bottomConstraintCommentImage: NSLayoutConstraint!
    @IBOutlet weak var heightConstraintCommentImage: NSLayoutConstraint!
    @IBOutlet weak var bgImageView: BaseUIImageView!
    @IBOutlet weak var heightConstraintLikeCountStackView : NSLayoutConstraint!
    var isVideo : Bool = false
    var articleID : Int = -1
    var videoStr = ""
    var cellViewModel : ArticleListingCellViewModel!{
        didSet{
            lblTitle.text = cellViewModel.title
            lblNewsType.text = cellViewModel.tag
            lblDate.text = cellViewModel.date
            lblTotalLikes.text = cellViewModel.showTotalLikes()
        
            if cellViewModel.likeCount < 1 {
                heightConstraintLikeCountStackView.constant = 0
            }
            else{
                heightConstraintLikeCountStackView.constant = 30
            }
            btnLike.setImage(cellViewModel.showLiked(), for: .normal)
            btnBookmark.setImage(cellViewModel.showBookmark(), for: .normal)
            let readmoreFont = UIFont(name: "Montserrat-Regular", size: DesignUtility.convertToRatio(14, sizedForIPad: false, sizedForNavi: false))
            let readmoreFontColor = UIColor.blue
            if let bgImageURL = cellViewModel.getBgImageURLForCell() {
                Utilities.getImageFromURL(imgView: bgImageView, url: bgImageURL){ (_) in
                    self.setNeedsLayout()
                }
            }
            else{
                self.bgImageView.image = UIImage.init(named: "placeholder")
            }
            lblDescription.text = cellViewModel.getShortDescription()
            self.lblDescription.alpha = 0
//            DispatchQueue.main.async {
//                self.lblDescription.addTrailing(with: ".", moreText: "view more", moreTextFont: readmoreFont!, moreTextColor: readmoreFontColor)
//            }
            self.lblDescription.alpha = 1
            

            isVideo = true//cellViewModel.isVideo
            articleID = cellViewModel.articleID
        }
    }
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
            btnSendComment.addTarget(self, action: #selector(self.didTapOnBtnComment), for: .touchUpInside)
        }
    }
    @IBOutlet weak var btnAddPhoto: UIButton!{
        didSet{
//            btnAddPhoto.addTarget(self, action: #selector(self.didTapOnDeleteButton), for: .touchUpInside)
        }
    }
    @IBOutlet weak var btnBookmark: BaseUIButton!{
        didSet{
            btnBookmark.addTarget(self, action: #selector(self.didTapOnBookmark), for: .touchUpInside)
        }
    }
    @IBOutlet weak var btnShare: BaseUIButton!{
        didSet{
            btnShare.addTarget(self, action: #selector(self.didTapOnBtnShare), for: .touchUpInside)
        }
    }
    @IBOutlet weak var btnLike: BaseUIButton!{
        didSet{
            btnLike.addTarget(self, action: #selector(self.didTapOnBtnLike), for: .touchUpInside)
        }
    }
    @IBOutlet weak var btnDeleteCommentImage : BaseUIButton!{
        didSet{
//            btnDeleteCommentImage.addTarget(self, action: #selector(self.didTapOnDeleteButton), for: .touchUpInside)
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
    weak var delegate : ArticleListingCellProtocol!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgImageView.contentMode = .scaleAspectFill
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
        delegate.didTapOnBtnLike(cellViewModel: self.cellViewModel)
    }
    @objc private func didTapOnBtnShare(){
        delegate.didTapOnBtnShare(cellViewModel: self.cellViewModel)
    }
    @objc private func didTapOnBtnComment(){
        delegate.didTapOnBtnComment(cellViewModel: self.cellViewModel)
    }
    

    @objc private func didTapOnBookmark(){
        delegate.didTapOnBtnBookmark(row: self.tag)
    }
    @objc  private func didTapOnPlay(){

        delegate.didTapOnPlay(row: self.tag, isPlaying: false)
    }

}
