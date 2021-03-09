//
//  MyProfileViewController.swift
//  Pulse
//
//  Created by Hamza Khan on 19/11/2020.
//

import UIKit
import TextFieldEffects
import ViewAnimator
class MyProfileViewController: BaseViewController {
    
    var viewModel : MyProfileViewModel!
    var imagePicker : ImagePicker!
    let font = UIFont.init(name: "Montserrat-Regular" , size: DesignUtility.convertToRatio(18, sizedForIPad: DesignUtility.isIPad, sizedForNavi: false))
    let fromAnimation = AnimationType.vector(CGVector(dx: 30, dy: 0))
    let zoomAnimation = AnimationType.zoom(scale: 0.5)
    let rotateAnimation = AnimationType.rotate(angle: CGFloat.pi/6)
    private let animations = [AnimationType.vector((CGVector(dx: 0, dy: 30)))]

    @IBOutlet weak var txtSetNewPass: HoshiTextField!{
        didSet{
            txtSetNewPass.font = font
        }
    }
    @IBOutlet weak var txtConfirrmPass: HoshiTextField!{
        didSet{
            txtConfirrmPass.font = font
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.isHidden = self.viewModel.hideCategories

            Utilities.registerNibForCollectionView(nibName: "CategoriesCollectionViewCell", identifier: "CategoriesCollectionViewCell", colView: collectionView)
        }
    }
    @IBOutlet weak var btnHidePasswordView: BaseUIButton!{
        didSet{
            btnHidePasswordView.addTarget(self, action: #selector(self.didTapOnHidePassword(_:)), for: .touchUpInside)
        }
    }
    @IBOutlet weak var btnSetPassword: BaseUIButton!{
        didSet{
            btnSetPassword.addTarget(self, action: #selector(self.didTapOnSetPassword(_:)), for: .touchUpInside)
        }
    }
    @IBOutlet weak var btnMyInterest: UIButton!{
        didSet{
            btnMyInterest.addTarget(self, action: #selector(self.didTapOnExpand(_:)), for: .touchUpInside)
        }
    }
    @IBOutlet weak var btnChangePassword: UIButton!{
        didSet{
            btnChangePassword.addTarget(self, action: #selector(self.didTapOnChangePassword(_:)), for: .touchUpInside)
        }
    }
    @IBOutlet weak var btnEditDisplayImage: BaseUIButton!{
        didSet{
            btnEditDisplayImage.addTarget(self, action: #selector(self.didTapOnEditImage(_:)), for: .touchUpInside)
        }
    }
    @IBOutlet weak var lblUserName: BaseUILabel!
    @IBOutlet weak var blurView : BaseUIView!
    @IBOutlet weak var coverImage : BaseUIImageView!
    @IBOutlet weak var displayImage : BaseUIImageView!
    @IBOutlet weak var passwordView : BaseUIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupData()
        setupBinding()
        animateViews()
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.viewModel.updateSubscription { (success, serverMsg) in
            if success{
                //print("Subscription added")
            }
        }
    }
    
}
extension MyProfileViewController{
    private func animateViews(){
        UIView.animate(views: [self.displayImage,btnEditDisplayImage],
                       animations: [zoomAnimation],
                       duration: 0.5)
        UIView.animate(views: [lblUserName],
                       animations: [fromAnimation],
                       duration: 0.5)
        
        
        
    }
    private func setupBinding(){
        txtSetNewPass.bind(with: self.viewModel.password)
        txtConfirrmPass.bind(with: self.viewModel.confirmPassword)

    }
    func setupViews(){
        navBarType = self.viewModel.getNavigationBar()
        collectionView.collectionViewLayout = setFlowLayout()
        Utilities.addBlur(view: blurView, blurEffect: .systemThinMaterialDark)
        Utilities.addBlur(view: passwordView, blurEffect: .systemThinMaterialLight)
        self.passwordView.isHidden = self.viewModel.hidePasswordView

        self.view.sendSubviewToBack(self.displayImage)
        self.view.bringSubviewToFront(self.btnEditDisplayImage)
        _headerView.bgColorVar = "cc"
        self.view.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    func setupData(){
        
        self.lblUserName.text = self.viewModel.getName()
        if self.viewModel.categories.count < 1{
            self.viewModel.getCategories { (sucess, servermsg) in
                if  sucess{
                    self.collectionView.reloadData()
                    self.collectionView.performBatchUpdates({
                       
                    }, completion: nil)
                }
            }
        }
        let user = ArchiveUtil.getUser()
        guard let avatarURL = user?.getAvatarURL() else { return }
        Utilities.getImageFromURL(imgView: displayImage, url: avatarURL) { (_) in
            
        }
    }
    func setFlowLayout()-> UICollectionViewFlowLayout{
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        return layout
    }
    @objc private func didTapOnHidePassword(_ sender : BaseUIButton){
        self.viewModel.hidePasswordView = !self.viewModel.hidePasswordView
        self.passwordView.isHidden = self.viewModel.hidePasswordView

    }
    @objc private func didTapOnSetPassword(_ sender : BaseUIButton){
        self.viewModel.changePassword { (success, serverMsg) in
            if success{
                self.viewModel.hidePasswordView = true
                self.passwordView.isHidden = self.viewModel.hidePasswordView
                UIView.animate(views: [self.passwordView],
                               animations: [self.zoomAnimation],
                               duration: 0.8)

            }
        }
    }
    @objc private func didTapOnChangePassword(_ sender : BaseUIButton){
        self.viewModel.hidePasswordView = !self.viewModel.hidePasswordView
        self.passwordView.isHidden = self.viewModel.hidePasswordView
        self.view.bringSubviewToFront(passwordView)
    }
    @objc private func didTapOnExpand(_ sender : BaseUIButton){
        self.viewModel.hideCategories = !self.viewModel.hideCategories
        self.collectionView.isHidden = self.viewModel.hideCategories
        if self.collectionView.isHidden == false{
            self.collectionView.reloadData()
            UIView.animate(views: self.collectionView.orderedVisibleCells,
                           animations: self.animations, duration: 0.9, options: [.curveEaseInOut], completion: {
                })
        }
    }
    
    
}
extension MyProfileViewController: ImagePickerDelegate{
    @objc private func didTapOnEditImage(_ sender : BaseUIButton){
        self.imagePicker.present(from: self.btnEditDisplayImage)
    }
    func didSelect(image: UIImage?) {
        DispatchQueue.main.async {
            guard let pictureData = image?.jpegData(compressionQuality: 0.50) else { return }
            self.viewModel.updatePicture(avatar: pictureData) { (success, serverMsg) in
                if success{
                NotificationCenter.default.post(name: Notification.Name("updateUserImage"), object: nil)
                self.displayImage.image = image
                self.coverImage.image = image
                }
            }
        }
    }
    
}
extension MyProfileViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout ,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.getCategoriesCount()
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as! CategoriesCollectionViewCell
        let cellViewModel = self.viewModel.getCellViewModelForRow(row: indexPath.row)
        let isSubscribed = self.viewModel.checkSubscription(row: indexPath.row)
        cell.cellViewModel = cellViewModel
        let cellFont = cell.lblTitle.font.fontName
        cell.lblTitle.font = UIFont(name: cellFont, size: DesignUtility.convertToRatio(14, sizedForIPad:  DesignUtility.isIPad, sizedForNavi: false))
        cell.showSubscription(isSubscribed: isSubscribed)
        if indexPath.row == 0{
            cell.imgViewLayer.image = UIImage(named: "colHeaderLayer")
        }
        else{
            cell.imgViewLayer.image = UIImage(named: "colLayer")
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CategoriesCollectionViewCell
        self.viewModel.didSelectItem(row: indexPath.row)
        cell.showSubscription(isSubscribed: self.viewModel.checkSubscription(row: indexPath.row))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.viewModel.getItemHeight(collectionWidth: self.collectionView.bounds.width)
    }
    
    
}
