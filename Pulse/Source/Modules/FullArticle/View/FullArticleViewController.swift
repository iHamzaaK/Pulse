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
    
    @IBOutlet weak var lblTime: BaseUILabel!
    @IBOutlet weak var btnLike: BaseUIButton!
    @IBOutlet weak var lblNewsType: BaseUILabel!
    @IBOutlet weak var btnShare: BaseUIButton!
    @IBOutlet weak var btnBookmark: BaseUIButton!
    @IBOutlet weak var btnSendComment: UIButton!
    @IBOutlet weak var txtViewArticle: UITextView!
    @IBOutlet weak var imgViewComment: UIImageView!
    @IBOutlet weak var widhtConstraintCommentImageView: NSLayoutConstraint!
    @IBOutlet weak var btnCloseImage: BaseUIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        widhtConstraintCommentImageView.constant = 0
        imgViewComment.isHidden = true
        btnCloseImage.isHidden = true
        setupViews()
        // Do any additional setup after loading the view.
    }

}
extension FullArticleViewController{
    private func setupViews(){
        navBarType = self.viewModel.getNavigationBar()
    }
}
