//
//  ArticleListing.swift
//  Pulse
//
//  Created by Hamza Khan on 05/12/2020.
//

import Foundation
class ArticleListingViewModel
{
    let headerTitle: String!
    private let navBarType : navigationBarTypes!
    let type : articleListingType!
    let repository : ArticleListingRepository!
    var categoryId = -1
    var artiicleList : [ArticleListingData] = []
    var quote : [ArticleListingQuoteOfTheDay] = []
    var maximumPages = 1
    init(navigationType navBar : navigationBarTypes, type : articleListingType, repo : ArticleListingRepository, categoryId : Int?, title : String) {
        self.navBarType = navBar
        self.type = type
        self.repository = repo
        if categoryId != nil{
            self.categoryId = categoryId ?? -1
        }
        self.headerTitle = title
    
    }
    func getNavigationBar()-> navigationBarTypes{
        return navBarType
    }
    func getHeaderTitle()->String{
        self.headerTitle
    }
    func getArticleCount()->Int{
        return self.artiicleList.count
    }
    func showTitle()->Bool{
        if type != articleListingType.bookmarks && type != articleListingType.interest{
            return true
        }
        return false
    }
    func showQuoteView()->Bool{
        if type == articleListingType.topStories{
            return true
        }
        return false
    }
    func getListing(paged: Int, completionHandler: @escaping (Bool, String)->Void){
        var id : Int? = nil
        if categoryId != -1{
            id = categoryId
        }
        if paged == 1 || paged < maximumPages{
        self.repository.getListing(type: self.type, paged: paged, categoryId: categoryId) { (success, serverMsg, data, quote , maxPage)  in
            self.maximumPages = maxPage
            self.artiicleList.append(contentsOf: data ?? [])
            self.quote = quote ?? []
            completionHandler(success, serverMsg)
        }
        }
    }
    func cellViewModelForRow(row:Int)->ArticleListingCellViewModel{
        let article = artiicleList[row]
        let cellViewModel = ArticleListingCellViewModel(articleID: article.id ?? -1, title: article.title ?? "", permalink: article.permalink ?? "", thumbnail: article.thumbnail  ?? "", description: article.descriptionField  ?? "", isVideo: article.isVideo ?? false, videoURL: article.videoUrl ?? "", type : self.type,shortDescription: article.shortDescription , date: article.date ,tag: article.tag,isBookmarked: article.isBookmarked,isLiked: article.isLiked , likeCount: article.likeCount)
        return cellViewModel
    }
    func didTapOnCell(row: Int, completionHandler:( _ vc : UIViewController)->Void){
        
    }
}


struct ArticleListingCellViewModel{
    let articleID : Int
    let title : String
    let permalink : String
    let thumbnail : String
    let description : String
    let isVideo : Bool
    let videoURL : String
    let type : articleListingType
    let shortDescription: String
    let date : String
    let tag : String
    let isBookmarked : Bool
    let isLiked : Bool
    let likeCount : Int
    
    func getShortDescription()->String{
        return shortDescription
    }
    func showBookmark()->UIImage{
        var imageName = "icon-bookmark"
        if isBookmarked{
            imageName += "-filled"
        }
        return UIImage.init(named: imageName)!
        
    }
    func showTotalLikes()->String{
        var strUserLiked = ""
        var othersLiked = ""
        if isLiked{
            strUserLiked = "You"
        }
        if likeCount > 0{
            othersLiked = "\(likeCount) others liked this"
        }
        
        if isLiked && likeCount > 0{
            return strUserLiked + " and " + othersLiked
        }
        else if isLiked && likeCount < 1{
            return "\(strUserLiked) liked this"
        }
        else if !isLiked &&  likeCount > 0{
            return othersLiked
        }
        else{
            return ""
        }
    }
    func showLiked()->UIImage{
        var imageName = "icon-like"
        if isLiked{
            imageName += "-filled"
        }
        return UIImage.init(named: imageName)!
    }
    
    func getVideoURL()-> URL?{
        guard let url = URL(string: videoURL) else { return nil}
        return url
    }
    func getBgImageURLForCell()-> URL?{
        return URL(string: thumbnail)

    }
    func getDescription()-> NSAttributedString?{
        var fontSize = 15
        if DesignUtility.isIPad{
            fontSize = 22
        }
        fontSize = Int(DesignUtility.convertToRatio(CGFloat(fontSize), sizedForIPad: DesignUtility.isIPad, sizedForNavi: false))
        let attirbutedString = Utilities.getAttributedStringForHTMLWithFont(description, textSize: fontSize, fontName: "Helvetica")
        return attirbutedString
    }
}
