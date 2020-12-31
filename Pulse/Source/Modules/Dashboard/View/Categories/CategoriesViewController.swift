//
//  CategoriesViewController.swift
//  Pulse
//
//  Created by Hamza Khan on 10/11/2020.
//

import UIKit
import ViewAnimator
class CategoriesViewController: UIViewController {
    
    var viewModel : CategoriesViewModel!
    var refreshControl = UIRefreshControl()
    private let animations = [AnimationType.vector((CGVector(dx: 0, dy: 30)))]
    let fromAnimation = AnimationType.vector(CGVector(dx: 30, dy: 0))

    @IBOutlet weak var lblSubCategoryTitle : BaseUILabel!
//    let subCategoryHeight : CGFloat = DesignUtility.convertToRatio(407, sizedForIPad: false, sizedForNavi: false)
    var hideSubcategory: Bool = true{
        didSet{
            subCategoryView.isHidden = hideSubcategory
            if !hideSubcategory{
                self.lblSubCategoryTitle.text = "Sub Categories - " + self.viewModel.strCategoryTitle
            
//            let contentHeightTableView = self.tblView.contentSize.height
//            if contentHeightTableView < self.subCategoryHeight{
//                heightConstraintSubCategoryTableView.constant = contentHeightTableView
//            }
//            else{
//                heightConstraintSubCategoryTableView.constant = subCategoryHeight
//            }
            }
        }
    }
    @IBOutlet weak var heightConstraintSubCategoryTableView : NSLayoutConstraint!
    @IBOutlet weak var tblView : UITableView!{
        didSet{
            tblView.delegate = self
            tblView.dataSource = self
            tblView.estimatedRowHeight = 50
            tblView.rowHeight = UITableView.automaticDimension
            Utilities.registerNib(nibName: "SubCategoryTableViewCell", identifier: "SubCategoryTableViewCell", tblView: tblView)
        }
    }
    @IBOutlet weak var subCategoryView : BaseUIView!{
        didSet{
            
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            Utilities.registerNibForCollectionView(nibName: "CategoriesCollectionViewCell", identifier: "CategoriesCollectionViewCell", colView: collectionView)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getCategories()
        setupSubCategoryView()
        setupView()
    }
    func setupView(){
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tblView .addSubview(refreshControl) // not required when using UITableViewController

    }
    func setupSubCategoryView(){
        var shadows = UIView()
        shadows.frame = subCategoryView.frame
        shadows.clipsToBounds = false
        self.subCategoryView.addSubview(shadows)
        let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 0)
        let layer0 = CALayer()
        layer0.shadowPath = shadowPath0.cgPath
        layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        layer0.shadowOpacity = 1
        layer0.shadowRadius = 40
        layer0.shadowOffset = CGSize(width: 0, height: -12)
        layer0.bounds = shadows.bounds
        layer0.position = shadows.center
        shadows.layer.addSublayer(layer0)
        var shapes = UIView()
        shapes.frame = subCategoryView.frame
        shapes.clipsToBounds = true
        subCategoryView.addSubview(shapes)
        let layer1 = CALayer()
        layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.9).cgColor
        layer1.bounds = shapes.bounds
        layer1.position = shapes.center
        shapes.layer.addSublayer(layer1)
//        Utilities.addBlur(view: subCategoryView, blurEffect: .systemUltraThinMaterial)
        subCategoryView.alpha = 0.9
    }
    func setFlowLayout()-> UICollectionViewFlowLayout{
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        return layout
        
        
    }
    func getCategories(){
        self.subCategoryView.isHidden = true
        self.viewModel.getCategories { (sucess, serverMsg) in
            if sucess{
                self.collectionView.delegate = self
                self.collectionView.dataSource = self
                self.collectionView.reloadData()
                self.collectionView.performBatchUpdates({
                    UIView.animate(views: self.collectionView!.orderedVisibleCells,
                                   animations: self.animations, options: [.curveEaseInOut], completion: {
                        })
                }, completion: nil)
            }
        }
        collectionView.collectionViewLayout = setFlowLayout()
    }
    @objc func refresh(_ sender: AnyObject) {
        getCategories()
    }
    
    @IBAction func didTapOnCloseSubCategory(_ sender : BaseUIButton){
        hideSubcategory = true
    }
    
}
extension CategoriesViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout ,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.getNumberOfCategoriesForCollection()
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as! CategoriesCollectionViewCell
        let cellViewModel = self.viewModel.getCellViewModelForRow(row: indexPath.row)
        if indexPath.row == 0{
            cell.imgViewLayer.image = UIImage(named: "colHeaderLayer")
        }
        else{
            cell.imgViewLayer.image = UIImage(named: "colLayer")
        }
        cell.cellViewModel = cellViewModel
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.viewModel.getItemHeight(row: indexPath.row)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let showSubcategory = self.viewModel.showSubcategory(row: indexPath.row)
        if showSubcategory{
            tblView.reloadData()
            UIView.animate(views: self.tblView.visibleCells,
                           animations: [fromAnimation], delay: 0.2)
            hideSubcategory = false
        }
        else{
            
            self.viewModel.goToCategoryPostsForParent(row: indexPath.row) { (vc) in
                AppRouter.goToSpecificController(vc: vc)
            }
        }
    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    //        return 5.0
    //    }
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    //        return 5.0
    //    }
    
}
extension CategoriesViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getSubCategoryCount()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubCategoryTableViewCell") as! SubCategoryTableViewCell
        let cellViewModel = self.viewModel.getCellViewModelForRow(row: indexPath.row)
        cell.cellViewModel = cellViewModel
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.goToCategoryPostsForSubCategoory(row: indexPath.row) { (vc) in
            AppRouter.goToSpecificController(vc: vc)
        }

    }
}
