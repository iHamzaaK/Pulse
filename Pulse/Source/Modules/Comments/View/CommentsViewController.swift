//
//  CommentsViewController.swift
//  Pulse
//
//  Created by Hamza Khan on 14/11/2020.
//

import UIKit
import ViewAnimator
class CommentsViewController: BaseViewController {
    var viewModel : CommentsViewModel!
    let fromAnimation = AnimationType.vector(CGVector(dx: 30, dy: 0))
    @IBOutlet weak var lblTitle : BaseUILabel!
    @IBOutlet weak var btnViewPostButton : BaseUIButton!{
        didSet{
            btnViewPostButton.addTarget(self, action: #selector(self.didTapOnViewPost), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var tblView : UITableView!{
        didSet{
            tblView.delegate = self
            tblView.dataSource = self
            tblView.estimatedRowHeight = 50
            tblView.rowHeight = UITableView.automaticDimension
            tblView.allowsSelection = false
            Utilities.registerNib(nibName: "CommentsTableViewCell", identifier: "CommentsTableViewCell", tblView: tblView)
        }
    }
    var viewMoodel : CommentsViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarType = self.viewModel.getNavigationBar()
        // Do any additional setup after loading the view.
        getData()
    }
}
extension CommentsViewController{
    func getData(){
        self.viewModel.getComments { (success, serverMsg) in
            if success{
                self.lblTitle.text = self.viewModel.getArticleTitle()
                self.tblView.reloadData()
                UIView.animate(views: self.tblView.visibleCells,
                               animations: [self.fromAnimation],
                               duration: 0.2)
            }
            else{
                Alert.showAlertWithAutoHide(title: ErrorDescription.errorTitle.rawValue, message: serverMsg, autoHidetimer: 2.0, type: .error)
                AppRouter.pop()
                
            }
        }
    }
}

extension CommentsViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getCommentsCount()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsTableViewCell") as! CommentsTableViewCell
        cell.cellViewModel = self.viewModel.cellViewModelForRow(row: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
extension CommentsViewController {
    @objc private func didTapOnViewPost(){
//        AppRouter.pop()
        self.navigationController?.popViewController(animated: true)
    }
}
