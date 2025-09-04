//
//  PopUpRequestVC.swift
//  Jet Booking
//
//  Created by iMac on 27/02/23.
//

import UIKit
import Toast_Swift

class PopUpRequestVC: UIViewController {
    
    @IBOutlet weak var btnReq: UIButton!
    
    @IBOutlet weak var MainVew: UIView!
    
    @IBOutlet weak var PopUpViewReqSebutomy: UIView!
    
    @IBOutlet weak var ttView: UITextView!
    @IBOutlet weak var lblTitle: UILabel! // You are about to submit a quote request for 2 aircrafts. Please let us know if you have any special requirements
        
    var strFightID = NSMutableArray()
    
    var strRquestPass = ""
    
    var strRequestType = ""
    var strCount = ""
    
    var strDepartureDate = ""
    var strDepartureTime = ""

    var strReturnDate = ""
    var strReturnTime = ""
    
    var departingFrom_ID = ""
    var departingTo_ID = ""
    
    var strPrice = NSMutableArray()

    var arrFightRequest: [JBAddFightListData] = [JBAddFightListData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.MainVew.isHidden = false

        self.PopUpViewReqSebutomy.isHidden = true

        self.lblTitle.text = "You are about to submit a quote request for \(strCount) aircrafts. Please let us know if you have any special requirements"
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        btnReq.isUserInteractionEnabled = true
        
        if appDelegate.isFromBackReq == true
        {
            appDelegate.isFromBackReq = false
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
    }
   
    @IBAction func clickedCancel(_ sender: Any) {
        btnReq.isUserInteractionEnabled = true
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clickedRequest(_ sender: Any) {
        
        self.view.hideToast()
        let windows = UIApplication.shared.windows
        windows.last?.hideToast()
        
        if ttView.text == ""
        {
            self.view.makeToast("Enter your requirements")
        }
        else
        {
            btnReq.isUserInteractionEnabled = false
            
            callRequestFightAPI()
        }
    }
    
    func callRequestFightAPI()
    {
        var param = [String:Any]()
        
        if strReturnDate == ""
        {
            param = ["userid":appDelegate.dicCurrentUserData.id ?? "","flight_id":self.strFightID,"passenger":self.strRquestPass,"trip_type":self.strRequestType,"requirement":self.ttView.text ?? "","request_date":strDepartureDate,"request_time":strDepartureTime,"departing_from":self.departingFrom_ID,"departing_to":self.departingTo_ID,"price":self.strPrice]
        }
        else
        {
            param = ["userid":appDelegate.dicCurrentUserData.id ?? "","flight_id":self.strFightID,"passenger":self.strRquestPass,"trip_type":self.strRequestType,"requirement":self.ttView.text ?? "","request_date":strDepartureDate,"request_time":strDepartureTime,"departing_from":self.departingFrom_ID,"departing_to":self.departingTo_ID,"return_request_date":self.strReturnDate,"return_request_time":self.strReturnTime,"price":self.strPrice]
        }
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithOutHeaderPost(REQUEST_FLIGHT, parameters: param) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            if error == nil
            {
                if statusCode == 200
                {
                    let status = response?.value(forKey: "status") as? Int
                    let msg = response?.value(forKey: "msg") as? String
                    
                    if status == 1
                    {

                        self.PopUpViewReqSebutomy.isHidden = false
                        self.MainVew.isHidden = true
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            self.btnReq.isUserInteractionEnabled = true

                            let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
                            let vc = mainStoryboard.instantiateViewController(withIdentifier: "MyQuoteVC") as! MyQuoteVC
                            vc.strDF = self.departingFrom_ID
                            vc.strDT = self.departingTo_ID
                            vc.isFromUpcoming = true
                            self.navigationController?.pushViewController(vc, animated: false)
                        }
                    }
                    else
                    {
                        self.btnReq.isUserInteractionEnabled = true
                        self.view.makeToast(msg)
                        let windows = UIApplication.shared.windows
                        windows.last?.makeToast(msg)
                    }
                }
            }
        }
    }
        
}
