//
//  ConfirmPasswordViewController.swift
//  Pulse
//
//  Created by Hamza Khan on 08/11/2020.
//

import UIKit
import TextFieldEffects
class ConfirmPasswordViewController: BaseViewController {
    var viewModel : ConfirmPasswordViewModel!
    let font = UIFont.init(name: "Montserrat-Regular" , size: 18.33)
    @IBOutlet weak var txtSetNewPass: HoshiTextField!{
        didSet{
            txtSetNewPass.font = font
        }
    }
    @IBOutlet weak var txtConfirrmPass: HoshiTextField!{
        didSet{
            txtConfirrmPass.font = font
        }
    }
    
    @IBOutlet weak var btnGoToLogin: UIButton!
    @IBOutlet weak var viewSuccess: UIView!{
        didSet{
            viewSuccess.isHidden = true
        }
    }
    var isNewPasswordSet = false{
        didSet{
            viewSuccess.isHidden = !isNewPasswordSet
            self._headerView.isHidden = self.isNewPasswordSet

        }
    }
    @IBOutlet weak var btnGoBack: UIButton!
    @IBOutlet weak var btnConfirmPass: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupBinding()
    }
    
}
extension ConfirmPasswordViewController{
    private func setupBinding(){
        txtSetNewPass.bind(with: self.viewModel.password)
        txtConfirrmPass.bind(with: self.viewModel.confirmPassword)

    }
    @objc private func didTapOnNext(){
        self.viewModel.changePassword { (success, serverMsg) in
            if success{
                self.isNewPasswordSet = !self.isNewPasswordSet
            }
            else{
                Alert.showAlertWithAutoHide(title: "Error", message: serverMsg, autoHidetimer: 4.0, type: .error)
            }
        }
    }
    @objc private func didTapOnBack(){
        AppRouter.goToLogin()
    }
    private func setupViews(){
        navBarType = self.viewModel.getNavigationBar()
        btnConfirmPass.addTarget(self, action: #selector(self.didTapOnNext), for: .touchUpInside)
        btnGoBack.addTarget(self, action: #selector(self.didTapOnBack), for: .touchUpInside)
        btnGoToLogin.addTarget(self, action: #selector(self.didTapOnBack), for: .touchUpInside)
    }
}
extension ConfirmPasswordViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
