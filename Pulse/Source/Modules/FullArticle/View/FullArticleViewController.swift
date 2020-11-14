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
        // Do any additional setup after loading the view.
    }

}
extension FullArticleViewController{
    private func setupViews(){
        navBarType = self.viewModel.getNavigationBar()
    }
}

extension FullArticleViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row != 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsTableViewCell") as! CommentsTableViewCell
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
