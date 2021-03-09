//
//  SearchViewController.swift
//  Pulse
//
//  Created by Hamza Khan on 27/11/2020.
//

import UIKit
import ViewAnimator
class SearchViewController: BaseViewController {
    @IBOutlet weak var tblView : UITableView!{
        didSet{
            tblView.delegate = self
            tblView.dataSource = self
            tblView.tableFooterView = UIView()
        }
    }
    let fromAnimation = AnimationType.vector(CGVector(dx: 30, dy: 0))

    var viewModel : SearchViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
//        _headerView.searchTextField?.placeholder = "Min. 3 charachters required for search"
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        UIView.animate(withDuration: 0.25) {
                self.view.alpha = 1
            }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)

        UIView.animate(withDuration: 0.25) {
                self.view.alpha = 1
            }
    }
    override func headerViewLeftBtnDidClick(headerView: HeaderView) {
        self.dismiss(animated: true) {
            
        }
    }
    override func headedrViewSearchTextChanged(str: String) {
        if str.count > 1{
            self.viewModel.getSearchData(searchText: str) { (success, serverMsg) in
                if success{
                    self.tblView.reloadData()
                    UIView.animate(views: self.tblView.visibleCells,
                                   animations: [self.fromAnimation], delay: 0.1)

                }
            }
        }
    }

}
extension SearchViewController{

    func setupView(){
        view.alpha = 0
        _headerView.searchTextField?.becomeFirstResponder()
        _headerView.leftButtonImage = "search-close-icon"
        navBarType = self.viewModel.getNavigationBar()
            view.isOpaque = false
        view.backgroundColor = UIColor.clear

            let blurBgView = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
            blurBgView.translatesAutoresizingMaskIntoConstraints = false

            view.insertSubview(blurBgView, at: 0)

            NSLayoutConstraint.activate([
                blurBgView.heightAnchor.constraint(equalTo: view.heightAnchor),
                blurBgView.widthAnchor.constraint(equalTo: view.widthAnchor),
                ])
    }
}
extension SearchViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getSearchCount()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        let cellViewModel = self.viewModel.cellViewModelForRow(row: indexPath.row)
        cell.cellViewModel = cellViewModel
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.didTapOnCell(row: indexPath.row) { (vc) in
            AppRouter.goToSpecificController(vc: vc)
        }
    }
}
