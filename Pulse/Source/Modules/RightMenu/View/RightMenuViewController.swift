//
//  RightViewController.swift
//  Halal
//
//  Created by Hamza Khan on 19/11/2019.
//  Copyright © 2019 Hamza. All rights reserved.
//

import UIKit
class RightMenuViewController: BaseViewController {
    var viewModel : RightMenuViewModel!
    @IBOutlet weak var tblView : UITableView!{
        didSet{
            tblView.delegate = self
            tblView.dataSource = self
        }
    }
    @IBOutlet weak var btnClose : BaseUIButton!
    @IBOutlet weak var btnEditProfile : BaseUIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //        self.view.backgroundColor = Utilities.hexStringToUIColor(hex: "F0F0F0")
        setupView()
    }
    
}
extension RightMenuViewController{
    private func setupView(){
        addBlur()
        navBarType = self.viewModel.getNavigationBar()
        btnClose.addTarget(self, action: #selector(self.didTapOnClose), for: .touchUpInside)
        btnEditProfile.addTarget(self, action: #selector(self.didTapOnClose), for: .touchUpInside)      
    }
    private func addBlur(){
        self.view.backgroundColor = UIColor.clear
        
        //                 Create a blur effect
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemUltraThinMaterialLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        // Fill the view
        blurEffectView.frame = view.bounds
        
        // Ensure the blur conforms to resizing (not used in a fixed menu UI)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Add the view to the view controller stack
        view.addSubview(blurEffectView)
        
        //                 Ensure the blur view is in the back
        self.view.sendSubviewToBack(blurEffectView)
    }
    @objc func didTapOnClose(){
        AppRouter.showHideRightMenu()
    }
    @objc func updateLanguage(){
        self.tblView.reloadData()
    }
}
extension RightMenuViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getTableCells().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RightMenuTableViewCell
        cell.cellViewModel = self.viewModel.getTableCells()[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.viewModel.cellHeight
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.didSelectTableCell(row: indexPath.row)
    }
    
}
