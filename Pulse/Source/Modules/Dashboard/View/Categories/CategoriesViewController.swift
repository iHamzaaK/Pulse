//
//  CategoriesViewController.swift
//  Pulse
//
//  Created by Hamza Khan on 10/11/2020.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    var viewModel : CategoriesViewModel!
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            Utilities.registerNibForCollectionView(nibName: "CategoriesCollectionViewCell", identifier: "CategoriesCollectionViewCell", colView: collectionView)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = setFlowLayout()
    }
    
    func setFlowLayout()-> UICollectionViewFlowLayout{
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        return layout
        
        
    }
}
extension CategoriesViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout ,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as! CategoriesCollectionViewCell

        return cell
    }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            var width  = collectionView.frame.width
            var height : CGFloat = 200.0
            if indexPath.row != 0 {
                width = UIScreen.main.bounds.width/2 - 2
                height = width
            }
                return CGSize(width: width, height: height)
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 8{
            AppRouter.goToSpecificController(vc: QuotesBuilder.build())
        }
        else if indexPath.row == 9{
            AppRouter.goToSpecificController(vc: VideosBuilder.build())
        }
    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    //        return 5.0
    //    }
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    //        return 5.0
    //    }
    
}
