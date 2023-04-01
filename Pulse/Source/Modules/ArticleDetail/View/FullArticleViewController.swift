//
//  FullArticleViewController.swift
//  Pulse
//
//  Created by Hamza Khan on 10/11/2020.
//

import UIKit
import YouTubePlayer
import AVFoundation
import ViewAnimator

class FullArticleViewController: BaseViewController {
  var viewModel : FullArticleViewModel!
  private let fromAnimation = AnimationType.vector(CGVector(dx: 30, dy: 0))
  private let animations = [AnimationType.vector(CGVector(dx: 0, dy: 30))]
  private let zoomAnimation = AnimationType.zoom(scale: 0.5)
  @IBOutlet weak var playerView : YouTubePlayerView!
  @IBOutlet weak var txtComment : BaseUITextfield!
  @IBOutlet weak var lblNewsTitle: BaseUILabel!
  @IBOutlet weak var imgView: BaseUIImageView!
  @IBOutlet weak var lblTime: BaseUILabel!
  @IBOutlet weak var lblTotalLikes: BaseUILabel!
  @IBOutlet weak var viewLikeStack : UIStackView!
  @IBOutlet weak var videoView : BaseUIView!
  private var reloadListing = false

  @IBOutlet weak var btnShowAllLikes: BaseUIButton!{
    didSet{
      btnShowAllLikes.addTarget(self, action: #selector(self.didTapOnShowAllLikes), for: .touchUpInside)

    }
  }
  @IBOutlet weak var btnPlay: BaseUIButton!{
    didSet{
      btnPlay.addTarget(self, action: #selector(self.didTapOnPlayBtn), for: .touchUpInside)

    }
  }
  @IBOutlet weak var btnLike: BaseUIButton!
  {
    didSet{
      btnLike.addTarget(self, action: #selector(self.didTapOnLike), for: .touchUpInside)
    }
  }
  @IBOutlet weak var lblNewsType: BaseUILabel!
  @IBOutlet weak var btnShare: BaseUIButton!{
    didSet{
      btnShare.addTarget(self, action: #selector(self.didTapOnShare), for: .touchUpInside)
    }
  }
  @IBOutlet weak var btnBookmark: BaseUIButton!{
    didSet{
      btnBookmark.addTarget(self, action: #selector(self.didTapOnBookmark), for: .touchUpInside)
    }
  }
  @IBOutlet weak var btnSendComment: UIButton!{
    didSet{
      btnSendComment.addTarget(self, action: #selector(self.didTapOnSendComment), for: .touchUpInside)
    }
  }
  @IBOutlet weak var tblViewComments : UITableView!{
    didSet{
      tblViewComments.delegate = self
      tblViewComments.dataSource = self
      Utilities.registerNib(nibName: "CommentsTableViewCell", identifier: "CommentsTableViewCell", tblView: tblViewComments)
      Utilities.registerNib(nibName: "SeeAllCommentsTableViewCell", identifier: "SeeAllCommentsTableViewCell", tblView: tblViewComments)
    }
  }
  @IBOutlet weak var txtViewArticle: UITextView!
  @IBOutlet weak var heightConstraintTableView : BaseLayoutConstraint?
  @IBOutlet weak var heightConstraintLikeCountStackView : BaseLayoutConstraint?
  @IBOutlet weak var topConstraint : BaseLayoutConstraint?
  @IBOutlet weak var viewStackLikeShareComment : UIStackView!
  @IBOutlet weak var viewStackTimeType : UIStackView!
  @IBOutlet weak var viewComment : BaseUIView!

  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    getData()

  }

  deinit {
    playerView = nil
  }
}
extension FullArticleViewController{
  @objc fileprivate func startLoading() {
    if self.presentedViewController != nil {
      return
    }
  }

  private func setupVideo(videoURL : URL){

    self.videoSettings()
    playerView.loadVideoURL(videoURL)
  }

  private func videoSettings(){
    self.btnPlay.isHidden = false
    self.btnPlay.alpha = 1
    self.playerView.delegate = self
    self.playerView.playerVars = [
      "playsinline": "1",
    ] as YouTubePlayerView.YouTubePlayerParameters
  }

  private func getData(){
    if navBarType == .clearNavBar{
      topConstraint?.constant = DesignUtility.convertToRatio(20, sizedForIPad: DesignUtility.isIPad, sizedForNavi: false)
    }
    self.viewStackLikeShareComment.alpha = 0
    self.tblViewComments.alpha = 0
    self.viewStackTimeType.alpha = 0
    self.viewComment.alpha = 0

    self.viewModel.getArticleData { (success, serverMsg) in
      if success{
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10
        let text = self.viewModel.getDescription()!.mutableCopy() as! NSMutableAttributedString
        let attributes = [NSAttributedString.Key.paragraphStyle : style]
        let textRangeForFont : NSRange = NSMakeRange(0, text.length)
        text.addAttributes(attributes, range: textRangeForFont)
        self.txtViewArticle.attributedText = text
        self.lblNewsTitle.text = self.viewModel.getTitle()
        self.lblNewsType.text = self.viewModel.getType()
        self.lblTime.text = self.viewModel.getTimeStamp()

        if self.viewModel.isVideo() && self.viewModel.getVideoURl() != nil{
          self.setupVideo(videoURL: self.viewModel.getVideoURl()!)
        }
        else{
          self.btnPlay.removeFromSuperview()
          self.playerView.removeFromSuperview()
          self.playerView = nil
        }
        if let imgURL = self.viewModel.getImageURL(){
          Utilities.getImageFromURL(imgView: self.imgView, url: imgURL) { (_) in
          }
        }
        else{
          self.imgView.image = UIImage(named: "placeholder")
        }

        var strImage = "icon-bookmark"
        if self.viewModel.isBookmarked(){
          strImage += "-filled"
        }
        var strLikeImage = "icon-like"
        if self.viewModel.isLiked(){
          strLikeImage += "-filled"
        }
        self.btnLike.setImage(UIImage(named: strLikeImage), for: .normal)
        let strLike  = self.viewModel.getTotalLikeCount()
        if strLike != ""{
          self.viewLikeStack.isHidden = false
          self.heightConstraintLikeCountStackView?.constant = DesignUtility.convertToRatio(30, sizedForIPad:  DesignUtility.isIPad, sizedForNavi: false)
        }

        self.lblTotalLikes.text = strLike
        self.btnBookmark.setImage(UIImage(named: strImage), for: .normal)
        self.tblViewComments.reloadData()
        UIView.animate(views: self.tblViewComments.visibleCells,
                       animations: [self.fromAnimation],
                       duration: 0.2)
        self.setContentHeight()
        self.viewStackLikeShareComment.alpha = 1

        self.tblViewComments.alpha = 1
        self.viewStackTimeType.alpha = 1
        self.viewComment.alpha = 1
        UIView.animate(views: [self.viewStackTimeType, self.viewStackLikeShareComment, self.imgView, self.lblNewsTitle],
                       animations: [self.zoomAnimation],
                       duration: 0.1)
        self.view.layoutIfNeeded()
      }
      else{

      }
    }
  }

  private func setupViews(){
    viewLikeStack.isHidden = true
    btnPlay.isHidden = true
    heightConstraintLikeCountStackView?.constant = 0
    navBarType = self.viewModel.getNavigationBar()
  }
}

extension FullArticleViewController{
  func setContentHeight(){
    if self.viewModel.getCommentCounts() < 1{
      self.heightConstraintTableView?.constant = 0
    }
    else {
      let height : CGFloat = DesignUtility.convertToRatio(70, sizedForIPad: DesignUtility.isIPad, sizedForNavi: false) * CGFloat(self.viewModel.getCommentCounts())
      self.heightConstraintTableView?.constant = height//CGFloat(self.viewModel.getCommentCounts() * 50)//self.tblViewComments.contentSize.height //+ DesignUtility.convertToRatio(50, sizedForIPad: DesignUtility.isIPad, sizedForNavi: false)
    }

    self.view.layoutSubviews()
  }

  @objc func didTapOnSendComment(){
    let articleText = self.txtComment.text ?? ""
    if articleText.count > 0{
      self.viewModel.postComment(comment: articleText) { (success, serverMsg) in
        if success{
          //                    if self.viewModel.getCommentCounts() < 3{
          self.tblViewComments.reloadData()

          self.txtComment.text = ""
          self.txtComment.resignFirstResponder()
          self.setContentHeight()
          //                    }
        }
      }
    }
  }

  @objc func didTapOnPlayBtn(){
    if self.playerView.ready{
      self.playerView.play()
    }
  }

  @objc func didTapOnShowAllLikes(){
    self.viewModel.getAllLikes { (success, serverMsg, vc) in
      if success{
        if self.navBarType == .clearNavBar{
          self.navigationController?.pushViewController(vc!, animated: true)
        }
        else{
          AppRouter.goToSpecificController(vc: vc!)
        }
      }
    }
  }

  @objc func didTapOnLike(){
    var strImage = "icon-like"
    if !self.viewModel.isLiked(){
      strImage += "-filled"
      self.viewModel.articleData.isLiked = true
      self.viewModel.articleData.likeCount! += 1
    }
    else{
      self.viewModel.articleData.isLiked = false
      self.viewModel.articleData.likeCount! -= 1
    }
    reloadListing = true

    DispatchQueue.main.async {
      self.btnLike.setImage(UIImage(named: strImage)!, for: .normal)

      let strLike  = self.viewModel.getTotalLikeCount()
      if strLike != ""{
        self.viewLikeStack.isHidden = false
        self.heightConstraintLikeCountStackView?.constant = DesignUtility.convertToRatio(30, sizedForIPad:  DesignUtility.isIPad, sizedForNavi: false)
      }
      else{
        self.viewLikeStack.isHidden = true
        self.heightConstraintLikeCountStackView?.constant = 0
      }
      self.lblTotalLikes.text = strLike

    }
    self.viewModel.getLiked { (success, serverMsg, isLiked) in
      if success{

      }
    }
  }

  func throwNotificationForReload(){
    NotificationCenter.default.post(name: Notification.Name("reloadListing"), object: nil)
  }

  @objc func didTapOnShare(){
    let text = self.viewModel.getTitle()
    let myWebsite = NSURL(string:self.viewModel.getWeblink())
    let shareAll = [text , myWebsite] as [Any]
    let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
    self.present(activityViewController, animated: true, completion: nil)
    if let popOver = activityViewController.popoverPresentationController {
      popOver.sourceView = self.btnShare
    }
  }

  @objc func didTapOnBookmark(){
    var strImage = "icon-bookmark"
    if !self.viewModel.isBookmarked(){
      self.viewModel.articleData.isBookmarked! = true
      strImage += "-filled"
    }
    else{
      self.viewModel.articleData.isBookmarked! = false
    }
    DispatchQueue.main.async {
      self.btnBookmark.setImage(UIImage(named: strImage)!, for: .normal)
    }
    reloadListing = true

    self.viewModel.addRemoveBookmark { (isBookmarked, success, serverMsg) in
      if !success{
        strImage = "icon-bookmark"
        if self.viewModel.isBookmarked(){
          strImage += "-filled"
        }
        DispatchQueue.main.async {
          self.btnBookmark.setImage(UIImage(named: strImage)!, for: .normal)
        }
      }
    }
  }
}

extension FullArticleViewController: YouTubePlayerDelegate{
  func playerReady(_ videoPlayer: YouTubePlayerView) {}

  func playerStateChanged(_ videoPlayer: YouTubePlayerView, playerState: YouTubePlayerState) {
    if playerState != .Playing && playerState != .Buffering && playerState != .Unstarted{
      self.videoView.sendSubviewToBack(playerView)
      self.videoView.bringSubviewToFront(self.imgView)
      self.videoView.bringSubviewToFront(btnPlay)
    }
    else{
      self.videoView.bringSubviewToFront(self.playerView)
      self.videoView.sendSubviewToBack(self.btnPlay)
      self.videoView.sendSubviewToBack(self.imgView)
    }
  }
}

extension FullArticleViewController : UITableViewDelegate, UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let commentCount = self.viewModel.getCommentCounts()
    if commentCount == 3 {
      tblViewComments.allowsSelection = true
      return commentCount + 1
    }
    else{
      tblViewComments.allowsSelection = false
      return commentCount//self.viewModel.getCommentCounts()
    }
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row != 3 {
      let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsTableViewCell") as! CommentsTableViewCell
      let cellViewModel = self.viewModel.cellViewModelForComment(row: indexPath.row)
      cell.cellViewModel = cellViewModel

      return cell
    }
    else{
      let cell = tableView.dequeueReusableCell(withIdentifier: "SeeAllCommentsTableViewCell") as! CommentsTableViewCell

      return cell
    }
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.row == 3 {
      self.viewModel.didTapOnSeeAllComments(row: indexPath.row) { (vc) in
        if navBarType == .clearNavBar{
          self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
          AppRouter.goToSpecificController(vc: vc)
        }
      }
    }
  }
}
