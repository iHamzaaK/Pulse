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
    let font = UIFont.init(name: "Montserrat-Regular" , size: DesignUtility.convertToRatio(18, sizedForIPad: DesignUtility.isIPad, sizedForNavi: false))
    @IBOutlet weak var txtEmail: HoshiTextField!{
        didSet{
            txtEmail.addTarget(self, action: #selector(self.didChangeText), for: .editingChanged)
            txtEmail.font = font
        }
    }
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnBackToLogin: UIButton!
    @IBOutlet weak var lblEmailError: UILabel!{
        didSet{
            lblEmailError.text = ""
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupBinding()
        lblEmailError.isHidden = false
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
        self.viewModel.email.value = ""
    }
    
    @objc private func didTapOnForgetBtn(sender : BaseUIButton){
      self.viewModel.resetPassword { (success, serverMsg) in
         if success{
        
            Alert.showAlertWithAutoHide(title: "", message: "An OTP has been sent. Kindly check your email.", autoHidetimer: 4, type: .success)
            self.goToChangePassword()
         }
         else{
            self.lblEmailError.text = serverMsg
            self.lblEmailError.isHidden = false
//            Alert.showAlertWithAutoHide(title: ErrorDescription.errorTitle.rawValue, message: serverMsg, autoHidetimer: 2, type: .error)

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
        txtEmail.resignFirstResponder()
        return true
    }
    @objc func didChangeText(){
        lblEmailError.text = ""
        lblEmailError.isHidden = true
    }
}
