//
//  MyProfileViewController.swift
//  Pulse
//
//  Created by Hamza Khan on 19/11/2020.
//

import UIKit

class MyProfileViewController: BaseViewController {
    
    var viewModel : MyProfileViewModel!
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            Utilities.registerNibForCollectionView(nibName: "CategoriesCollectionViewCell", identifier: "CategoriesCollectionViewCell", colView: collectionView)
        }
    }
    @IBOutlet weak var btnMyInterest: UIButton!
    @IBOutlet weak var btnChangePassword: UIButton!
    @IBOutlet weak var btnEditDisplayImage: BaseUIButton!
    @IBOutlet weak var lblUserName: BaseUILabel!
    @IBOutlet weak var blurView : BaseUIView!
    @IBOutlet weak var coverImage : BaseUIImageView!
    @IBOutlet weak var displayImage : BaseUIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarType = self.viewModel.getNavigationBar()
        collectionView.collectionViewLayout = setFlowLayout()
        Utilities.addBlur(view: blurView, blurEffect: .systemThinMaterialDark)
        self.view.sendSubviewToBack(self.displayImage)
        self.view.bringSubviewToFront(self.btnEditDisplayImage)
        _headerView.bgColorVar = "cc"
        self.view.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)


    }
    
    func setFlowLayout()-> UICollectionViewFlowLayout{
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        return layout
        
        
    }
}
extension MyProfileViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout ,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as! CategoriesCollectionViewCell

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            var width  = collectionView.frame.width
        width = UIScreen.main.bounds.width/3.4
        
                return CGSize(width: width, height: width)
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
}
