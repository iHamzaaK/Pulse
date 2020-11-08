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

    @IBOutlet weak var txtSetNewPass: HoshiTextField!
    @IBOutlet weak var txtConfirrmPass: HoshiTextField!
    
    @IBOutlet weak var btnGoToLogin: UIButton!
    @IBOutlet weak var viewSuccess: UIView!{
        didSet{
            viewSuccess.isHidden = true
        }
    }
    var isNewPasswordSet = false{
        didSet{
            viewSuccess.isHidden = !isNewPasswordSet
        }
    }
    @IBOutlet weak var btnGoBack: UIButton!
    @IBOutlet weak var btnConfirmPass: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
}
extension ConfirmPasswordViewController{
    @objc private func didTapOnNext(){
        isNewPasswordSet = !isNewPasswordSet
        _headerView.isHidden = isNewPasswordSet
    }
    @objc private func didTapOnBack(){
        AppRouter.pop()
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
