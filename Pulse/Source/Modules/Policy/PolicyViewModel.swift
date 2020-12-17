//
//  PolicyViewModel.swift
//  Pulse
//
//  Created by FraunhoferWork on 17/12/2020.
//

import Foundation
class PolicyViewModel {
    
    let headerTitle: String!
    private let navBarType : navigationBarTypes!
    let repo : PolicyRepository!
    
    init(navigationType navBar : navigationBarTypes, repo : PolicyRepository, title : String) {
        self.navBarType = navBar
        self.repo = repo
        self.headerTitle = title
    }
    func getTitle()->String{
        return headerTitle
    }
    func getNavigationBar()-> navigationBarTypes{
        return navBarType
    }
    func getPolicy(completionHandler: @escaping ( _ success : Bool , _ serverMsg : String)->Void){
        self.repo.getPolicy(completionHandler: { (success, serverMsg) in
            completionHandler(success, serverMsg)
        })
    }
}
