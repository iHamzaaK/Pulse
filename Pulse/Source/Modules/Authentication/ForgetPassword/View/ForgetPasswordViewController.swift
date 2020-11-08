//
//  ForgetPasswordViewController.swift
//  Pulse
//
//  Created by Hamza Khan on 07/11/2020.
//

import UIKit
import TextFieldEffects
class ForgetPasswordViewController: BaseViewController {
    
    var viewModel : ForgetPasswordViewModel!
    @IBOutlet weak var txtEmail: HoshiTextField!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnBackToLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

}
extension ForgetPasswordViewController{
    @objc private func didTapOnNext(){
        
    }
    @objc private func didTapOnBack(){
        AppRouter.pop()
    }
    private func setupViews(){
        navBarType = self.viewModel.getNavigationBar()
        btnNext.addTarget(self, action: #selector(self.didTapOnNext), for: .touchUpInside)
        btnBackToLogin.addTarget(self, action: #selector(self.didTapOnBack), for: .touchUpInside)

    }
}
extension ForgetPasswordViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
