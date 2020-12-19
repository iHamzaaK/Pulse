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
    @IBOutlet weak var lblName : BaseUILabel!
    @IBOutlet weak var imgView : BaseUIImageView!
    @IBOutlet weak var tblView : UITableView!{
        didSet{
            tblView.delegate = self
            tblView.dataSource = self
        }
    }
    @IBOutlet weak var btnClose : BaseUIButton!
    @IBOutlet weak var btnEditProfile : BaseUIButton!{
        didSet{
            btnEditProfile.addTarget(self, action: #selector(self.didTapOnEditProfile), for: .touchUpInside)
        }
    }
    @IBOutlet weak var btnLogout : BaseUIButton!{
        didSet{
            btnLogout.addTarget(self, action: #selector(self.didTapOnLogout), for: .touchUpInside)
        }
    }
    @IBOutlet weak var btnTerms : BaseUIButton!{
        didSet{
            btnTerms.addTarget(self, action: #selector(self.didTapOnTerms), for: .touchUpInside)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
}
extension RightMenuViewController{
    private func setupView(){
        Utilities.addBlur(view: self.view, blurEffect: .systemUltraThinMaterialLight)
        navBarType = self.viewModel.getNavigationBar()
        btnClose.addTarget(self, action: #selector(self.didTapOnClose), for: .touchUpInside)
        btnEditProfile.addTarget(self, action: #selector(self.didTapOnClose), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateImage), name: Notification.Name("updateUserImage"), object: nil)
    }
    @objc func updateImage(){
        let user = ArchiveUtil.getUser()
        guard let avatarURL = user?.getAvatarURL() else { return }
        lblName.text = (user?.firstName ?? "") + " " + (user?.lastName ?? "")
        Utilities.getImageFromURL(imgView: imgView, url: avatarURL){ (_) in
            
        }
    }
}
extension RightMenuViewController{
    @objc func didTapOnClose(){
        AppRouter.showHideRightMenu()
    }
    @objc func didTapOnEditProfile(){
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (_) in
            AppRouter.goToSpecificController(vc: MyProfileBuilder.build())
        }
        slideMenu.closeRight()
    }
    @objc func didTapOnLogout(){
        AppRouter.logout()
    }
    @objc func didTapOnTerms(){
//        AppRouter.goToSpecificController(vc: FullArticleBuilder.build())
        AppRouter.goToSpecificController(vc: PolicyBuilder.build(title: "Terms and Conditions", endPoint: "terms-conditions"))
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
        return self.viewModel.getHeightForTableViewRow()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.didSelectTableCell(row: indexPath.row)
    }
    
}
