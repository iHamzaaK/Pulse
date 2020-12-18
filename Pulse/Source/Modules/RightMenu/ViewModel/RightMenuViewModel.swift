
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
//    case write
    case home
    case bookmarks
    case settings
    case privacyPolicy
}
class RightMenuViewModel{
    private var navBarType : navigationBarTypes!
    private var tblCells = [RightMenuCellModel]()
    var cellHeight : CGFloat = 0.0
    init(navigationType navBar : navigationBarTypes){
        self.navBarType = navBar
        tblCells = [
//            RightMenuCellModel(value: "Write a news/story   ", image: ""),
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
    func isEditor()->Bool{
        return false
    }
    func didSelectTableCell(row: Int){
        guard let rightCell = RightMenuCell(rawValue: row) else { return }
        switch rightCell {
//        case .write:
//            NotificationCenter.default.post(name: Notification.Name("createPost"), object: nil)
//            AppRouter.showHideRightMenu()
//            break
        case .home:
            AppRouter.goToHomeFromRightMenu()
            break
        case .bookmarks:
            break
        case .settings:
            AppRouter.goToSpecificController(vc: SettingsBuilder.build())
            break
        case .privacyPolicy:
            AppRouter.goToSpecificController(vc: PolicyBuilder.build(title: "Privacy Policy"))
            break
            
        }
    }
    func getHeightForTableViewRow()->CGFloat{
        var height : CGFloat = 40
//        if DesignUtility.isIPad{
//            height = 50
//        }
        cellHeight = DesignUtility.convertToRatio(height, sizedForIPad: DesignUtility.isIPad, sizedForNavi: false)
        return cellHeight
    }
    
}
