//
//  CategoriesViewModel.swift
//  Pulse
//
//  Created by Hamza Khan on 10/11/2020.
//

import UIKit

class CategoriesViewModel
{
    let headerTitle = ""
    private let navBarType : navigationBarTypes!
    let repository : CategoriesRepository!
    var categories: [CategoriesData] = []
    var subCategory : [CategoriesChild] = []
    var strCategoryTitle = ""
    init(navigationType navBar : navigationBarTypes, repo : CategoriesRepository) {
        self.navBarType = navBar
        self.repository = repo
    }
    func getNavigationBar()-> navigationBarTypes{
        return navBarType
    }
    func getItemHeight(row : Int)-> CGSize{
        var width  = UIScreen.main.bounds.width
        var height : CGFloat = 200.0
        if  DesignUtility.isIPad{
            height = 415
        }
        height = DesignUtility.convertToRatio(height, sizedForIPad: DesignUtility.isIPad, sizedForNavi: false)
        
        if row != 0 {
            width = UIScreen.main.bounds.width/2 - 2
            height = width
        }
            return CGSize(width: width, height: height)
    }
    func getCellViewModelForRow(row: Int)->CategoryCellViewModel{
        let category = self.categories[row]
        let cellViewModel = CategoryCellViewModel(id: category.id, name: category.name ?? "", description: category.descriptionField ?? "", parent: category.parent ?? -1, icon: category.icon ?? "", image: category.image ?? "", child: category.child ?? [])
        return cellViewModel
        
    }
    func getCategories(completionHandler: @escaping (Bool, String) -> Void){
        self.repository.getCategories { (success, serverMsg, data) in
            self.categories = data
            completionHandler(success,serverMsg)
        }
    }
    func getNumberOfCategoriesForCollection()-> Int{
        return self.categories.count
    }
    func showChildrern(children : [CategoriesChild])->Bool{

            if children.count > 0{
                return true
            }
            return false
        
    }
    func getSubCategoryData(row: Int)->[CategoriesChild]{
        let category = self.categories[row]
        guard let children = category.child else { return [] }
        if showChildrern(children: children){
            return children
        }
        return []
    }
    func showSubcategory(row: Int)-> Bool{
        let category = self.categories[row]
        strCategoryTitle = category.name ?? ""
        
        guard let children = category.child else { return false }
        if showChildrern(children : children){
            subCategory = children
            return true
        }
        subCategory = []
        return false
    }
    func goToCategoryPostsForParent(row: Int, completionHandler: (_ vc: UIViewController)->Void){
        let category = self.categories[row]
        let vc = ArticleListingBuilder.build(title: category.name ?? "", type: .categories, categoryId: category.id)
        completionHandler(vc)
    }
    func goToCategoryPostsForSubCategoory(row: Int, completionHandler: (_ vc: UIViewController)->Void){
        let subCategoryId = subCategory[row].id
        let vc = ArticleListingBuilder.build(title: strCategoryTitle, type: .categories, categoryId: subCategoryId)
        completionHandler(vc)
    }
    func getSubCategoryCount()-> Int{
        return subCategory.count
    }
    
}
import Kingfisher

struct  CategoryCellViewModel {
    
    let id : Int!
    let name : String
    let description : String
    let parent : Int
    let icon : String
    let image : String
    let child : [CategoriesChild]
    
    func getBgImageURLForCell()-> URL?{
        return URL(string: image)

    }
    func getImageForCategoryLogo()-> URL?{
        return URL(string: icon)

    }
    func getChildren()->[CategoriesChild]{
        return child
    }
}
