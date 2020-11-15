//
//  CommentsViewController.swift
//  Pulse
//
//  Created by Hamza Khan on 14/11/2020.
//

import UIKit

class CommentsViewController: BaseViewController {
    var viewModel : CommentsViewModel!
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
            Utilities.registerNib(nibName: "CommentsTableViewCell", identifier: "CommentsTableViewCell", tblView: tblView)
        }
    }
    var viewMoodel : CommentsViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarType = self.viewModel.getNavigationBar()
        // Do any additional setup after loading the view.
    }
}

extension CommentsViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsTableViewCell") as! CommentsTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
extension CommentsViewController {
    @objc private func didTapOnViewPost(){
        AppRouter.pop()
    }
}
