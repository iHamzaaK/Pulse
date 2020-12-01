//
//  LoginViewController.swift
//  Pulse
//
//  Created by Hamza Khan on 07/11/2020.
//

import UIKit
import TextFieldEffects
class LoginViewController: BaseViewController {

    @IBOutlet weak var btnForgetPassword: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var txtPassword: HoshiTextField!
    @IBOutlet weak var txtEmail: HoshiTextField!
    @IBOutlet weak var lblEmailError: UILabel!{
        didSet{
            lblEmailError.text = ""
        }
    }
    @IBOutlet weak var lblPasswordError: UILabel!{
        didSet{
            lblPasswordError.text = ""
        }
    }
    var viewModel : LoginViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
        setupBinding()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
extension LoginViewController{
    private func setupViews(){
        navBarType = self.viewModel.getNavigationBar()
        txtPassword.isSecureTextEntry = true
        btnForgetPassword.addTarget(self, action: #selector(self.didTapOnForget), for: .touchUpInside)
        btnNext.addTarget(self, action: #selector(self.didTapOnLogin), for: .touchUpInside)

    }
    @objc private func didTapOnForget(){
        let vc = ForgetPasswordBuilder.build()
        AppRouter.goToSpecificController(vc: vc)
    }
    
    private func setupBinding(){
        txtEmail.bind(with: self.viewModel.email)
        txtPassword.bind(with: self.viewModel.password)
        self.viewModel.email.value = "hamzakhancs15@gmail.com"
        self.viewModel.password.value = "Object12#"
    }
    @objc private func didTapOnLogin(sender : BaseUIButton){
        do{
            if try self.viewModel.validateEmailPassword(){
                self.viewModel.login { (isSuccess, errorMsg) in
                    if isSuccess {

                        AppRouter.goToSpecificController(vc: DashboardBuilder.build())
                    }
                    else{
                        Alert.showAlertWithAutoHide(title: ErrorDescription.errorTitle.rawValue, message: errorMsg, autoHidetimer: 2, type: .error)
                    }
                }
            }
        }
        catch EmailErrors.invalidEmail{
            Alert.showAlertWithAutoHide(title: ErrorDescription.errorTitle.rawValue, message: ErrorDescription.invalidEmail.rawValue, autoHidetimer: 2, type: .error)
        }
        catch PasswordErrors.invalidPassword{
            Alert.showAlertWithAutoHide(title: ErrorDescription.errorTitle.rawValue, message: ErrorDescription.invalidPasswordd.rawValue, autoHidetimer: 2, type: .error)
        }
        catch{
        }
    }
}

extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
