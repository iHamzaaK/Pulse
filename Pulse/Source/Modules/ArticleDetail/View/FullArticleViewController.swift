//
//  FullArticleViewController.swift
//  Pulse
//
//  Created by Hamza Khan on 10/11/2020.
//

import UIKit
import MMPlayerView
import AVFoundation
class FullArticleViewController: BaseViewController {
    var viewModel : FullArticleViewModel!
    lazy var mmPlayerLayer: MMPlayerLayer = {
        let l = MMPlayerLayer()
        l.cacheType = .memory(count: 5)
        l.coverFitType = .fitToPlayerView
        l.videoGravity = AVLayerVideoGravity.resizeAspectFill
        l.replace(cover: CoverA.instantiateFromNib())
        l.repeatWhenEnd = false
        return l
    }()
    @IBOutlet weak var lblNewsTitle: BaseUILabel!
    @IBOutlet weak var imgView: BaseUIImageView!
    @IBOutlet weak var lblTime: BaseUILabel!
    @IBOutlet weak var lblTotalLikes: BaseUILabel!
    @IBOutlet weak var viewLikeStack : UIStackView!
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
    @IBOutlet weak var btnSendComment: UIButton!
    @IBOutlet weak var txtViewArticle: UITextView!
    @IBOutlet weak var heightConstraintTableView : BaseLayoutConstraint?
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
        videoSettings()
        getData()
        // Do any additional setup after loading the view.
    }
    deinit {
        mmPlayerLayer.player = nil
        print("ViewController deinit")
    }
    
}
extension FullArticleViewController{
    
    @objc fileprivate func startLoading() {
//        self.updateByContentOffset()
        if self.presentedViewController != nil {
            return
        }
        // start loading video
        mmPlayerLayer.resume()
    }
    private func setupVideo(videoURL : String){
        guard let url = URL(string: videoURL) else {
            mmPlayerLayer.player = nil
            return
        }
        
        // this thumb use when transition start and your video dosent start
        mmPlayerLayer.thumbImageView.image = self.imgView.image
        // set video where to play
        mmPlayerLayer.playView = self.imgView
        mmPlayerLayer.set(url: url)
        mmPlayerLayer.resume()
    }
    private func videoSettings(){
        mmPlayerLayer.autoPlay = true
        mmPlayerLayer.getStatusBlock { [weak self] (status) in
            switch status {
            case .failed(let err):
                let alert = UIAlertController(title: "err", message: err.description, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self?.present(alert, animated: true, completion: nil)
            case .ready:
                print("Ready to Play")
            case .playing:
                print("Playing")
            case .pause:
                print("Pause")
            case .end:
                print("End")
            default: break
            }
        }
        mmPlayerLayer.getOrientationChange { (status) in
            print("Player OrientationChange \(status)")
        }

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
                if let imgURL = self.viewModel.getImageURL(){
                    Utilities.getImageFromURL(imgView: self.imgView, url: imgURL) { (_) in
                    }
                }
                else{
                    self.imgView.image = UIImage(named: "placeholder")
                }
                if self.viewModel.isVideo(){
                    self.setupVideo(videoURL: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")
                }
                else{
                    self.mmPlayerLayer.player = nil
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
                }
                self.lblTotalLikes.text = strLike
                self.btnBookmark.setImage(UIImage(named: strImage), for: .normal)
                self.tblViewComments.reloadData()
                if self.viewModel.getCommentCounts() < 1{
                self.heightConstraintTableView?.constant = 0
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
        navBarType = self.viewModel.getNavigationBar()
        
        
    }
    override func viewDidLayoutSubviews() {
        if DesignUtility.isIPad{
            heightConstraintTableView?.constant = tblViewComments.contentSize.height
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
                }
                else{
                    self.viewLikeStack.isHidden = true

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
