//
//  ChangePasswordVC.swift
//  Jet Booking
//
//  Created by Code on 21/02/23.
//

import UIKit

class ChangePasswordVC: UIViewController {

    @IBOutlet weak var txtNewPass: UITextField!
    @IBOutlet weak var txtReNewPass: UITextField!
    
    var strUserID = ""
    var strEmail = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func clickedSubmit(_ sender: Any) {
        if isValidPass()
        {
            callChangePassAPI()
        }
    }
    
    func callChangePassAPI()
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["userid":self.strUserID,"password":self.txtNewPass.text ?? "","email":self.strEmail]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithOutHeaderPost(CHANGE_PASS, parameters: param) { response, error, statusCode in
            
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
                        let windows = UIApplication.shared.windows
                        windows.last?.makeToast(msg)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            appDelegate.setUpLogin()
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
    
    func isValidPass() -> Bool
    {
        self.view.hideToast()
        let windows = UIApplication.shared.windows
        windows.last?.hideToast()
        
        if txtNewPass.text == ""
        {
            self.view.makeToast("Enter new password")
            let windows = UIApplication.shared.windows
            windows.last?.makeToast("Enter new password")
            return false
        }
        else if txtReNewPass.text == ""
        {
            self.view.makeToast("Enter Renew password")
            let windows = UIApplication.shared.windows
            windows.last?.makeToast("Enter Renew password")
            
            return false
        }
        else if txtNewPass.text != txtReNewPass.text
        {
            self.view.makeToast("Password dose not match")
            let windows = UIApplication.shared.windows
            windows.last?.makeToast("Password dose not match")
            return false
        }
        return true
    }
    
}
