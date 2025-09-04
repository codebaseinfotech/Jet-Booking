//
//  OtpVC.swift
//  iOS_Flight-Booking
//
//  Created by macOS on 04/02/23.
//

import UIKit
import OTPFieldView

class OtpVC: UIViewController {
    
    @IBOutlet weak var lblPHone: UILabel!
    @IBOutlet weak var OtpView: OTPFieldView!
    @IBOutlet weak var Verify: UIButton!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var btnRens: UIButton!
    
    var enteredOtp = ""
    
    var strPhone = ""
    
    var strValidOTP = ""
    
    var myTimer: Timer?
    var counter = 120
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblPHone.text = "A 6-digit code has been sent on the your Email ID \(strPhone)"

        Verify.clipsToBounds = true
        Verify.layer.cornerRadius = 10
         
        setupOtpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setStartTimer()
    }
    
    func setStartTimer()
    {
        self.counter = 120

        self.lblTime.text = "\(counter) secs"
        
        self.lblTime.isHidden = false
        self.btnRens.isUserInteractionEnabled = false
        self.btnRens.setTitle("Resend in", for: .normal)

        startTimer()
    }
    
    func startTimer() {
        
        self.lblTime.text = "\(counter) secs"
        
        myTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
    }

    func stopTimer() {
        
        counter = 120
        self.lblTime.isHidden = true
        self.btnRens.isUserInteractionEnabled = true
        self.btnRens.setTitle("Resend", for: .normal)
        
        myTimer?.invalidate()
    }
    
    @objc func timerFired() {
        
        if counter != 1 {
           // print("\(counter) seconds to the end of the world")
            counter -= 1
            
            self.lblTime.text = "\(counter) secs"
        }
        else
        {
            stopTimer()
        }
        
        // Code to execute when the timer fires
    }
    
    func setupOtpView(){
        self.OtpView.fieldsCount = 6
        self.OtpView.filledBackgroundColor = .white
        self.OtpView.defaultBackgroundColor = .white
        self.OtpView.cursorColor = .black
        self.OtpView.filledBorderColor = .black
        self.OtpView.defaultBorderColor = UIColor(red: 166/255, green: 164/255, blue: 164/255, alpha: 1)
        self.OtpView.displayType = .square
        self.OtpView.fieldBorderWidth = 1
        self.OtpView.fieldSize = 45
        self.OtpView.separatorSpace = 8
        self.OtpView.shouldAllowIntermediateEditing = false
        self.OtpView.delegate = self
        self.OtpView.initializeUI()
    }
    
    @IBAction func clickedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func clickedResend(_ sender: Any) {
       
        callForgotPassAPI()
    }
    
    @IBAction func clickedVerify(_ sender: Any) {
        
        self.view.hideToast()
        let windows = UIApplication.shared.windows
        windows.last?.hideToast()
        
        if enteredOtp != ""
        {
            callOTPAPI()
        }
        else
        {
            self.view.makeToast("Please enter OTP")
            let windows = UIApplication.shared.windows
            windows.last?.makeToast("Please enter OTP")

        }
    }
    
    func callForgotPassAPI()
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["email":self.strPhone]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithOutHeaderPost(FORGOT_PASS, parameters: param) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            if error == nil
            {
                APIClient.sharedInstance.hideIndicator()
                
                if statusCode == 200
                {
                    let status = response?.value(forKey: "status") as? Int
                    let msg = response?.value(forKey: "msg") as? String
                    
                    if status == 1
                    {
                        self.setStartTimer()
                        
                        self.view.makeToast(msg)
                        let windows = UIApplication.shared.windows
                        windows.last?.makeToast(msg)
                        
                    }
                    else
                    {
                        self.view.makeToast(msg)
                    }
                }
            }
        }
    }
    
    func callOTPAPI()
    {
        self.view.hideToast()
        let windows = UIApplication.shared.windows
        windows.last?.hideToast()
        
        APIClient.sharedInstance.showIndicator()
        
        let param = ["email":self.strPhone,"userid":"17","otp":self.enteredOtp]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithOutHeaderPost(VERIFY_OTP, parameters: param) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            if error == nil
            {
                APIClient.sharedInstance.hideIndicator()
                
                if statusCode == 200
                {
                    let status = response?.value(forKey: "status") as? Int
                    let msg = response?.value(forKey: "msg") as? String
                    
                    if status == 1
                    {
                        let dicData = response?.value(forKey: "data") as! NSDictionary
                        
                        let userId = dicData.value(forKey: "userid") as? String
                        
                        self.view.makeToast(msg)
                        let windows = UIApplication.shared.windows
                        windows.last?.makeToast(msg)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
                            vc.strUserID = userId ?? ""
                            vc.strEmail = self.strPhone
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                                                
                    }
                    else
                    {
                        self.view.makeToast(msg)
                        let windows = UIApplication.shared.windows
                        windows.last?.makeToast(msg)
                    }
                }
            }
        }
    }
    
}

extension OtpVC: OTPFieldViewDelegate {
    func hasEnteredAllOTP(hasEnteredAll hasEntered: Bool) -> Bool {
        print("Has entered all OTP? \(hasEntered)")
        return false
    }

    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }

    func enteredOTP(otp otpString: String) {
        print("OTPString: \(otpString)")

        self.enteredOtp = otpString

        if strValidOTP == enteredOtp
        {
            callOTPAPI()
        }
    }
}
