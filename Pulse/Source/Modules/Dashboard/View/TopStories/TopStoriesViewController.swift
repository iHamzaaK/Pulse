//
//  TopStoriesViewController.swift
//  Pulse
//
//  Created by Hamza Khan on 08/11/2020.
//

import UIKit
import ReadMoreTextView
class TopStoriesViewController: UIViewController {
    
    @IBOutlet weak var viewQuote: UIView!
    @IBOutlet weak var lblQoute: BaseUILabel!
    @IBOutlet weak var lblQouteDate: BaseUILabel!
    var expandedCells = Set<Int>()
    @IBOutlet weak var tblView: UITableView!{
        didSet{
//            tblView.delegate = self
//            tblView.dataSource = self
            tblView.estimatedRowHeight = 100
            tblView.rowHeight = UITableView.automaticDimension
            Utilities.registerNib(nibName: "TopStoriesTableViewCell", identifier: "TopStoriesTableViewCell", tblView: tblView)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
//        self.tblView.reloadData()
    }
    override func viewDidLayoutSubviews() {
            tblView.reloadData()
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
        let readMoreTextView = cell.txtViewDetail
        readMoreTextView!.shouldTrim = !expandedCells.contains(indexPath.row)
        readMoreTextView!.setNeedsUpdateTrim()
        readMoreTextView!.layoutIfNeeded()
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let readMoreTextView = cell.contentView.viewWithTag(1) as! ReadMoreTextView
        readMoreTextView.onSizeChange = { [unowned tableView, unowned self] r in
            let point = tableView.convert(r.bounds.origin, from: r)
            guard let indexPath = tableView.indexPathForRow(at: point) else { return }
            if r.shouldTrim {
                self.expandedCells.remove(indexPath.row)
            } else {
                self.expandedCells.insert(indexPath.row)
            }
            tableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TopStoriesTableViewCell
        cell.txtViewDetail.shouldTrim = !cell.txtViewDetail.shouldTrim
    }
}
