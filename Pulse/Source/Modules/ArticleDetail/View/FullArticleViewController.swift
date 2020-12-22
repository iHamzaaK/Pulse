//
//  FullArticleViewController.swift
//  Pulse
//
//  Created by Hamza Khan on 10/11/2020.
//

import UIKit
import YouTubePlayer
import AVFoundation
class FullArticleViewController: BaseViewController {
    var viewModel : FullArticleViewModel!
    
    @IBOutlet weak var playerView : YouTubePlayerView!
    @IBOutlet weak var txtComment : BaseUITextfield!
    @IBOutlet weak var lblNewsTitle: BaseUILabel!
    @IBOutlet weak var imgView: BaseUIImageView!
    @IBOutlet weak var lblTime: BaseUILabel!
    @IBOutlet weak var lblTotalLikes: BaseUILabel!
    @IBOutlet weak var viewLikeStack : UIStackView!
    @IBOutlet weak var videoView : BaseUIView!
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
    @IBOutlet weak var txtViewArticle: UITextView!
    @IBOutlet weak var heightConstraintTableView : BaseLayoutConstraint?
    @IBOutlet weak var heightConstraintLikeCountStackView : BaseLayoutConstraint?
    
    @IBOutlet weak var viewStackLikeShareComment : UIStackView!
    @IBOutlet weak var viewStackTimeType : UIStackView!
    @IBOutlet weak var viewComment : BaseUIView!
    
    @IBOutlet weak var tblViewComments : UITableView!{
        didSet{
            tblViewComments.delegate = self
            tblViewComments.dataSource = self
            Utilities.registerNib(nibName: "CommentsTableViewCell", identifier: "CommentsTableViewCell", tblView: tblViewComments)
            Utilities.registerNib(nibName: "SeeAllCommentsTableViewCell", identifier: "SeeAllCommentsTableViewCell", tblView: tblViewComments)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
//        videoSettings()
        getData()
    }
    deinit {
        playerView = nil
        print("ViewController deinit")
    }
    
}
extension FullArticleViewController{
    
    @objc fileprivate func startLoading() {
        if self.presentedViewController != nil {
            return
        }
        
    }
    private func setupVideo(videoURL : String){
       
        self.videoSettings()
        playerView.loadVideoID("JLVXQn3fqgg")
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
        self.viewStackLikeShareComment.alpha = 0
        self.tblViewComments.alpha = 0
        self.viewStackTimeType.alpha = 0
        self.viewComment.alpha = 0
        
        self.viewModel.getArticleData { (success, serverMsg) in
            if success{
                //                self.view.alpha = 1
                self.txtViewArticle.attributedText = self.viewModel.getDescription()
                self.lblNewsTitle.text = self.viewModel.getTitle()
                self.lblNewsType.text = self.viewModel.getType()
                self.lblTime.text = self.viewModel.getTimeStamp()
                
                if !self.viewModel.isVideo(){
                    self.setupVideo(videoURL: self.viewModel.getVideoURl())
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
                if self.viewModel.getCommentCounts() < 1{
                    self.heightConstraintTableView?.constant = 0
                }
                else {
                    self.heightConstraintTableView?.constant = self.tblViewComments.contentSize.height + DesignUtility.convertToRatio(30, sizedForIPad: DesignUtility.isIPad, sizedForNavi: false)
                }
                self.viewStackLikeShareComment.alpha = 1
                self.tblViewComments.alpha = 1
                self.viewStackTimeType.alpha = 1
                self.viewComment.alpha = 1
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
    override func viewDidLayoutSubviews() {
        if DesignUtility.isIPad{
            heightConstraintTableView?.constant = tblViewComments.contentSize.height
        }
    }
    
}
extension FullArticleViewController{
    @objc func didTapOnSendComment(){
        let articleText = self.txtComment.text ?? ""
        if articleText.count > 0{
            self.viewModel.postComment(comment: articleText) { (success, serverMsg) in
                if success{
                    if self.viewModel.getCommentCounts() < 3{
                        self.tblViewComments.reloadData()
                        self.txtComment.text = ""
                        self.txtComment.resignFirstResponder()
                    }
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
                AppRouter.goToSpecificController(vc: vc!)
            }
        }
    }
    @objc func didTapOnLike(){
        self.viewModel.getLiked { (success, serverMsg, isLiked) in
            if success{
                var strImage = "icon-like"
                if isLiked!{
                    strImage += "-filled"
                }
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
                self.btnLike.setImage(UIImage(named: strImage)!, for: .normal)
            }
        }
    }
    
    
    @objc func didTapOnShare(){
        let text = self.viewModel.getTitle()
        let myWebsite = NSURL(string:self.viewModel.getWeblink())
        let shareAll = [text , myWebsite] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.btnShare
        activityViewController.isModalInPresentation = true
        self.present(activityViewController, animated: true, completion: nil)
    }
    @objc func didTapOnBookmark(){
        self.viewModel.addRemoveBookmark { (isBookmarked, success, serverMsg) in
            if success{
                var strImage = "icon-bookmark"
                if isBookmarked{
                    strImage += "-filled"
                }
                self.btnBookmark.setImage(UIImage(named: strImage)!, for: .normal)
            }
        }
    }
}

extension FullArticleViewController: YouTubePlayerDelegate{
    func playerReady(_ videoPlayer: YouTubePlayerView) {
        
    }
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
        return self.viewModel.getCommentCounts()
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
                AppRouter.goToSpecificController(vc: vc)
            }
            //            AppRouter.goToSpecificController(vc: CommmentsViewBuilder.build(articleID: <#String#>))
        }
    }
}
