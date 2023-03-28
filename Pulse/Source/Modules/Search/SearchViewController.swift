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
  //    override func headerViewLeftBtnDidClick(headerView: HeaderView) {
  ////        self.dismiss(animated: true) {
  ////
  ////        }
  //    }
  override func headedrViewSearchTextChanged(str: String) {
    if str.count > 1{
      self.viewModel.getSearchData(searchText: str) { [weak self] (success, serverMsg) in
        guard self != nil else { return }

        if success{
          self!.tblView.reloadData()
          UIView.animate(views: self!.tblView.visibleCells,
                         animations: [self!.fromAnimation], delay: 0.1)

        }
      }
    }
  }
  override func headerViewRightBtnDidClick(headerView: HeaderView) {
    let filterVC = FilterBuilder.build(title: "Filter", navBarType: .filterNavBar) as! FilterViewController
    filterVC.delegate = self
    self.present(filterVC, animated: true) {
      
    }
  }

}
extension SearchViewController: FilterViewProtocol {
  func didTapOnDone(selectedFilter: SelectedFilters) {
    self.viewModel.getSearchData(searchText: selectedFilter.0, dateTime: selectedFilter.1) { [weak self] success, serverMsg in
      if success {
        guard self != nil else { return }
        self!.tblView.reloadData()
        UIView.animate(views: self!.tblView.visibleCells,
                       animations: [self!.fromAnimation], delay: 0.1)
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
    if self.viewModel.getSearchCount() == 0 {
      tableView.setEmptyMessage("No Articles Found")
    } else {
      tableView.restore()
    }
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

extension UITableView {

  func setEmptyMessage(_ message: String) {
    let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
    messageLabel.text = message
    messageLabel.textColor = .black
    messageLabel.numberOfLines = 0
    messageLabel.textAlignment = .center
    messageLabel.font = UIFont(name: "TrebuchetMS", size: 17)
    messageLabel.sizeToFit()

    self.backgroundView = messageLabel
    self.separatorStyle = .none
  }

  func restore() {
    self.backgroundView = nil
    self.separatorStyle = .singleLine
  }
}
