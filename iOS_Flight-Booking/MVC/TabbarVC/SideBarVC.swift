//
//  SideBarVC.swift
//  iOS_Flight-Booking
//
//  Created by Code on 14/02/23.
//

import UIKit
import LGSideMenuController

class SideBarVC: UIViewController {

    @IBOutlet weak var tblViewSideMenu: UITableView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmil: UILabel!
    
    var arrImgIcon = ["Dashboard","Search","Flight Quotes","Guide","Contact"]
    
    var arrItem = ["Dashboard","Search for a Private Jet","Your Flight Quotes","How it works","Contact"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblViewSideMenu.delegate = self
        tblViewSideMenu.dataSource = self
        
        lblName.text = "\(appDelegate.dicCurrentUserData.firstName ?? "") \(appDelegate.dicCurrentUserData.lastName ?? "")"
        lblEmil.text = appDelegate.dicCurrentUserData.email ?? ""

    }

    @IBAction func clickedCancelSideBar(_ sender: Any) {
        self.sideMenuController?.hideLeftView(animated: true, completion: nil)
    }
    @IBAction func clickedLogout(_ sender: Any) {
        AppUtilites.showAlert(title: "Are you sure want to Logout?", message: "", actionButtonTitle: "Yes", cancelButtonTitle: "No") {
            
            UserDefaults.standard.setValue(false, forKey: "userLogin")
            UserDefaults.standard.synchronize()
            
            appDelegate.setUpLogin()
        }
    }
    
    @IBAction func clickedDeleteAccount(_ sender: Any) {
        AppUtilites.showAlert(title: "Are you sure want to Delete Account?", message: "", actionButtonTitle: "Yes", cancelButtonTitle: "No") {
            
            UserDefaults.standard.setValue(false, forKey: "userLogin")
            UserDefaults.standard.synchronize()
            
            appDelegate.setUpLogin()
        }
    }
    
    
}
extension SideBarVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblViewSideMenu.dequeueReusableCell(withIdentifier: "SideMenuTblViewCell") as! SideMenuTblViewCell
        cell.lblTitle.text = arrItem[indexPath.row]
        cell.imgicon.image = UIImage(named: arrImgIcon[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0
        {// home
            let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
            let controller = appDelegate.window?.rootViewController as! LGSideMenuController
            let navigation = controller.rootViewController as! UINavigationController
            let HomeVC = mainStoryboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
            navigation.viewControllers = [HomeVC]
            self.sideMenuController?.hideLeftView(animated: true, completion: nil)
        }
        else if indexPath.row == 1
        { //Privet jat
            let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
            let controller = appDelegate.window?.rootViewController as! LGSideMenuController
            let navigation = controller.rootViewController as! UINavigationController
            let FlightSearchVC = mainStoryboard.instantiateViewController(withIdentifier: "FlightSearchVC") as! FlightSearchVC
            FlightSearchVC.isFromSide = true
            navigation.viewControllers = [FlightSearchVC]
            self.sideMenuController?.hideLeftView(animated: true, completion: nil)
        }
        else if indexPath.row == 2
        { // Privet jat
            let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
            let controller = appDelegate.window?.rootViewController as! LGSideMenuController
            let navigation = controller.rootViewController as! UINavigationController
            let MyIntenariesVC = mainStoryboard.instantiateViewController(withIdentifier: "MyIntenariesVC") as! MyIntenariesVC
            navigation.viewControllers = [MyIntenariesVC]
            self.sideMenuController?.hideLeftView(animated: true, completion: nil)
        }
        else if indexPath.row == 3
        {// how tin work
            let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
            let controller = appDelegate.window?.rootViewController as! LGSideMenuController
            let navigation = controller.rootViewController as! UINavigationController
            let HomeVC = mainStoryboard.instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
            navigation.viewControllers = [HomeVC]
            self.sideMenuController?.hideLeftView(animated: true, completion: nil)
        }
        else if indexPath.row == 4
        {// contact us
            let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
            let controller = appDelegate.window?.rootViewController as! LGSideMenuController
            let navigation = controller.rootViewController as! UINavigationController
            let ContactUSVC = mainStoryboard.instantiateViewController(withIdentifier: "ContactUSVC") as! ContactUSVC
            navigation.viewControllers = [ContactUSVC]
            self.sideMenuController?.hideLeftView(animated: true, completion: nil)
        }
    }
    
}
class SideMenuTblViewCell: UITableViewCell{
    @IBOutlet weak var imgicon: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
}
