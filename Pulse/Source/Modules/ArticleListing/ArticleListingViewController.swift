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
class ArticleListingViewController: BaseViewController, IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: viewModel.headerTitle)
    }
    var offsetObservation: NSKeyValueObservation?
    
    var lblQuoteHeight : CGFloat = DesignUtility.convertToRatio(60, sizedForIPad: DesignUtility.isIPad, sizedForNavi: false)
    var refreshControl = UIRefreshControl()
    var viewModel : ArticleListingViewModel!
    @IBOutlet weak var viewQuote: UIView!
    @IBOutlet weak var lblQoute: BaseUILabel!
    @IBOutlet weak var lblQouteDate: BaseUILabel!
    @IBOutlet weak var lblArticleTypeHeading: BaseUILabel!
    @IBOutlet weak var btnQuote: BaseUIButton!{
        didSet{
            btnQuote.addTarget(self, action: #selector(self.didTapOnQuote), for: .touchUpInside)
        }
    }

    @IBOutlet weak var heightConstraintViewQuote : NSLayoutConstraint!
    @IBOutlet var heightConstraintTitle : NSLayoutConstraint!
    @IBOutlet weak var topConstraint : NSLayoutConstraint!
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
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)

    }
    
    deinit {
        offsetObservation?.invalidate()
        offsetObservation = nil
        print("ViewController deinit")
    }
    
}

extension ArticleListingViewController{
    func getData(paged: Int){
        self.refreshControl.endRefreshing()
        if viewModel.type == articleListingType.videos{
            self.viewModel.getAllVideos { (success, serverMsg) in
                if success{
                    self.tblView.reloadData()

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
                        self.lblQoute.text = self.viewModel.getQuote()?.title ?? ""
                        self.lblQuoteHeight  = DesignUtility.convertToRatio(80, sizedForIPad: DesignUtility.isIPad, sizedForNavi: false)
                        if self.lblQoute.maxNumberOfLines == 1{
                            self.lblQuoteHeight = DesignUtility.convertToRatio(60, sizedForIPad:  DesignUtility.isIPad, sizedForNavi: false)
                        }
                        self.heightConstraintViewQuote.constant = self.lblQuoteHeight
                    }
                    else{
                        self.heightConstraintViewQuote.constant = 0
                    }
                   
                    self.tblView.reloadData()
 
                }
            }
        }
        }
    }
    func setupView(){
        viewQuote.isHidden = true
        lblArticleTypeHeading.text =  self.viewModel.getHeaderTitle()
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
                previousCell.playerView.clear()
                if previousCell.playerView.playerState == YouTubePlayerState.Playing{
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
    
    func didTapOnBtnShare(cellViewModel: ArticleListingCellViewModel) {
        
    }
    
    func didTapOnBtnComment(cellViewModel: ArticleListingCellViewModel) {
        
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
        self.viewModel.addRemoveBookmark(row: row) { (isBookmarked, success, serverMsg) in
            if success{
                let indexPath = IndexPath(row: row, section: 0)
                let cell = self.tblView.cellForRow(at: indexPath) as! ArticleListingTableViewCell
                cell.btnBookmark.setImage(cell.showBookmark(isBookmarked: isBookmarked), for: .normal)
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
