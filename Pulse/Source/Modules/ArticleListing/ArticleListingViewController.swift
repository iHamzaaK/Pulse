//
//  ArticleListingViewController.swift
//  Pulse
//
//  Created by Hamza Khan on 05/12/2020.
//

import UIKit
import AVFoundation
import AVKit
import YouTubePlayer
import ViewAnimator
class ArticleListingViewController: BaseViewController, IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: viewModel.headerTitle)
    }
    var offsetObservation: NSKeyValueObservation?
    private let animations = [AnimationType.vector(CGVector(dx: 0, dy: 30))]
    let fromAnimation = AnimationType.vector(CGVector(dx: 30, dy: 0))
    var lblQuoteHeight : CGFloat = DesignUtility.convertToRatio(60, sizedForIPad: DesignUtility.isIPad, sizedForNavi: false)
    var refreshControl = UIRefreshControl()
    var viewModel : ArticleListingViewModel!
    @IBOutlet weak var viewQuote: UIView!
    @IBOutlet weak var lblQoute: BaseUILabel!
    @IBOutlet weak var lblQouteDate: BaseUILabel!
    @IBOutlet weak var lblArticleTypeHeading: BaseUILabel!
  @IBOutlet weak var btnFilter: BaseUIButton!

    @IBOutlet weak var btnAddTopic: BaseUIButton!{
        didSet{
            let str = "+ Add topics to create your own personal news feed"
            let range = (str as NSString).range(of: "+ Add topics")
            let attribute = NSMutableAttributedString.init(string: str)
//            attribute.addAttribute(NSAttributedString.Key.font, value: UIFont.init(name: "Montserrat-Regular", size: DesignUtility.convertToRatio(16, sizedForIPad: DesignUtility.isIPad, sizedForNavi: false))!, range: NSMakeRange(0, str.count))
            attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: Utilities.hexStringToUIColor(hex:"555555"), range: NSMakeRange(0, str.count))
            attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: Utilities.hexStringToUIColor(hex:"009ed4"), range: range)

            let style = NSMutableParagraphStyle()
            style.alignment = NSTextAlignment.center

            attribute.addAttribute(.paragraphStyle, value: style, range: NSMakeRange(0, str.count))
            btnAddTopic.setAttributedTitle(attribute, for: .normal)
//            myLabel.attributedText = attributedText
//            btnAddTopic.addTarget(self, action: #selector(self.didTapOnAdd), for: .touchUpInside)
//            self.view.layoutIfNeeded()
            if self.viewModel.type == .bookmarks{
                btnAddTopic.isHidden = true
            }
            
        }
    }
    @IBOutlet weak var btnQuote: BaseUIButton!{
        didSet{
            btnQuote.addTarget(self, action: #selector(self.didTapOnQuote), for: .touchUpInside)
        }
    }

    @IBOutlet weak var heightConstraintViewQuote : NSLayoutConstraint!
    @IBOutlet var heightConstraintTitle : NSLayoutConstraint!
    @IBOutlet weak var topConstraint : NSLayoutConstraint!
    @IBOutlet weak var lblEmptyViewText: UILabel!{
        didSet{
//            You don’t have any
//            notifications right now.
            var strType = "selected interests"
            if self.viewModel.type == .bookmarks{
                strType = "bookmarks"
            }
            self.lblEmptyViewText.text = "You don’t have any \(strType) right now."
        }
    }
    @IBOutlet weak var emptyView: UIView!

    var expandedCells = Set<Int>()
    var pageNo = 1{
        didSet{
            getData(paged: pageNo)
        }
    }
    @IBOutlet weak var tblView: UITableView!{
        didSet{
            self.tblView.delegate = self
            self.tblView.dataSource = self
            tblView.estimatedRowHeight = 100
            tblView.rowHeight = UITableView.automaticDimension
            Utilities.registerNib(nibName: "ArticleListingTableViewCell", identifier: "ArticleListingTableViewCell", tblView: tblView)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideEmptyView()
        navBarType = self.viewModel.getNavigationBar()
        getData(paged: pageNo)
        setupView()
        
        offsetObservation = tblView.observe(\.contentOffset, options: [.new]) { [weak self] (_, value) in
            guard let self = self, self.presentedViewController == nil else {return}
            NSObject.cancelPreviousPerformRequests(withTarget: self)
            self.perform(#selector(self.startLoading), with: nil, afterDelay: 0.2)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.updateByContentOffset()
            self?.startLoading()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadListing), name: Notification.Name("reloadListing"), object: nil)
        btnFilter.setTitle("", for: .normal)
      btnFilter.addTarget(self, action: #selector(self.didTapOnFilter), for: .touchUpInside)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        Notification qCenter.default.removeObserver(self)

    }
    
    deinit {
        offsetObservation?.invalidate()
        offsetObservation = nil
        //print("ViewController deinit")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension ArticleListingViewController{
    func showEmptyView(){
        emptyView.isHidden = false
        tblView.isHidden = true
        self.view.sendSubviewToBack(tblView)
    }
    func hideEmptyView(){
        emptyView.isHidden = true
        tblView.isHidden = false
        self.view.sendSubviewToBack(emptyView)
        tblView.reloadData()
    }
    @IBAction func didTapOnAddTopics(_ sender: Any) {
//        dataSize = 10
        AppRouter.goToSpecificController(vc: MyProfileBuilder.build())
    }

    @objc func reloadListing(){
//        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (_) in
            self.getData(paged: self.pageNo)
//        }
    }
    @objc func getData(paged: Int){
        self.refreshControl.endRefreshing()
        if viewModel.type == articleListingType.videos{
            self.viewModel.getAllVideos { (success, serverMsg) in
                if success{
                    self.tblView.reloadData()
                    UIView.animate(views: self.tblView.visibleCells, animations: self.animations, completion: {
                    })

                }
                else{
                    Alert.showAlertWithAutoHide(title: ErrorDescription.errorTitle.rawValue, message: serverMsg, autoHidetimer: 2.0, type: .error)
                    AppRouter.pop()

                }
            }
        }
        else{
        self.viewModel.getListing(paged: paged) { (success, serverMsg) in
            if success{
                DispatchQueue.main.async {
                    if self.viewModel.showQuoteView(){
                        self.viewQuote.isHidden = false
                        self.lblQoute.text = "\"\(self.viewModel.getQuote()?.title ?? "")\"" 
                        self.lblQuoteHeight  = DesignUtility.convertToRatio(80, sizedForIPad: DesignUtility.isIPad, sizedForNavi: false)
                        if self.lblQoute.maxNumberOfLines == 1{
                            self.lblQuoteHeight = DesignUtility.convertToRatio(60, sizedForIPad:  DesignUtility.isIPad, sizedForNavi: false)
                        }
                        self.heightConstraintViewQuote.constant = self.lblQuoteHeight
                        UIView.animate(views: [self.viewQuote],
                                       animations: [self.fromAnimation],
                                       duration: 0.4)
                    }
                    else{
                        self.heightConstraintViewQuote.constant = 0
                    }
                    if self.viewModel.getArticleCount() > 0 {
                        self.hideEmptyView()
                    }
                    else{
                        self.showEmptyView()
                    }
                    self.tblView.reloadData()
                    UIView.animate(views: self.tblView.visibleCells, animations: self.animations, completion: {
                    })
                }
            }
            else{
                if self.viewModel.type == .interest || self.viewModel.type == .bookmarks || self.viewModel.type == .myNews{
                    if self.viewModel.getArticleCount() == 0{
                        self.showEmptyView()
                    }
                }
                else{
                    Alert.showAlertWithAutoHide(title: ErrorDescription.errorTitle.rawValue, message: serverMsg, autoHidetimer: 2.0, type: .error)
                    AppRouter.pop()
                }

            }
        }
        }
    }
    func setupView(){
        viewQuote.isHidden = true
        lblArticleTypeHeading.text =  self.viewModel.getHeaderTitle()
        UIView.animate(views: [lblArticleTypeHeading],
                       animations: [fromAnimation],
                       duration: 0.4)
        if !self.viewModel.showQuoteView(){
            heightConstraintViewQuote.constant = 0
        }
        
        if !self.viewModel.showTitle(){
            heightConstraintTitle.constant = 0
            if navBarType == .clearNavBar{
                topConstraint.constant = 0
            }
        }
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
           refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
           tblView .addSubview(refreshControl) // not required when using UITableViewController
    }
    @objc func didTapOnQuote(){
        AppRouter.goToSpecificController(vc: QuotesBuilder.build())
    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.getData(paged: 1)
    }
    fileprivate func updateByContentOffset() {
        if let path = findCurrentPath(),
            self.presentedViewController == nil {
            self.updateCell(at: path)
        }
    }
  @objc private func didTapOnFilter(){
    let filterVC = FilterBuilder.build(title: "Filter", navBarType: .filterNavBar) as! FilterViewController
    filterVC.delegate = self
    self.present(filterVC, animated: true) {
    }
  }
    fileprivate func updateCell(at indexPath: IndexPath) {
        if let cell = tblView.cellForRow(at: indexPath) as? ArticleListingTableViewCell, let playURL = URL(string: cell.videoStr) {
            
        }
    }
    
    @objc fileprivate func startLoading() {
        self.updateByContentOffset()
        if self.presentedViewController != nil {
            return
        }
    }
    
    func stopVideos(){
        if let indexPaths = tblView.indexPathsForVisibleRows{
            for indexPath in indexPaths{
            if let previousCell = tblView.cellForRow(at: indexPath) as? ArticleListingTableViewCell{
                if previousCell.playerView.playerState == YouTubePlayerState.Playing{
                    previousCell.playerView.clear()
                    previousCell.playerView.pause()
                }
            }
            }
        }
    }
    
    private func findCurrentPath() -> IndexPath? {
        let p = CGPoint(x: tblView.frame.width/2, y: tblView.contentOffset.y + tblView.frame.width/2)
        return tblView.indexPathForRow(at: p)
    }
    
    private func findCurrentCell(path: IndexPath) -> ArticleListingTableViewCell {
        return tblView.cellForRow(at: path)! as! ArticleListingTableViewCell
    }
    
    
}
extension ArticleListingViewController: FilterViewProtocol {
  func didTapOnDone(selectedFilter: SelectedFilters) {
    self.viewModel.getListing(keyword: selectedFilter.0, date: selectedFilter.1, paged: 1) { (success, serverMsg) in
      if success{
        DispatchQueue.main.async {
          if self.viewModel.showQuoteView(){
            self.viewQuote.isHidden = false
            self.lblQoute.text = "\"\(self.viewModel.getQuote()?.title ?? "")\""
            self.lblQuoteHeight  = DesignUtility.convertToRatio(80, sizedForIPad: DesignUtility.isIPad, sizedForNavi: false)
            if self.lblQoute.maxNumberOfLines == 1{
              self.lblQuoteHeight = DesignUtility.convertToRatio(60, sizedForIPad:  DesignUtility.isIPad, sizedForNavi: false)
            }
            self.heightConstraintViewQuote.constant = self.lblQuoteHeight
            UIView.animate(views: [self.viewQuote],
                           animations: [self.fromAnimation],
                           duration: 0.4)
          }
          else{
            self.heightConstraintViewQuote.constant = 0
          }
          if self.viewModel.getArticleCount() > 0 {
            self.hideEmptyView()
          }
          else{
            self.showEmptyView()
          }
          self.tblView.reloadData()
          UIView.animate(views: self.tblView.visibleCells, animations: self.animations, completion: {
          })
        }
      }
      else{
        if self.viewModel.type == .interest || self.viewModel.type == .bookmarks || self.viewModel.type == .myNews{
          if self.viewModel.getArticleCount() == 0{
            self.showEmptyView()
          }
        }
        else{
          Alert.showAlertWithAutoHide(title: ErrorDescription.errorTitle.rawValue, message: serverMsg, autoHidetimer: 2.0, type: .error)
          AppRouter.pop()
        }

      }
    }
  }
}
extension ArticleListingViewController: UITableViewDelegate, UITableViewDataSource, ArticleListingCellProtocol{
    func didTapOnShowAllLikes(row: Int) {
        self.viewModel.getAllLikes(row: row) { (success, serverMsg, vc) in
            if success{
                AppRouter.goToSpecificController(vc: vc!)
            }
        }
    }
    
    func didTapOnBtnLike(row: Int) {
        self.viewModel.getLiked(row: row) { (success, serverMsg, isLiked) in
            if success{
                DispatchQueue.main.async {
                    
                    self.tblView.beginUpdates()
                let indexPath = IndexPath(row: row, section: 0)
                let cell = self.tblView.cellForRow(at: indexPath) as! ArticleListingTableViewCell
                let cellViewModel = self.viewModel.cellViewModelForRow(row: row)
                    cell.lblTotalLikes.text = cell.showTotalLikes(isLiked: cellViewModel.isLiked, likeCount: cellViewModel.likeCount)
                cell.btnLike.setImage(cell.showLiked(isLiked: cellViewModel.isLiked), for: .normal)
                cell.showHideLikesView(likeCount: cellViewModel.likeCount, isLiked: cellViewModel.isLiked)
                cell.layoutIfNeeded()
                    
                    self.tblView.endUpdates()
                }
            }
        }
    }
    
    func didTapOnBtnShare(row: Int, articleTitle: String, articleLink: String, articleId: Int) {
        let cell = tblView.cellForRow(at: IndexPath(row: row, section: 0)) as! ArticleListingTableViewCell
        let text = articleTitle
        let link = articleLink + "?id=\(articleId)"
        let myWebsite = NSURL(string:link)
        let shareAll = [text , myWebsite] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
//        activityViewController.popoverPresentationController?.sourceView = cell.btnShare
//        activityViewController.isModalInPresentation = true
        self.present(activityViewController, animated: true, completion: nil)
        if let popOver = activityViewController.popoverPresentationController {
            popOver.sourceView = cell.btnShare
          //popOver.sourceRect =
          //popOver.barButtonItem
        }
    }
    
    
    func didTapOnBtnComment(row: Int, comment : String) {
//        self.tblView.beginUpdates()

        self.viewModel.postComment(row: row, comment: comment) { (success, serverMsg) in
                Alert.showAlertWithAutoHide(title: "", message: serverMsg, autoHidetimer: 2.0, type: .notification)
            }
    }
    
    
    func didTapOnPlay(row: Int, isPlaying: Bool) {
        
        let indexPath = IndexPath(row: row, section: 0)
        let cell = tblView.cellForRow(at: indexPath) as! ArticleListingTableViewCell
        if cell.isVideo{
            cell.playerView.isHidden = false
            cell.bringSubviewToFront(cell.playerView)
            cell.bgImageView.isHidden = true
            cell.btnPlay.isHidden = true
            if cell.playerView.ready{
                cell.playerView.play()
            }
        }
    }
    
    func didTapOnBtnBookmark(row: Int) {
        let indexPath = IndexPath(row: row, section: 0)
        let cell = self.tblView.cellForRow(at: indexPath) as! ArticleListingTableViewCell
        cell.btnBookmark.setImage(cell.showBookmark(isBookmarked: !cell.cellViewModel.isBookmarked), for: .normal)
        
        self.viewModel.addRemoveBookmark(row: row) { (isBookmarked, success, serverMsg) in
            if success{
                let indexPath = IndexPath(row: row, section: 0)
                let cell = self.tblView.cellForRow(at: indexPath) as! ArticleListingTableViewCell
                cell.btnBookmark.setImage(cell.showBookmark(isBookmarked: isBookmarked), for: .normal)
            }
            else{
                let indexPath = IndexPath(row: row, section: 0)
                let cell = self.tblView.cellForRow(at: indexPath) as! ArticleListingTableViewCell
                cell.btnBookmark.setImage(cell.showBookmark(isBookmarked: cell.cellViewModel.isBookmarked), for: .normal)
            }
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getArticleCount()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleListingTableViewCell", for: indexPath) as! ArticleListingTableViewCell
        cell.tag = indexPath.row
        cell.cellViewModel = self.viewModel.cellViewModelForRow(row: indexPath.row)
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let count = self.viewModel.getArticleCount()
        if count>1{
            let lastElement = count - 1
            if indexPath.row == lastElement {
                //call get api for next page
                pageNo += 1
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.didTapOnCell(row: indexPath.row) { (vc) in
            AppRouter.goToSpecificController(vc: vc)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopVideos()
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.viewModel.showQuoteView(){
            
            if scrollView.contentOffset.y > 50 {// the value when you want the headerview to hide
                view.layoutIfNeeded()
                heightConstraintViewQuote.constant = 0
                UIView.animate(withDuration: 0.5, delay: 0, options: [.allowUserInteraction], animations: {
                    self.view.layoutIfNeeded()
                }, completion: nil)
                
            }else {
                // expand the header
                view.layoutIfNeeded()
                heightConstraintViewQuote.constant = lblQuoteHeight // Your initial height of header view
                UIView.animate(withDuration: 0.5, delay: 0, options: [.allowUserInteraction], animations: {
                    self.view.layoutIfNeeded()
                }, completion: nil)
            }
        }

    }
    
}
