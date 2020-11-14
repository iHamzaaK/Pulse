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
    
    @IBOutlet weak var btnAddTopic: UIButton!{
        didSet{
//            btnAddTopic.addTarget(self, action: #selector(self.didTapOnAdd), for: .touchUpInside)
        }
    }
    @IBOutlet weak var lblEmptyViewText: UILabel!
    @IBOutlet weak var emptyView: UIView!
    var dataSize = 0 {
        didSet{
            if dataSize > 0{
                emptyView.isHidden = true
                tblView.isHidden = false
                self.view.sendSubviewToBack(emptyView)
//                self.view.bringSubviewToFront(tblView)
                tblView.reloadData()
            }
            else{
                emptyView.isHidden = false
                tblView.isHidden = true
                self.view.sendSubviewToBack(tblView)
//                self.view.bringSubviewToFront(tblView)
                
            }
        }
    }
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
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapOnAddTopics(_ sender: Any) {
        dataSize = 10
    }
    

}
extension BookmarksViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSize
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

    @objc private func didTapOnAdd(){
        dataSize = 1
    }
}

