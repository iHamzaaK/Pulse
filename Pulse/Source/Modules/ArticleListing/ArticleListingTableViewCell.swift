//
//  ArticleListingTableViewCell.swift
//  Pulse
//
//  Created by Hamza Khan on 05/12/2020.
//

import UIKit
import ReadMoreTextView
import AVFoundation
import YouTubePlayer

protocol ArticleListingCellProtocol : AnyObject {
  func didTapOnBtnLike(row : Int)->Void
  func didTapOnBtnShare(row: Int, articleTitle : String , articleLink: String, articleId: Int)->Void
  func didTapOnBtnComment(row : Int, comment: String)->Void
  func didTapOnBtnBookmark(row: Int)->Void
  func didTapOnPlay(row: Int , isPlaying: Bool)->Void
  func didTapOnShowAllLikes(row: Int)->Void
}

final class ArticleListingTableViewCell: UITableViewCell {
  @IBOutlet weak var heightConstraintCommentView: NSLayoutConstraint!
  @IBOutlet weak var commentView: BaseUIView!
  @IBOutlet weak var txtComment: BaseUITextfield!
  @IBOutlet weak var lblNewsType: BaseUILabel!
  @IBOutlet weak var lblDate: BaseUILabel!
  @IBOutlet weak var lblDescription: BaseUILabel!
  @IBOutlet weak var lblTotalLikes: BaseUILabel!
  @IBOutlet weak var stackViewLikeCount : UIStackView!
  @IBOutlet weak var btnPlay : BaseUIButton!{
    didSet{
      btnPlay.addTarget(self, action: #selector(self.didTapOnPlay), for: .touchUpInside)
    }
  }
  @IBOutlet weak var btnShowAllLikes : BaseUIButton!{
    didSet{
      btnShowAllLikes.addTarget(self, action: #selector(self.didTapOnShowAllLikes), for: .touchUpInside)
    }
  }
  @IBOutlet weak var playerView: YouTubePlayerView!
  @IBOutlet weak var lblTitle: BaseUILabel!
  @IBOutlet weak var leadingConstraintContentView: BaseLayoutConstraint!
  @IBOutlet weak var heightConstraintVideoView: BaseLayoutConstraint!
  @IBOutlet weak var heightConstraintShortDescription: BaseLayoutConstraint!
  @IBOutlet weak var trailingConstraintContentView: BaseLayoutConstraint!
  @IBOutlet weak var bottomConstraintCommentImage: NSLayoutConstraint!
  @IBOutlet weak var heightConstraintCommentImage: NSLayoutConstraint!
  @IBOutlet weak var bgImageView: BaseUIImageView!
  @IBOutlet weak var heightConstraintLikeCountStackView : NSLayoutConstraint!

  var isVideo : Bool = false
  var articleID : Int = -1
  var videoStr = "https://youtu.be/AH3lD8fafnE"
  var cellViewModel : ArticleListingCellViewModel!{
    didSet{
      txtComment.text = ""
      lblTitle.text = cellViewModel.title

      lblDate.text = cellViewModel.date
      lblTotalLikes.text = showTotalLikes(isLiked: cellViewModel.isLiked, likeCount: cellViewModel.likeCount)
      showHideLikesView(likeCount: cellViewModel.likeCount,isLiked: cellViewModel.isLiked)
      btnLike.setImage(showLiked(isLiked: cellViewModel.isLiked), for: .normal)
      btnBookmark.setImage(showBookmark(isBookmarked: cellViewModel.isBookmarked), for: .normal)
      setupDescription()
      setupNewsType()
      setupThumbnailImage()
      setupVideo()
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

  @IBOutlet weak var btnAddPhoto: UIButton!

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
  @IBOutlet weak var btnDeleteCommentImage : BaseUIButton!

  @IBOutlet weak var commentImage: UIImageView!{
    didSet{
      commentImage.layer.borderWidth = 1
      commentImage.layer.borderColor = UIColor.gray.cgColor
      commentImage.isHidden = true
      btnDeleteCommentImage.isHidden = true
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
  }

  override func prepareForReuse() {
    resetVideo()
    txtComment.text = ""
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

  func setupNewsType(){
    var newsType = cellViewModel.tag
    if newsType == ""{
      newsType = "Other Article"
    }
    lblNewsType.text = newsType
  }

  func showBookmark(isBookmarked: Bool)->UIImage{
    var imageName = "icon-bookmark"
    if isBookmarked{
      imageName += "-filled"
    }
    return UIImage.init(named: imageName)!
  }

  func showTotalLikes(isLiked: Bool , likeCount : Int)->String{
    var strUserLiked = ""
    var othersLiked = ""
    if isLiked{
      strUserLiked = "You"
    }
    if likeCount > 0{
      othersLiked = "\(likeCount) others liked this"
    }

    if isLiked && likeCount > 1{
      return strUserLiked + " and " + othersLiked
    }
    else if isLiked && likeCount < 2{
      return "\(strUserLiked) liked this"
    }
    else if !isLiked &&  likeCount > 0{
      return othersLiked
    }
    else{
      return ""
    }
  }

  func resetVideo(){
    playerView.isHidden = true
    sendSubviewToBack(self.playerView)
    bgImageView.isHidden = false
    btnPlay.isHidden = false
  }

  func setupVideo(){
    isVideo = cellViewModel.isVideo
    guard let url = cellViewModel.getVideoURL() else {
      isVideo = false
      self.resetVideo()
      self.btnPlay.isHidden = true
      return
    }

    if isVideo && url.absoluteString != "" {
      btnPlay.isHidden = false
      playerView.isHidden = true
      sendSubviewToBack(playerView)
      bgImageView.isHidden = false
      playerView.clear()
      playerView.pause()
      playerView.playerVars = [
        "playsinline": "1",
      ] as YouTubePlayerView.YouTubePlayerParameters
      playerView.loadVideoURL(url)
    }
    else{
      self.resetVideo()
    }
  }

  func setupDescription(){
    let shortDescription = cellViewModel.getShortDescription()
    lblDescription.text = shortDescription
  }

  func setupThumbnailImage(){
    if let bgImageURL = cellViewModel.getBgImageURLForCell() {
      Utilities.getImageFromURL(imgView: bgImageView, url: bgImageURL){ (_) in
        self.setNeedsLayout()
      }
    }
    else{
      self.bgImageView.image = UIImage.init(named: "placeholder")
    }
  }

  func showHideLikesView(likeCount : Int, isLiked : Bool){
    if likeCount < 1 && !isLiked {
      heightConstraintLikeCountStackView.constant = 0
    } else{
      heightConstraintLikeCountStackView.constant = 30
    }
    self.layoutIfNeeded()
  }

  func showLiked(isLiked: Bool)->UIImage{
    var imageName = "icon-like"
    if isLiked{
      imageName += "-filled"
    }
    return UIImage.init(named: imageName)!
  }

  @objc private func didTapOnBtnLike(){
    delegate.didTapOnBtnLike(row: self.tag)
  }

  @objc private func didTapOnBtnShare(){
    delegate.didTapOnBtnShare(row: self.tag, articleTitle: cellViewModel.title , articleLink: cellViewModel.permalink, articleId: cellViewModel.articleID)
  }

  @objc private func didTapOnBtnComment(){
    delegate.didTapOnBtnComment(row: self.tag, comment: self.txtComment.text ?? "")
    txtComment.text = ""
    txtComment.resignFirstResponder()
  }

  @objc private func didTapOnShowAllLikes(){
    delegate.didTapOnShowAllLikes(row: self.tag)
  }

  @objc private func didTapOnBookmark(){
    delegate.didTapOnBtnBookmark(row: self.tag)
  }

  @objc  private func didTapOnPlay(){
    delegate.didTapOnPlay(row: self.tag, isPlaying: false)
  }
}
