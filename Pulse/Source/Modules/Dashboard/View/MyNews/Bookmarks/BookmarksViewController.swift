//
//  BookmarksViewController.swift
//  Pulse
//
//  Created by Hamza Khan on 11/11/2020.
//

import UIKit

final class BookmarksViewController: UIViewController,IndicatorInfoProvider {
  var viewModel : BookmarkViewModel!
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

  @IBOutlet weak var lblEmptyViewText: UILabel!
  @IBOutlet weak var emptyView: UIView!
  @IBOutlet weak var btnAddTopic: UIButton!{
    didSet{
      let str = "+ Add topics to create your own personal news feed"
      let range = (str as NSString).range(of: "+ Add topics")
      let attribute = NSMutableAttributedString.init(string: str)
      attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: Utilities.hexStringToUIColor(hex:"000000"), range: NSMakeRange(0, str.count))
      attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: Utilities.hexStringToUIColor(hex:"009ed4"), range: range)

      let style = NSMutableParagraphStyle()
      style.alignment = NSTextAlignment.center

      attribute.addAttribute(.paragraphStyle, value: style, range: NSMakeRange(0, str.count))
      btnAddTopic.setAttributedTitle(attribute, for: .normal)
    }
  }
  @IBAction func didTapOnAddTopics(_ sender: Any) {
    dataSize = 10
  }
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
  }

  func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
    return IndicatorInfo(title: viewModel.headerTitle)
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
}
extension BookmarksViewController {
  @objc private func didTapOnAdd(){
    dataSize = 1
  }
}

