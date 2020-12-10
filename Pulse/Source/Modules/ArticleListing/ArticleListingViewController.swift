//
//  ArticleListingViewController.swift
//  Pulse
//
//  Created by Hamza Khan on 05/12/2020.
//

import UIKit
import AVFoundation
import AVKit
import MMPlayerView
class ArticleListingViewController: BaseViewController, IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: viewModel.headerTitle)
    }
    var offsetObservation: NSKeyValueObservation?

    lazy var mmPlayerLayer: MMPlayerLayer = {
        let l = MMPlayerLayer()
        l.cacheType = .memory(count: 5)
        l.coverFitType = .fitToPlayerView
        l.videoGravity = AVLayerVideoGravity.resizeAspectFill
        l.replace(cover: CoverA.instantiateFromNib())
        l.repeatWhenEnd = false
        return l
    }()
    var testVideoURLArr = ["http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4","http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4","http://yt-dash-mse-test.commondatastorage.googleapis.com/media/car-20120827-85.mp4", "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4"]
    var viewModel : ArticleListingViewModel!
    @IBOutlet weak var viewQuote: UIView!
    @IBOutlet weak var lblQoute: BaseUILabel!
    @IBOutlet weak var lblQouteDate: BaseUILabel!
    @IBOutlet weak var lblArticleTypeHeading: BaseUILabel!
    @IBOutlet weak var heightConstraintViewQuote : NSLayoutConstraint!
    @IBOutlet weak var heightConstraintTitle : NSLayoutConstraint!
    @IBOutlet weak var topConstraint : NSLayoutConstraint!
    var expandedCells = Set<Int>()
    var pageNo = 1{
        didSet{
            getData(paged: pageNo)
        }
    }
    @IBOutlet weak var tblView: UITableView!{
        didSet{
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
        tblView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 200, right:0)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.updateByContentOffset()
            self?.startLoading()
        }
        mmPlayerLayer.autoPlay = false
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
    override func viewWillAppear(_ animated: Bool) {
        //        self.tblView.reloadData()
        
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
    func getData(paged: Int){
        self.viewModel.getListing(paged: paged) { (success, serverMsg) in
            if success{
                DispatchQueue.main.async {
                    self.tblView.delegate = self
                    self.tblView.dataSource = self
                    self.tblView.reloadData()
                    
                }
            }
        }
    }
    func setupView(){
        lblArticleTypeHeading.text =  self.viewModel.getHeaderTitle()
        if !self.viewModel.showQuoteView(){
            heightConstraintViewQuote.constant = 0
        }
        if !self.viewModel.showTitle(){
            heightConstraintTitle.constant = 0
            navBarType = .clearNavBar
            topConstraint.constant = 0
        }
    }
}

extension ArticleListingViewController: MMPlayerFromProtocol{
    func backReplaceSuperView(original: UIView?) -> UIView? {
        guard let path = self.findCurrentPath() else {
            return original
        }
        
        let cell = self.findCurrentCell(path: path) as! ArticleListingTableViewCell
        return cell.bgImageView
    }

    // add layer to temp view and pass to another controller
    var passPlayer: MMPlayerLayer {
        return self.mmPlayerLayer
    }
    func transitionWillStart() {
    }
    // show cell.image
    func transitionCompleted() {
        self.updateByContentOffset()
        self.startLoading()
    }
    
    fileprivate func updateByContentOffset() {
        if mmPlayerLayer.isShrink {
            return
        }
        
        if let path = findCurrentPath(),
            self.presentedViewController == nil {
            self.updateCell(at: path)
            //Demo SubTitle
//            if path.row == 0, self.mmPlayerLayer.subtitleSetting.subtitleType == nil {
//                let subtitleStr = Bundle.main.path(forResource: "srtDemo", ofType: "srt")!
//                if let str = try? String.init(contentsOfFile: subtitleStr) {
//                    self.mmPlayerLayer.subtitleSetting.subtitleType = .srt(info: str)
//                    self.mmPlayerLayer.subtitleSetting.defaultTextColor = .red
//                    self.mmPlayerLayer.subtitleSetting.defaultFont = UIFont.boldSystemFont(ofSize: 20)
//                }
//            }
        }
    }

//    fileprivate func updateDetail(at indexPath: IndexPath) {
//        let value = DemoSource.shared.demoData[indexPath.row]
//        if let detail = self.presentedViewController as? DetailViewController {
//            detail.data = value
//        }
//
//        self.mmPlayerLayer.thumbImageView.image = value.image
//        self.mmPlayerLayer.set(url: DemoSource.shared.demoData[indexPath.row].play_Url)
//        self.mmPlayerLayer.resume()
//
//    }
    fileprivate func updateCell(at indexPath: IndexPath) {
        if let cell = tblView.cellForRow(at: indexPath) as? ArticleListingTableViewCell, let playURL = URL(string: cell.videoStr) {
            if cell.isVideo{
            // this thumb use when transition start and your video dosent start
            mmPlayerLayer.thumbImageView.image = cell.bgImageView.image
            // set video where to play
            mmPlayerLayer.playView = cell.bgImageView
            mmPlayerLayer.set(url: playURL)
            }
            else{
                mmPlayerLayer.player = nil
            }
        }
    }
    
    @objc fileprivate func startLoading() {
        self.updateByContentOffset()
        if self.presentedViewController != nil {
            return
        }
        // start loading video
        mmPlayerLayer.resume()
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
    func didTapOnBtnLike(cellViewModel: ArticleListingCellViewModel) {
        
    }
    
    func didTapOnBtnShare(cellViewModel: ArticleListingCellViewModel) {
        
    }
    
    func didTapOnBtnComment(cellViewModel: ArticleListingCellViewModel) {
        
    }
    
    
    func didTapOnPlay(row: Int, isPlaying: Bool) {
//        let indexPath = IndexPath(row: row, section: 0)
//        let cell = tableView(tblView, cellForRowAt: indexPath) as! ArticleListingTableViewCell
//        cell.videoView.player?.play();
//        cell.btnPlay.isHidden = true
        mmPlayerLayer.player?.play()
//        mmPlayerLayer.player?.play()
//        mmPlayerLayer.player?.

    }
    
    func didTapOnBtnBookmark(row: Int) {
        self.viewModel.addRemoveBookmark(row: row) { (isBookmarked, success, serverMsg) in
            if success{
                let indexPath = IndexPath(row: row, section: 0)
                UIView.performWithoutAnimation({
                    let loc = self.tblView.contentOffset
                    self.tblView.reloadRows(at: [indexPath], with: .none)
                    self.tblView.contentOffset = loc
                    })

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
        cell.videoStr = testVideoURLArr[indexPath.row%4]
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        guard let videoCell = (cell as? ArticleListingTableViewCell) else { return };
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
                heightConstraintViewQuote.constant = 90 // Your initial height of header view
                UIView.animate(withDuration: 0.5, delay: 0, options: [.allowUserInteraction], animations: {
                    self.view.layoutIfNeeded()
                }, completion: nil)
            }
        }
    }
    
}
