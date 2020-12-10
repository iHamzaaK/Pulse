//
//  FullArticleViewController.swift
//  Pulse
//
//  Created by Hamza Khan on 10/11/2020.
//

import UIKit

class FullArticleViewController: BaseViewController {
    var viewModel : FullArticleViewModel!
    
    @IBOutlet weak var lblNewsTitle: BaseUILabel!
    @IBOutlet weak var imgView: BaseUIImageView!
    @IBOutlet weak var lblTime: BaseUILabel!
    @IBOutlet weak var lblTotalLikes: BaseUILabel!

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
        getData()
        // Do any additional setup after loading the view.
    }

}
extension FullArticleViewController{
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
                    
                }
                else{
                    
                }
                var strImage = "icon-bookmark"
                if self.viewModel.isBookmarked(){
                    strImage += "-filled"
                }
                self.lblTotalLikes.text = self.viewModel.getTotalLikeCount()
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
        navBarType = self.viewModel.getNavigationBar()
        
        
    }
    override func viewDidLayoutSubviews() {
        if DesignUtility.isIPad{
            heightConstraintTableView?.constant = tblViewComments.contentSize.height
        }
    }
    @objc func didTapOnLike(){
        
    }
    @objc func didTapOnShare(){
        
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
            AppRouter.goToSpecificController(vc: CommmentsViewBuilder.build())
        }
    }
}
