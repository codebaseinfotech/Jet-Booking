//
//  loginVC.swift
//  iOS_Flight-Booking
//
//  Created by macOS on 03/02/23.
//

import UIKit
import Toast_Swift

class loginVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var sign: UIButton!
    @IBOutlet weak var ViewLogin: UIView!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    
    @IBOutlet weak var imgTickEmail: UIImageView!
    @IBOutlet weak var imgTickPass: UIImageView!
    
    @IBOutlet weak var imgRM: UIImageView!
    @IBOutlet weak var viewRM: UIView!
    
    var isHidePassword = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
//        txtUserName.text = "admin@gmail.com"
//        txtPass.text = "Admin@123"
        
        txtPass.isSecureTextEntry = true
        isHidePassword = true
        imgTickPass.image = UIImage(named: "S_Pass")
        
        imgRM.isHidden = true
        
        viewRM.borderWidth = 1
        viewRM.borderColor = .black
        viewRM.backgroundColor = .clear
        
        if txtUserName.text == ""
        {
            imgTickEmail.isHidden = true
        }
        else
        {
            imgTickEmail.isHidden = false
        }
        
        ViewLogin.clipsToBounds = true
        ViewLogin.layer.cornerRadius = 15
        
        sign.clipsToBounds = true
        sign.layer.cornerRadius = 10
        
        txtUserName.delegate = self
        txtPass.delegate = self
        
        self.txtUserName.addTarget(self, action: #selector(searchWorkersAsPerText(_ :)), for: .editingChanged)
        self.txtPass.addTarget(self, action: #selector(searchWorkersAsPerText(_ :)), for: .editingChanged)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        let isRemeder = UserDefaults.standard.value(forKey: "isRemeder") as? Bool

        if isRemeder == true
        {
            
            let username = UserDefaults.standard.value(forKey: "username") as? String
            let password = UserDefaults.standard.value(forKey: "password") as? String

            self.txtUserName.text = username ?? ""
            self.txtPass.text = password ?? ""
            
            imgRM.isHidden = false
            viewRM.borderWidth = 0
            viewRM.backgroundColor = .black
        }
    }
    
    @objc func searchWorkersAsPerText(_ textfield:UITextField)
    {
        if txtUserName.text == ""
        {
            imgTickEmail.isHidden = true
        }
        else
        {
            imgTickEmail.isHidden = false
        }
        
        if txtPass.text == ""
        {
            imgTickPass.isHidden = true
        }
        else
        {
            imgTickPass.isHidden = false
        }
    }
    
    @IBAction func clickedForhetPass(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgetPassVC") as! ForgetPassVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickedSingIn(_ sender: Any) {
        if isValidLogin()
        {
            callLogInAPI()
        }
    }
    
    @IBAction func clickedRegister(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickedRemedrMe(_ sender: Any) {
        if imgRM.isHidden == true
        {
            UserDefaults.standard.set(true, forKey: "isRemeder")
            UserDefaults.standard.synchronize()

            imgRM.isHidden = false
            viewRM.borderWidth = 0
            viewRM.backgroundColor = .black
        }
        else
        {
            
            UserDefaults.standard.set(false, forKey: "isRemeder")
            UserDefaults.standard.synchronize()
            
            imgRM.isHidden = true
            viewRM.borderWidth = 1
            viewRM.borderColor = .black
            viewRM.backgroundColor = .clear
        }
            
    }
    
    @IBAction func clickedShowPassword(_ sender: Any) {
        if isHidePassword == true
        {
            txtPass.isSecureTextEntry = false
            isHidePassword = false
            imgTickPass.image = UIImage(named: "H_Pass")
        }
        else
        {
            txtPass.isSecureTextEntry = true
            isHidePassword = true
            imgTickPass.image = UIImage(named: "S_Pass")
        }
    }
    
    func callLogInAPI()
    {
        self.view.hideToast()
        let windows = UIApplication.shared.windows
        windows.last?.hideToast()
        
        APIClient.sharedInstance.showIndicator()
        
        let param = ["username": self.txtUserName.text ?? "", "password": self.txtPass.text ?? ""]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithOutHeaderPost(LOGIN, parameters: param) { response, error, statusCode in
            
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
                        let dicData = response?.value(forKey: "data") as? NSDictionary
                        
                        self.view.makeToast(msg ?? "")
                        let windows = UIApplication.shared.windows
                        windows.last?.makeToast(msg ?? "")
                        
                        UserDefaults.standard.set(self.txtUserName.text ?? "", forKey: "username")
                        UserDefaults.standard.set(self.txtPass.text ?? "", forKey: "password")

                        UserDefaults.standard.setValue(true, forKey: "userLogin")
                        UserDefaults.standard.synchronize()
                        
                        appDelegate.saveCurrentUserData(dic: JBLoginUserData(fromDictionary: dicData!))
                        appDelegate.dicCurrentUserData = JBLoginUserData(fromDictionary: dicData!)
                        
                        appDelegate.setUpHome()
                        
                    }
                    else
                    {
                        self.view.makeToast(msg)
                        let windows = UIApplication.shared.windows
                        windows.last?.makeToast(msg ?? "")
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
    
    func isValidLogin() -> Bool
    {
        self.view.hideToast()
        let windows = UIApplication.shared.windows
        windows.last?.hideToast()

        
        if txtUserName.text == ""
        {
            self.view.makeToast("Enter username")
            
            let windows = UIApplication.shared.windows
            windows.last?.makeToast("Enter username")
            return false
        }
        else if txtPass.text == ""
        {
            self.view.makeToast("Enter password")
            let windows = UIApplication.shared.windows
            windows.last?.makeToast("Enter password")
            return false
        }
        
        return true
    }
    
    
}
