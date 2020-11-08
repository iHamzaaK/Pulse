
//
//  RightMenuViewMoedl.swift
//  Halal
//
//  Created by Hamza Khan on 19/11/2019.
//  Copyright © 2019 Hamza. All rights reserved.
//

import UIKit
struct RightMenuCellModel{
    var value : String
    var image : String
}
enum RightMenuCell : Int{
    case findRestaurants
    case aboutus
    case favorites
    case settings
    case d
    case logout
}
class RightMenuViewModel{
    private var navBarType : navigationBarTypes!
    private var tblCells = [RightMenuCellModel]()
    var cellHeight : CGFloat = DesignUtility.convertToRatio(40, sizedForIPad: false, sizedForNavi: false)
    init(navigationType navBar : navigationBarTypes){
        self.navBarType = navBar
        tblCells = [
            RightMenuCellModel(value: "Home", image: ""),
            RightMenuCellModel(value: "Bookmarks", image: ""),
            RightMenuCellModel(value: "Settings", image: ""),
            RightMenuCellModel(value: "Privacy Policy", image: ""),
        ]
    }
    func getNavigationBar()-> navigationBarTypes{
        return navBarType
    }
    func getTableCells()-> [RightMenuCellModel]{
        return tblCells
    }
    func didSelectTableCell(row: Int){
        guard let rightCell = RightMenuCell(rawValue: row) else { return }
        switch rightCell {
        case .findRestaurants:
//            let category = ArchiveUtil.loadCategories()
//            guard let categoryFirst = category.first else { return }
//            guard let id = categoryFirst.id else { return }
//            let userLocation = ArchiveUtil.getUserLocation()
//            guard let user = ArchiveUtil.loadUser() else { return }
//            let adDistance = user.no_of_ads_listing
//            let vc = RestaurantFinderBuilder.build(categoryId: id, userLat: userLocation.0, userLong: userLocation.1, no_of_ads_listing: adDistance)
//            AppRouter.goToSpecificController(vc: vc)
//            let vc = RestaurantFinderBuilder.build()
//            AppRouter.goToSpecificController(vc: vc)
            break
       
        case .logout:
            AppRouter.logout()
            break
        
        case .aboutus:
            break
        case .favorites:
            break
        case .settings:
            break
        case .d:
            break
        }
    }
    
}
