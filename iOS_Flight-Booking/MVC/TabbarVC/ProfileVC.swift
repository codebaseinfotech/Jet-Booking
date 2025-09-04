//
//  ProfileVC.swift
//  iOS_Flight-Booking
//
//  Created by Code on 15/02/23.
//

import UIKit
import Kingfisher

class ProfileVC: UIViewController {

    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var lblFName: UILabel!
    @IBOutlet weak var lblLName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblMobileNumber: UILabel!
    @IBOutlet weak var lblPassport: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var viewProfile: UIView!
    
    var dicUserDetail = JBUserProfileData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bottomView.clipsToBounds = true
        bottomView.layer.cornerRadius = 20
        bottomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top Corner
        
        bottomView.layer.applySketchShadow(color: .black, alpha: 0.11, x: 0, y: 0, blur: 15, spread: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        callUserProfileAPI()

    }
    
    @objc func onNotification(notification:Notification)
    {
        let img = notification.userInfo!["imgProfile"] as? String
        
        self.imgProfile.kf.setImage(
            with: URL(string: img ?? ""),
            placeholder: nil,
            options: [
                .loadDiskFileSynchronously,
                .cacheOriginalImage,
                .transition(.fade(0.25))
            ],
            progressBlock: { receivedSize, totalSize in
                // Progress updated
            },
            completionHandler: { result in
                // Done
            }
        )
        
        }
    
    @IBAction func clickedEdit(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
        vc.strFName = dicUserDetail.firstName ?? ""
        vc.strLName = dicUserDetail.lastName ?? ""
        vc.strEmail = dicUserDetail.email ?? ""
        vc.strMobile = dicUserDetail.mobile ?? ""
        vc.strImg = dicUserDetail.imageUrl ?? ""
        vc.strPassport = dicUserDetail.passport ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickedHome(_ sender: Any) {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func clickedMyBooking(_ sender: Any) {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "MyIntenariesVC") as! MyIntenariesVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func clickedEmrtyLegs(_ sender: Any) {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "EmptyLegsVC") as! EmptyLegsVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    
    @IBAction func clickedLogout(_ sender: Any) {
        AppUtilites.showAlert(title: "Are you sure want to Logout?", message: "", actionButtonTitle: "Yes", cancelButtonTitle: "No") {
           
            UserDefaults.standard.setValue(false, forKey: "userLogin")
            UserDefaults.standard.synchronize()
            
            appDelegate.setUpLogin()
        }
    }
    
    func callUserProfileAPI()
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["userid":appDelegate.dicCurrentUserData.id ?? ""]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithOutHeaderPost(USER_PROFILE, parameters: param) { response, error, statusCode in
            
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
                        let objData = response?.value(forKey: "data") as! NSDictionary
                        
                        let dicData = JBUserProfileData(fromDictionary: objData)
                        self.dicUserDetail = dicData
                        
                        self.lblFName.text = self.dicUserDetail.firstName ?? ""
                        self.lblLName.text = self.dicUserDetail.lastName ?? ""
                        self.lblEmail.text = self.dicUserDetail.email ?? ""
                        self.lblMobileNumber.text = self.dicUserDetail.mobile ?? ""
                        self.lblPassport.text = self.dicUserDetail.passport ?? ""
                        
                        self.imgProfile.kf.setImage(
                            with: URL(string: self.dicUserDetail.imageUrl ?? ""),
                            placeholder: nil,
                            options: [
                                .loadDiskFileSynchronously,
                                .cacheOriginalImage,
                                .transition(.fade(0.25))
                            ],
                            progressBlock: { receivedSize, totalSize in
                                // Progress updated
                            },
                            completionHandler: { result in
                                // Done
                            }
                        )
                    }
                    else
                    {
                        APIClient.sharedInstance.hideIndicator()
                    }
                }
            }
        }
    }
    
}
