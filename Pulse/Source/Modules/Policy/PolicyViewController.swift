//
//  PolicyViewController.swift
//  Pulse
//
//  Created by FraunhoferWork on 17/12/2020.
//

import UIKit

class PolicyViewController: BaseViewController {
    var viewModel : PolicyViewModel!
    @IBOutlet weak var lblPolicy : BaseUILabel!
    @IBOutlet weak var txtViewPolicy : BaseUITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }

}
extension PolicyViewController{
    func setupView(){
        self.lblPolicy.text = self.viewModel.getTitle()
        self.txtViewPolicy.attributedText = getDescription()
        navBarType = self.viewModel.getNavigationBar()
    }
    func getData(){
        self.viewModel.getPolicy { (success, serverMsg) in
            
        }
    }
    func getDescription()->NSAttributedString?{
        let fontSize = DesignUtility.convertToRatio(15.0, sizedForIPad:  DesignUtility.isIPad, sizedForNavi: false)
        let text =  Utilities.getAttributedStringForHTMLWithFont("<b><i>THIS IS SAMPLE TEXT FOR POLICY</i></b>", textSize: Int(fontSize), fontName: "Montserrat-Regular")
    
        return text
    }
}
