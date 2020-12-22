//
//  NotificationListingViewController.swift
//  Pulse
//
//  Created by FraunhoferWork on 15/12/2020.
//

import UIKit

class NotificationListingViewController: BaseViewController {
    var viewModel : NotificationListingViewModel!
    var cellsCurrentlyEditing = Set<IndexPath>()
    
    @IBOutlet weak var tblView : UITableView!{
        didSet{
            tblView.delegate = self
            tblView.dataSource = self
            Utilities.registerNib(nibName: "NotificationListingTableViewCell", identifier: "NotificationListingTableViewCell", tblView: tblView)
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarType = self.viewModel.getNavigationBar()
        self.getData()
        // Do any additional setup after loading the view.
    }

}
extension NotificationListingViewController{
    func getData(){
        self.viewModel.getAllNotifications { (success, serverMsg) in
            if success{
                self.tblView.reloadData()
            }
        }
    }
}
extension NotificationListingViewController: UITableViewDataSource , UITableViewDelegate,SwipeableCellDelegate{
    func didTapOnDelete(row: Int) {
        print("Delete row at \(row)")
        self.viewModel.didTapOnDelete(row: row) { (success, serverMsg) in
            if success{
                self.tblView.reloadData()
            }
            else{
                Alert.showAlertWithAutoHide(title: ErrorDescription.errorTitle.rawValue, message: serverMsg, autoHidetimer: 2.0, type: .error)
            }
        }
    }
    func cellDidOpen(row: Int) {
        let indexPath : IndexPath = IndexPath(row: row, section: 0)
        self.cellsCurrentlyEditing.insert(indexPath)
        
    }
    func cellDidClose(row: Int) {
        let indexPath : IndexPath = IndexPath(row: row, section: 0)
        self.cellsCurrentlyEditing.remove(indexPath)
        
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getNotificationArrCount()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationListingTableViewCell", for: indexPath) as! NotificationListingTableViewCell
        cell.delegate = self
        if self.cellsCurrentlyEditing.contains(indexPath){
            cell.openCell()
        }
        else{
            cell.resetConstraintContstantsToZero(animated: false, notifyDelegateDidClose: false)
        }
        let cellViewModel = self.viewModel.cellViewModelForRow(row: indexPath.row)
        cell.cellViewModel = cellViewModel
        cell.tag = indexPath.row
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
            -> UISwipeActionsConfiguration? {
            let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
                // delete the item here
                completionHandler(true)
            }
            deleteAction.image = UIImage(systemName: "trash")
            deleteAction.backgroundColor = .systemRed
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
            return configuration
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.didTapOnCell(row: indexPath.row) { (vc) in
            guard let vc = vc else { return }
            AppRouter.goToSpecificController(vc: vc)
        }
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return DesignUtility.convertToRatio(90, sizedForIPad: false, sizedForNavi: false)
//    }
}
