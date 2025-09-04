//
//  ForgetPassVC.swift
//  iOS_Flight-Booking
//
//  Created by macOS on 04/02/23.
//

import UIKit

class ForgetPassVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var Submit: UIButton!
    @IBOutlet weak var txtNumber: UITextField!
    
    @IBOutlet weak var txtTick: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Submit.clipsToBounds = true
        Submit.layer.cornerRadius = 10
        
        txtNumber.delegate = self
        
        self.txtNumber.addTarget(self, action: #selector(searchWorkersAsPerText(_ :)), for: .editingChanged)

    }
    
    @objc func searchWorkersAsPerText(_ textfield:UITextField)
    {
        if txtNumber.text == ""
        {
            txtTick.isHidden = true
        }
        else
        {
            txtTick.isHidden = false
        }
    }
    
    @IBAction func clickedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickedSubmit(_ sender: Any) {
        
        self.view.hideToast()
        let windows = UIApplication.shared.windows
        windows.last?.hideToast()
        
        if txtNumber.text == ""
        {
            self.view.makeToast("Enter email address")
        }
        else
        {
            callForgotPassAPI()
        }
        
    }
    
    func callForgotPassAPI()
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["email":self.txtNumber.text ?? ""]
        
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
                        self.view.makeToast(msg)
                        
                        let windows = UIApplication.shared.windows
                        windows.last?.makeToast(msg)
                        
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OtpVC") as! OtpVC
                        vc.strPhone = self.txtNumber.text ?? ""
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    else
                    {
                        self.view.makeToast(msg)
                    }
                }
            }
        }
    }
    
}
 
