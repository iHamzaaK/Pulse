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
    let font = UIFont.init(name: "Montserrat-Regular" , size: DesignUtility.convertToRatio(18, sizedForIPad: DesignUtility.isIPad, sizedForNavi: false))

    @IBOutlet weak var txtPassword: HoshiTextField!{
        didSet{
            txtPassword.delegate = self
            txtPassword.addTarget(self, action: #selector(self.didChangeText), for: .editingChanged)
            txtPassword.font = font

        }
    }
    @IBOutlet weak var txtEmail: HoshiTextField!{
        didSet{
            txtEmail.delegate = self
            txtEmail.addTarget(self, action: #selector(self.didChangeText), for: .editingChanged)
            txtEmail.font = font

        }
    }
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
        let font = UIFont(name: "Montserrat-Regular", size: DesignUtility.convertToRatio(18, sizedForIPad:  DesignUtility.isIPad, sizedForNavi: false))
        self.txtEmail.font = font
        self.txtPassword.font = font

    }
    @objc private func didTapOnForget(){
        let vc = ForgetPasswordBuilder.build()
        AppRouter.goToSpecificController(vc: vc)
    }
    
    private func setupBinding(){
        txtEmail.bind(with: self.viewModel.email)
        txtPassword.bind(with: self.viewModel.password)
        self.viewModel.email.value = "hamzakhancs15@gmail.com"
        self.viewModel.password.value = "Lollol123$"
    }
    @objc private func didTapOnLogin(sender : BaseUIButton){
        do{
            if try self.viewModel.validateEmailPassword(){
                self.viewModel.login { (isSuccess, errorMsg) in
                    if isSuccess {

                        AppRouter.createInitialRoute(vc: DashboardBuilder.build())
                        
                        NotificationCenter.default.post(name: Notification.Name("updateUserImage"), object: nil)

                    }
                    else{
                        self.lblEmailError.isHidden = false
                        self.lblPasswordError.isHidden = false
                        self.lblEmailError.text = ErrorDescription.invalidEmail.rawValue
                        self.lblPasswordError.text = ErrorDescription.invalidPasswordd.rawValue

//                        Alert.showAlertWithAutoHide(title: ErrorDescription.errorTitle.rawValue, message: errorMsg, autoHidetimer: 2, type: .error)
                    }
                }
            }
        }
        catch EmailErrors.invalidEmail{
            lblEmailError.text = ErrorDescription.invalidEmail.rawValue
            lblEmailError.isHidden = false
//            Alert.showAlertWithAutoHide(title: ErrorDescription.errorTitle.rawValue, message: ErrorDescription.invalidEmail.rawValue, autoHidetimer: 2, type: .error)
        }
        catch PasswordErrors.invalidPassword{
            lblPasswordError.text = ErrorDescription.invalidPasswordd.rawValue
            lblPasswordError.isHidden = false
//            Alert.showAlertWithAutoHide(title: ErrorDescription.errorTitle.rawValue, message: ErrorDescription.invalidPasswordd.rawValue, autoHidetimer: 2, type: .error)
        }
        catch{
        }
    }
}

extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtEmail{
            txtPassword.becomeFirstResponder()
        }
        else {
            self.view.endEditing(true)
        }
        return true
    }
    
   
    @objc func didChangeText(){
        self.lblPasswordError.isHidden = true
        self.lblEmailError.isHidden = true
        self.lblPasswordError.text =  ""
        self.lblEmailError.text = ""
    }
}
