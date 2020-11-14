//
//  BookmarksViewController.swift
//  Pulse
//
//  Created by Hamza Khan on 11/11/2020.
//

import UIKit

class BookmarksViewController: UIViewController,IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: viewModel.headerTitle)
    }
    
    @IBOutlet weak var btnAddTopic: UIButton!
    @IBOutlet weak var lblEmptyViewText: UILabel!
    @IBOutlet weak var emptyView: UIView!
    let dataSize = 0
    var viewModel : BookmarkViewModel!
    @IBOutlet weak var tblView : UITableView!{
        didSet{
            tblView.delegate = self
            tblView.dataSource = self
            tblView.estimatedRowHeight = 100
            tblView.rowHeight = UITableView.automaticDimension
            Utilities.registerNib(nibName: "TopStoriesTableViewCell", identifier: "TopStoriesTableViewCell", tblView: tblView)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        showEmptyView()
        // Do any additional setup after loading the view.
    }
    


}
extension BookmarksViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopStoriesTableViewCell", for: indexPath) as! TopStoriesTableViewCell
        cell.configCelllForBookmarks()
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
}
extension BookmarksViewController {
    func showEmptyView(){
        if dataSize > 0{
            emptyView.isHidden = true
            self.view.sendSubviewToBack(emptyView)
        }
        else{
            emptyView.isHidden = false
            self.view.sendSubviewToBack(tblView)
        }
    }
}

