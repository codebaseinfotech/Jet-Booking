//
//  ContactUSVC.swift
//  iOS_Flight-Booking
//
//  Created by Code on 16/02/23.
//

import UIKit
import UIKit
import MessageUI

class ContactUSVC: UIViewController,MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var lblWebSite: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewTop.layer.applySketchShadow(color: .black,alpha: 0.08,x: 0,y: 0,blur: 18,spread: 0)
        
        viewTop.layer.cornerRadius = 20
        viewTop.layer.maskedCorners = [.layerMinXMaxYCorner, . layerMaxXMaxYCorner] // Bottom Corner
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickedBack(_ sender: Any) {
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC {
            
            let viewcontrollers = self.navigationController?.viewControllers
            var isExist = false
            for viewcontroller in viewcontrollers! {
                if viewcontroller.isKind(of: HomeVC.self) {
                    isExist = true
                    break
                }
            }
            if isExist == true {
                self.navigationController?.popViewController(animated: true)
            } else {
                self.navigationController?.viewControllers.insert(controller, at: (viewcontrollers?.count)!)
                self.navigationController?.popToViewController(controller, animated: false)
            }
        }
    }
    
    @IBAction func clickedEmail(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self
            mailComposer.setToRecipients(["charter@flyelitejets.com"])
            mailComposer.setSubject("Contact Us")
            
            present(mailComposer, animated: true, completion: nil)
        } else {
            // Handle the case where the device can't send emails.
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        
        switch result {
        case .cancelled:
            print("Email cancelled")
        case .saved:
            print("Email saved as draft")
        case .sent:
            print("Email sent successfully")
        case .failed:
            print("Email sending failed")
        @unknown default:
            fatalError("Unknown MFMailComposeResult case")
        }
    }
    
    
    @IBAction func clickedPhone(_ sender: Any) {
        if let phoneURL = URL(string: "tel://+442070432447") {
            if UIApplication.shared.canOpenURL(phoneURL) {
                UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
            } else {
                // Handle the case where the device can't make phone calls.
            }
        }
        
    }
    
    @IBAction func clickedWeb(_ sender: Any) {
        if let url = URL(string: "http://www.flyelitejets.com") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                // Handle the case where the device can't open URLs.
            }
        }
    }
    
}
