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
        setupBinding()
    }

}
extension ForgetPasswordViewController{
   
    @objc private func didTapOnBack(){
        AppRouter.pop()
    }
    private func setupViews(){
        navBarType = self.viewModel.getNavigationBar()
        btnNext.addTarget(self, action: #selector(self.didTapOnForgetBtn(sender:)), for: .touchUpInside)
        btnBackToLogin.addTarget(self, action: #selector(self.didTapOnBack), for: .touchUpInside)

    }
    
    private func setupBinding(){
        txtEmail.bind(with: self.viewModel.email)
        self.viewModel.email.value = "hamzakhancs15@gmail.com"
    }
    
    @objc private func didTapOnForgetBtn(sender : BaseUIButton){
      self.viewModel.resetPassword { (success, serverMsg) in
         if success{
        
            Alert.showAlertWithAutoHide(title: "", message: "An OTP has been sent. Kindly check your email.", autoHidetimer: 4, type: .success)
            self.goToChangePassword()
         }
         else{
            Alert.showAlertWithAutoHide(title: ErrorDescription.errorTitle.rawValue, message: serverMsg, autoHidetimer: 2, type: .error)

         }
      }
    }
    private func goToChangePassword(){
        let changePassword = OTPBuilder.build(email: self.viewModel.email.value ?? "")
        self.navigationController?.pushViewController(changePassword, animated: true)
    }
}
extension ForgetPasswordViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
