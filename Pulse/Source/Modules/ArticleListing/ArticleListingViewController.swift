            //
//  ArticleListingViewController.swift
//  Pulse
//
//  Created by Hamza Khan on 05/12/2020.
//

import UIKit

class ArticleListingViewController: BaseViewController, IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: viewModel.headerTitle)
    }
    var viewModel : ArticleListingViewModel!
    @IBOutlet weak var viewQuote: UIView!
    @IBOutlet weak var lblQoute: BaseUILabel!
    @IBOutlet weak var lblQouteDate: BaseUILabel!
    @IBOutlet weak var lblArticleTypeHeading: BaseUILabel!
    @IBOutlet weak var heightConstraintViewQuote : NSLayoutConstraint!
    @IBOutlet weak var heightConstraintTitle : NSLayoutConstraint!
    @IBOutlet weak var topConstraint : NSLayoutConstraint!
    var expandedCells = Set<Int>()
    var pageNo = 1{
        didSet{
            getData(paged: pageNo)
        }
    }
    @IBOutlet weak var tblView: UITableView!{
        didSet{
            tblView.estimatedRowHeight = 100
            tblView.rowHeight = UITableView.automaticDimension
            Utilities.registerNib(nibName: "ArticleListingTableViewCell", identifier: "ArticleListingTableViewCell", tblView: tblView)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarType = self.viewModel.getNavigationBar()
        getData(paged: pageNo)
        setupView()
        
    }
    override func viewWillAppear(_ animated: Bool) {
//        self.tblView.reloadData()
        
    }
    func getData(paged: Int){
        self.viewModel.getListing(paged: paged) { (success, serverMsg) in
            if success{
                DispatchQueue.main.async {
                    self.tblView.delegate = self
                    self.tblView.dataSource = self
                    self.tblView.reloadData()

                }
            }
        }
    }
    func setupView(){
        lblArticleTypeHeading.text =  self.viewModel.getHeaderTitle()
        if !self.viewModel.showQuoteView(){
            heightConstraintViewQuote.constant = 0
        }
        if !self.viewModel.showTitle(){
            heightConstraintTitle.constant = 0
            navBarType = .clearNavBar
            topConstraint.constant = 0
        }
    }
}

extension ArticleListingViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getArticleCount()
        }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleListingTableViewCell", for: indexPath) as! ArticleListingTableViewCell
        cell.cellViewModel = self.viewModel.cellViewModelForRow(row: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
         let count = self.viewModel.getArticleCount()
             if count>1{
                    let lastElement = count - 1
                    if indexPath.row == lastElement {
                        //call get api for next page
                        pageNo += 1
                    }
                }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
