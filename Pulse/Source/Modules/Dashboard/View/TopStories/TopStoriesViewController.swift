//
//  TopStoriesViewController.swift
//  Pulse
//
//  Created by Hamza Khan on 08/11/2020.
//

import UIKit
import ReadMoreTextView

final class TopStoriesViewController: UIViewController {
  var viewModel : TopStoriesViewModel!
  @IBOutlet weak var viewQuote: UIView!
  @IBOutlet weak var lblQoute: BaseUILabel!
  @IBOutlet weak var lblQouteDate: BaseUILabel!
  var expandedCells = Set<Int>()
  @IBOutlet weak var tblView: UITableView!{
    didSet{
      Utilities.registerNib(nibName: "TopStoriesTableViewCell", identifier: "TopStoriesTableViewCell", tblView: tblView)
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

extension TopStoriesViewController: UITableViewDelegate, UITableViewDataSource{
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TopStoriesTableViewCell", for: indexPath) as! TopStoriesTableViewCell
    cell.configCell()
    return cell
  }
}
