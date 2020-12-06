//
//  OTPViewController.swift
//  Pulse
//
//  Created by Hamza Khan on 01/12/2020.
//

import UIKit
import OTPFieldView
class OTPViewController: BaseViewController {

    @IBOutlet weak var lblTimer: BaseUILabel!
    @IBOutlet weak var btnResendOTP: UIButton!
    @IBOutlet weak var btnSendOTP: BaseUIButton!
    @IBOutlet var otpTextFieldView: OTPFieldView!
    var viewModel : OTPViewModel!
    var otpTimer: Timer?
    var timeExpired : Bool = false
    var otpString : String = ""
    var seconds : Double = 3600
    var secondsBeforeExpiry: Double  = 0.0{
        didSet{
            self.lblTimer.text = secondsBeforeExpiry.asString(style: .positional)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        secondsBeforeExpiry = seconds
        setupOTP()
        navBarType = self.viewModel.getNavigationBar()
        startTimer()
        // Do any additional setup after loading the view.
    }
    private func setupOTP(){
        self.otpTextFieldView.fieldsCount = 5
        self.otpTextFieldView.fieldBorderWidth = 1
        self.otpTextFieldView.defaultBorderColor = UIColor.lightGray
        self.otpTextFieldView.filledBorderColor = UIColor.black
        self.otpTextFieldView.cursorColor = UIColor.lightGray
        self.otpTextFieldView.displayType = .underlinedBottom
        self.otpTextFieldView.fieldSize = DesignUtility.getFontSize(fSize: 34)
        self.otpTextFieldView.separatorSpace = 24//DesignUtility.getFontSize(fSize: 8)
        self.otpTextFieldView.shouldAllowIntermediateEditing = false
        self.otpTextFieldView.delegate = self
        self.otpTextFieldView.initializeUI()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension OTPViewController {
    private func startTimer() {
        timeExpired = false
        otpTimer?.invalidate() //cancels it if already running
        secondsBeforeExpiry = seconds
        otpTimer = Timer.scheduledTimer(timeInterval: seconds, target: self, selector: #selector(timerDidFire(_:)), userInfo: nil, repeats: false)
        otpTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer(_:)), userInfo: nil, repeats: true)

    }
    
    @objc func updateTimer(_ timer : Timer){
        print(self.secondsBeforeExpiry)
        if secondsBeforeExpiry != 0 {
            secondsBeforeExpiry -= 1  // decrease counter timer
        }

    }
    @objc func timerDidFire(_ timer: Timer) {
        timeExpired = true
        otpTimer?.invalidate()
        lblTimer.text = "OTP EXPIRED. Click on resend button."
       // timer has completed.  Do whatever you want...
    }
    @IBAction func didTapOnSend(_ sender: Any){
        if !timeExpired{
            // hit api
            self.viewModel.otpProcess { (success, serverMsg) in
                if success{
                    AppRouter.goToSpecificController(vc: ConfirmPasswordBuilder.build(email: self.viewModel.userEmail, otp: self.viewModel.otp))
                    self.otpTimer?.invalidate()
                    self.otpTimer = nil
                }
            }
        }
        else{
            Alert.showAlertWithAutoHide(title: "OTP Expired", message: "Click on resend to get new OTP", autoHidetimer: 2.0, type: .error)
        }
    }
    @IBAction func resendOtpButn(_ sender: Any) {
        startTimer()
        self.viewModel.resetPassword { (success, serverMsg) in
           if success{
              Alert.showAlertWithAutoHide(title: "", message: "An OTP has been sent. Kindly check your email.", autoHidetimer: 4, type: .success)
           }
           else{
              Alert.showAlertWithAutoHide(title: ErrorDescription.errorTitle.rawValue, message: serverMsg, autoHidetimer: 4, type: .error)

           }
        }
    }
}
extension OTPViewController : OTPFieldViewDelegate {
    func hasEnteredAllOTP(hasEnteredAll hasEntered: Bool) -> Bool {
        print("Has entered all OTP? \(hasEntered)")
        return false
    }
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otp otpString: String) {
        print("OTPString: \(otpString)")
        self.viewModel.otp = otpString
    }
}
