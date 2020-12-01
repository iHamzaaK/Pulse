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
    
    private func setupBinding(){
        txtEmail.bind(with: self.viewModel.email)
    }
    
    @objc private func didTapOnForgetBtn(sender : BaseUIButton){
      self.viewModel.resetPassword { (success, serverMsg) in
         if success{
        
            Alert.showAlertWithAutoHide(title: "", message: "A reset link and reset code has been sent to your email address. Follow those steps and reset your password", autoHidetimer: 4, type: .success)
            self.goToChangePassword()
         }
         else{
            Alert.showAlertWithAutoHide(title: ErrorDescription.errorTitle.rawValue, message: serverMsg, autoHidetimer: 2, type: .error)

         }
      }
    }
    private func goToChangePassword(){
        let changePassword = ConfirmPasswordBuilder.build(email: self.viewModel.email.value ?? "")
        self.navigationController?.pushViewController(changePassword, animated: true)
    }
}
extension ForgetPasswordViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
