//
//  BookYourFlightVC.swift
//  FLY ELITEJETS
//
//  Created by iMac on 09/09/25.
//

import UIKit
import DropDown
import CountryPickerView

class BookYourFlightVC: UIViewController {

    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var viewFlyPrivately: UIView!
    @IBOutlet weak var viewFlyingSolution: UIView!
    @IBOutlet weak var viewAboutFlyEliteJet: UIView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblFlyPrivately: UILabel!
    @IBOutlet weak var lblFlyingSolution: UILabel!
    @IBOutlet weak var lblAboutFlyEliteJet: UILabel!
    
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var imgCountryFlag: UIImageView!
    
    @IBOutlet weak var txtFName: UITextField!
    @IBOutlet weak var txtLName: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtMessageView: UITextView!
    
    @IBOutlet weak var imgCheckBox: UIImageView!
    
    var arrTitle = ["Mr.", "Mrs.", "Ms.", "Other"]
    
    var arrFlyPrivately = ["I am new to private aviation", "1-25 hours", "25-50 hours", "50-75 hours", "75-100 hours", "100+ hours", "Frequently, own an aircraft"]
    
    var arrFlyingSolution = ["Charter", "Commercial", "Fractional Ownership", "Aircraft Ownership", "Jet card"]
    
    var arrAboutFlyEliteJet = ["Wall Street Journal", "New York Times", "Forbes", "CNBC", "Google Search", "Social Media", "Recommendation", "Other"]
    
    let titleDropDown = DropDown()
    let flyPrivatelyDropDown = DropDown()
    let flyingSolutionDropDown = DropDown()
    let aboutFlyEliteJetDropDown = DropDown()
    
    let countryPickerView = CountryPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewTop.layer.applySketchShadow(color: .black,alpha: 0.08,x: 0,y: 0,blur: 18,spread: 0)
        
        viewTop.layer.cornerRadius = 20
        viewTop.layer.maskedCorners = [.layerMinXMaxYCorner, . layerMaxXMaxYCorner]
        
        DropDown.appearance().backgroundColor = UIColor.white
        DropDown.appearance().textColor = UIColor.black
        
        
        countryPickerView.delegate = self
        countryPickerView.showPhoneCodeInView = true   // shows +91, +1 etc.
        
        // Set default country (optional)
        let defaultCountry = countryPickerView.selectedCountry
        lblCountry.text = "\(defaultCountry.phoneCode)"
        imgCountryFlag.image = defaultCountry.flag
        
        imgCheckBox.image = UIImage(named: "ic_check-box")
        
        txtFName.text = appDelegate.dicCurrentUserData.firstName ?? ""
        txtLName.text = appDelegate.dicCurrentUserData.lastName ?? ""
        txtEmail.text = appDelegate.dicCurrentUserData.email ?? ""
        
        setupDropDowns()
        // Do any additional setup after loading the view.
    }
    
    private func setupDropDowns() {
        // Title dropdown
        titleDropDown.anchorView = viewTitle
        titleDropDown.dataSource = arrTitle
        titleDropDown.selectionAction = { [weak self] (index, item) in
            self?.lblTitle.text = item
        }
        
        // Fly Privately dropdown
        flyPrivatelyDropDown.anchorView = viewFlyPrivately
        flyPrivatelyDropDown.dataSource = arrFlyPrivately
        flyPrivatelyDropDown.selectionAction = { [weak self] (index, item) in
            self?.lblFlyPrivately.text = item
        }
        
        // Flying Solution dropdown
        flyingSolutionDropDown.anchorView = viewFlyingSolution
        flyingSolutionDropDown.dataSource = arrFlyingSolution
        flyingSolutionDropDown.selectionAction = { [weak self] (index, item) in
            self?.lblFlyingSolution.text = item
        }
        
        // About FlyEliteJet dropdown
        aboutFlyEliteJetDropDown.anchorView = viewAboutFlyEliteJet
        aboutFlyEliteJetDropDown.dataSource = arrAboutFlyEliteJet
        aboutFlyEliteJetDropDown.selectionAction = { [weak self] (index, item) in
            self?.lblAboutFlyEliteJet.text = item
        }
    }
    
    @IBAction func clickedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tappedTitleBtn(_ sender: Any) {
        titleDropDown.show()
    }
    
    @IBAction func tappedPhoneBtn(_ sender: Any) {
    }
    
    @IBAction func tappedFlyPrivatelyBtn(_ sender: Any) {
        flyPrivatelyDropDown.show()
    }
    
    @IBAction func tappedFlyingSolutionBtn(_ sender: Any) {
        flyingSolutionDropDown.show()
    }
   
    @IBAction func tappedAboutFlyEliteJetBtn(_ sender: Any) {
        aboutFlyEliteJetDropDown.show()
    }
    
    
    @IBAction func tappedCountryPicker(_ sender: Any) {
        countryPickerView.showCountriesList(from: self)
    }
    
    
    @IBAction func clickedSubmit(_ sender: Any) {
        if lblTitle.text == "Select an option" {
            self.view.makeToast("Please select title")
            UIApplication.shared.windows.last?.makeToast("Please select title")
            return
        } else if txtFName.text == "" {
            self.view.makeToast("Enter first name")
            UIApplication.shared.windows.last?.makeToast("Enter first name")
            return
        } else if txtLName.text == "" {
            self.view.makeToast("Enter last name")
            UIApplication.shared.windows.last?.makeToast("Enter last name")
            return
        } else if txtPhoneNumber.text == "" {
            self.view.makeToast("Enter phone number")
            UIApplication.shared.windows.last?.makeToast("Enter phone number")
            return
        } else if txtEmail.text == "" {
            self.view.makeToast("Enter email address")
            UIApplication.shared.windows.last?.makeToast("Enter email address")
            return
        } else if !isValidEmail(txtEmail.text ?? "") {
            self.view.makeToast("Enter valid email address")
            UIApplication.shared.windows.last?.makeToast("Enter valid email address")
            return
        } else if lblFlyPrivately.text == "Select an option" {
            self.view.makeToast("Please select fly privately option")
            UIApplication.shared.windows.last?.makeToast("Please select fly privately option")
            return
        } else if lblFlyingSolution.text == "Select an option" {
            self.view.makeToast("Please select flying solution")
            UIApplication.shared.windows.last?.makeToast("Please select flying solution")
            return
        } else if lblAboutFlyEliteJet.text == "Select an option" {
            self.view.makeToast("Please select how you heard about us")
            UIApplication.shared.windows.last?.makeToast("Please select how you heard about us")
            return
        } else if txtMessageView.text == "" {
            self.view.makeToast("Please enter message")
            UIApplication.shared.windows.last?.makeToast("Please enter message")
            return
        } else if imgCheckBox.image != UIImage(named: "ic_check-box") {
            self.view.makeToast("Please accept the terms and conditions")
            UIApplication.shared.windows.last?.makeToast("Please accept the terms and conditions")
            return
        }
        
        self.callEmptyLegsRequestAPI()
    }
    
    @IBAction func clickedCheckBox(_ sender: Any) {
        if imgCheckBox.image == UIImage(named: "ic_check-box")
        {
            imgCheckBox.image = UIImage(named: "ic_uncheck")
        }
        else
        {
            imgCheckBox.image = UIImage(named: "ic_check-box")
        }
    }
    
    
    
    //MARK: - callEmptyLegsRequestAPI()
    func callEmptyLegsRequestAPI() {
        APIClient.sharedInstance.showIndicator()
        
        let param: [String: Any] = [
            "title": lblTitle.text ?? "",
            "first_name": txtFName.text ?? "",
            "last_name": txtLName.text ?? "",
            "dial_code": lblCountry.text ?? "",
            "mobile": txtPhoneNumber.text ?? "",
            "email": txtEmail.text ?? "",
            "fly_privately": lblFlyPrivately.text ?? "",
            "flying_solution": lblFlyingSolution.text ?? "",
            "hear_about_us": lblAboutFlyEliteJet.text ?? "",
            "message": txtMessageView.text ?? "",
            "userid": appDelegate.dicCurrentUserData.id ?? ""
        ]
        
        print("PARAMS: \(param)")
        
        APIClient.sharedInstance.MakeAPICallWithOutHeaderPost(EMPTY_LEGS_REQUEST, parameters: param) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            APIClient.sharedInstance.hideIndicator()
            
            if error == nil, statusCode == 200 {
                let status = response?.value(forKey: "status") as? Int
                let msg = response?.value(forKey: "msg") as? String
                
                if status == 1 {
                    DispatchQueue.main.async {
                        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
                        let vc = mainStoryboard.instantiateViewController(withIdentifier: "BookingSubmittedPopUp") as! BookingSubmittedPopUp
                        let navController = UINavigationController(rootViewController: vc)
                        navController.navigationBar.isHidden = true
                        navController.modalPresentationStyle = .overFullScreen
                        navController.modalTransitionStyle = .crossDissolve
                        self.present(navController, animated: true, completion: nil)
                    }
                } else {
                    self.view.makeToast(msg)
                    let windows = UIApplication.shared.windows
                    windows.last?.makeToast(msg)
                    APIClient.sharedInstance.hideIndicator()
                }
            } else {
                APIClient.sharedInstance.hideIndicator()
            }
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
}

extension BookYourFlightVC: CountryPickerViewDelegate {
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        lblCountry.text = country.phoneCode
        imgCountryFlag.image = country.flag
    }
}
