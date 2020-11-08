//
//  LoginViewController.swift
//  Pulse
//
//  Created by Hamza Khan on 07/11/2020.
//

import UIKit
import TextFieldEffects
class LoginViewController: UIViewController {

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
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
extension LoginViewController{
    private func setupViews(){
        btnForgetPassword.addTarget(self, action: #selector(self.didTapOnForget), for: .touchUpInside)
        btnNext.addTarget(self, action: #selector(self.didTapOnNext), for: .touchUpInside)

    }
    @objc private func didTapOnForget(){
        let vc = ForgetPasswordBuilder.build()
        AppRouter.goToSpecificController(vc: vc)
    }
    @objc private func didTapOnNext(){
        let vc = ConfirmPasswordBuilder.build()
        AppRouter.goToSpecificController(vc: vc)

    }
}

extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
