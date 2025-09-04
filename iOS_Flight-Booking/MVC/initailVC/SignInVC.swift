//
//  SignInVC.swift
//  iOS_Flight-Booking
//
//  Created by macOS on 04/02/23.
//

import UIKit

class SignInVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var viewHieght: NSLayoutConstraint!
    @IBOutlet weak var viewTopConts: NSLayoutConstraint!
    
    
    @IBOutlet weak var SignUp: UIButton!
    @IBOutlet weak var ViewMain: UIView!
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    
    @IBOutlet weak var txtNumber: UITextField!
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPass: UITextField!
    
    @IBOutlet weak var txtRePass: UITextField!
    
    @IBOutlet weak var viewFName: UIView!
    @IBOutlet weak var viewLName: UIView!
    @IBOutlet weak var viewNo: UIView!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var viewPass: UIView!
    @IBOutlet weak var viewREPass: UIView!
    
    
    @IBOutlet weak var imgTickName: UIImageView!
    @IBOutlet weak var imgTickLastName: UIImageView!
    @IBOutlet weak var imgTickNumber: UIImageView!
    @IBOutlet weak var imgTickEmail: UIImageView!
    @IBOutlet weak var imgTickPass: UIImageView!
    @IBOutlet weak var imgTickRePass: UIImageView!
    
    var isHidePass = true
    
    var isHideRePass = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtPass.isSecureTextEntry = true
        isHidePass = true
        imgTickPass.image = UIImage(named: "S_Pass")
        
        txtRePass.isSecureTextEntry = true
        isHideRePass = true
        imgTickRePass.image = UIImage(named: "S_Pass")
        
        if UIDevice.current.hasNotch == true
        {
            viewHieght.constant = 550
            viewTopConts.constant = 120
        }
        else
        {
            viewHieght.constant = 480
            viewTopConts.constant = 50
        }
        
        ViewMain.clipsToBounds = true
        ViewMain.layer.cornerRadius = 30
        
        SignUp.clipsToBounds = true
        SignUp.layer.cornerRadius = 10
        
        self.txtName.delegate = self
        self.txtLastName.delegate = self
        self.txtNumber.delegate = self
        self.txtEmail.delegate = self
        self.txtPass.delegate = self
        self.txtRePass.delegate = self
        
        self.txtName.addTarget(self, action: #selector(searchWorkersAsPerText(_ :)), for: .editingChanged)
        self.txtLastName.addTarget(self, action: #selector(searchWorkersAsPerText(_ :)), for: .editingChanged)
        self.txtNumber.addTarget(self, action: #selector(searchWorkersAsPerText(_ :)), for: .editingChanged)
        self.txtEmail.addTarget(self, action: #selector(searchWorkersAsPerText(_ :)), for: .editingChanged)
        self.txtPass.addTarget(self, action: #selector(searchWorkersAsPerText(_ :)), for: .editingChanged)
        self.txtRePass.addTarget(self, action: #selector(searchWorkersAsPerText(_ :)), for: .editingChanged)
        
        
        if txtName.text == ""
        {
            self.imgTickName.isHidden = true
        }
        else
        {
            self.imgTickName.isHidden = false
        }
        
        if txtLastName.text == ""
        {
            self.imgTickLastName.isHidden = true
        }
        else
        {
            self.imgTickLastName.isHidden = false
        }
        
        if txtNumber.text == ""
        {
            self.imgTickNumber.isHidden = true
        }
        else
        {
            self.imgTickNumber.isHidden = false
        }
        
        if !AppUtilites.isValidEmail(testStr: txtEmail.text!)
        {
            self.imgTickEmail.isHidden = true
        }
        else
        {
            self.imgTickEmail.isHidden = false
        }
        
    }
    
    
    @objc func searchWorkersAsPerText(_ textfield:UITextField)
    {
        if txtName.text == ""
        {
            self.imgTickName.isHidden = true
        }
        else
        {
            self.imgTickName.isHidden = false
        }
        
        
        if txtLastName.text == ""
        {
            self.imgTickLastName.isHidden = true
        }
        else
        {
            self.imgTickLastName.isHidden = false
        }
        
        if txtNumber.text == ""
        {
            self.imgTickNumber.isHidden = true
        }
        else
        {
            self.imgTickNumber.isHidden = false
        }
        
        if !AppUtilites.isValidEmail(testStr: txtEmail.text!)
        {
            self.imgTickEmail.isHidden = true
        }
        else
        {
            self.imgTickEmail.isHidden = false
        }
        
    }
    
    @IBAction func clickedSignin(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickedLogin(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickedSignUp(_ sender: Any) {
        if isVlidLogin()
        {
            callSignUpAPI()
        }
    }
    
    @IBAction func clickedShowPAssword(_ sender: Any) {
        if isHidePass == true
        {
            txtPass.isSecureTextEntry = false
            isHidePass = false
            imgTickPass.image = UIImage(named: "H_Pass")
        }
        else
        {
            txtPass.isSecureTextEntry = true
            isHidePass = true
            imgTickPass.image = UIImage(named: "S_Pass")
            
        }
    }
    @IBAction func clickedShowREPass(_ sender: Any) {
        if isHideRePass == true
        {
            txtRePass.isSecureTextEntry = false
            isHideRePass = false
            imgTickRePass.image = UIImage(named: "H_Pass")
        }
        else
        {
            txtRePass.isSecureTextEntry = true
            isHideRePass = true
            imgTickRePass.image = UIImage(named: "S_Pass")
        }
    }
    
    
    func callSignUpAPI()
    {
        self.view.hideToast()
        let windows = UIApplication.shared.windows
        windows.last?.hideToast()
        
        APIClient.sharedInstance.showIndicator()
        
        let param = ["first_name":self.txtName.text ?? "","last_name":self.txtLastName.text ?? "","email":self.txtEmail.text ?? "","mobile":self.txtNumber.text ?? "","password":self.txtPass.text ?? ""]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithOutHeaderPost(SIGN_UP, parameters: param) { response, error, statusCode in
            
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
                        self.view.makeToast(msg)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                    else
                    {
                        self.view.makeToast(msg)
                    }
                }
                else
                {
                    APIClient.sharedInstance.hideIndicator()
                }
            }
            else
            {
                APIClient.sharedInstance.hideIndicator()
            }
        }
    }
    
    func isVlidLogin() -> Bool
    {
        self.view.hideToast()
        let windows = UIApplication.shared.windows
        windows.last?.hideToast()
        
        if txtName.text == ""
        {
            self.view.makeToast("Enter first name")
            return false
        }
        else if txtLastName.text == ""
        {
            self.view.makeToast("Enter last name")
            return false
        }
        else if txtNumber.text == ""
        {
            self.view.makeToast("Enter mobile number")
            return false
        }
        else if (txtNumber.text?.count ?? 0) < 8
        {
            self.view.makeToast("Enter valid mobile number")
            return false
        }
        else if txtEmail.text == ""
        {
            self.view.makeToast("Enter email")
            return false
        }
        else if !AppUtilites.isValidEmail(testStr: txtEmail.text!)
        {
            self.view.makeToast("Enter email")
            return false
        }
        else if txtPass.text == ""
        {
            self.view.makeToast("Enter password")
            return false
        }
        else if txtRePass.text == ""
        {
            self.view.makeToast("Enter confirm password")
            return false
        }
        else if txtPass.text != txtRePass.text
        {
            self.view.makeToast("Password does not match")
            return false
        }
        return true
    }

}
