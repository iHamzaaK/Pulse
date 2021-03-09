//
//  LikesViewController.swift
//  Pulse
//
//  Created by Hamza Khan on 02/12/2020.
//

import UIKit
import ViewAnimator
class LikesViewController: BaseViewController {
    var viewModel : LikesViewModel!
    let fromAnimation = AnimationType.vector(CGVector(dx: 30, dy: 0))
    @IBOutlet weak var lblTitle : BaseUILabel!
    @IBOutlet weak var btnDone : BaseUIButton!{
        didSet{
            btnDone.addTarget(self, action: #selector(self.didTapOnDone), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var tblView : UITableView!{
        didSet{
            tblView.delegate = self
            tblView.dataSource = self
            tblView.estimatedRowHeight = 50
            tblView.rowHeight = UITableView.automaticDimension
            tblView.separatorStyle = .none
            Utilities.registerNib(nibName: "LikesTableViewCell", identifier: "LikesTableViewCell", tblView: tblView)
        }
    }
    var viewMoodel : CommentsViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarType = self.viewModel.getNavigationBar()
        UIView.animate(views: self.tblView.visibleCells,
                       animations: [self.fromAnimation],
                       duration: 0.3)
        // Do any additional setup after loading the view.
    }
}

extension LikesViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getUserLikeArrCount()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LikesTableViewCell") as! LikesTableViewCell
        let cellViewModel = self.viewModel.cellViewModelForRow(row: indexPath.row)
        cell.cellViewModel = cellViewModel
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
extension LikesViewController {
    @objc private func didTapOnDone(){
//        AppRouter.pop()
        self.navigationController?.popViewController(animated: true)
    }
}

