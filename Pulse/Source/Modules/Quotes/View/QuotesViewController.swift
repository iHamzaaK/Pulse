//
//  QoutesViewController.swift
//  Pulse
//
//  Created by Hamza Khan on 14/11/2020.
//

import UIKit

class QuotesViewController: BaseViewController {
    var viewModel : QuotesViewModel!
    @IBOutlet weak var tblView: UITableView!{
        didSet{ 
            tblView.delegate = self
            tblView.dataSource = self
            tblView.estimatedRowHeight = 50
            tblView.rowHeight = UITableView.automaticDimension
            Utilities.registerNib(nibName: "QuotesTableViewCell", identifier: "QuotesTableViewCell", tblView: tblView)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarType = self.viewModel.getNavigationBar()
        self.view.backgroundColor =  Utilities.hexStringToUIColor(hex: "E5E5E5")
        self.tblView.backgroundColor =  Utilities.hexStringToUIColor(hex: "E5E5E5")
        self.tblView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0);
        self.viewModel.getQuotes { (success, serverMsg) in
            if success{
                self.tblView.reloadData()
            }
            else{
                Alert.showAlertWithAutoHide(title: ErrorDescription.errorTitle.rawValue, message: serverMsg, autoHidetimer: 2.0, type: .error)
            }
        }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension QuotesViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getQuotesCount()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuotesTableViewCell") as! QuotesTableViewCell
        cell.cellViewModel = self.viewModel.cellViewModelForRow(row: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
