//
//  FlightSearchVC.swift
//  iOS_Flight-Booking
//
//  Created by Code on 14/02/23.
//

protocol AirCraftTypeDelegate
{
    func onAirCraftType(name: String, selectecIndex: Int)
}


import UIKit

class FlightSearchVC: UIViewController, WWCalendarTimeSelectorProtocol, AirCraftTypeDelegate {
    
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var viewTblView: UIView!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var viewRoundTrip: UIView!
    @IBOutlet weak var viewOneWay: UIView!
    
    @IBOutlet weak var lblDEF: UILabel!
    @IBOutlet weak var lblDET: UILabel!
    @IBOutlet weak var lblDD: UILabel!
    @IBOutlet weak var lblDT: UILabel!
    @IBOutlet weak var lblRD: UILabel!
    @IBOutlet weak var lblRT: UILabel!
    @IBOutlet weak var txtPaddenger: UITextField!
    @IBOutlet weak var lblAT: UILabel!
    
    @IBOutlet weak var imgFuel: UIImageView!
    
    @IBOutlet weak var viewReturnDate: UIView!
    @IBOutlet weak var viewHeightRD: NSLayoutConstraint!
    @IBOutlet weak var viewTopPass: NSLayoutConstraint!
    @IBOutlet weak var viewHeghtMain: NSLayoutConstraint!
  
    var strSelectedDate = ""
    var strSelectedTimeDT = ""
    var strSelectedTimeRT = ""

    var strName = ""
    
    var isDEF = false
    
    var strType = ""
    
    var strDF_ID = ""
    var strDT_ID = ""

    var De_From_airportCode = ""
    var De_To_airportCode = ""
    
    var De_Re_From_airportCode = ""
    var De_Re_To_airportCode = ""

    
    var objStartDateRange: Date = Date()
    var objEndDateRange: Date = Date()
    
    fileprivate var singleDate: Date = Date()
    fileprivate var multipleDates: [Date] = []
    
    fileprivate var singleStart: Date = Date()

    var isFromSide = false
    
    var selectedIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgFuel.image = UIImage(named: "Tick Box")
        
        strType = "oneway"
        viewOneWay.isHidden = false
        viewRoundTrip.isHidden = true
        viewReturnDate.isHidden = true
        viewHeightRD.constant = 0
        viewTopPass.constant = 0
        viewHeghtMain.constant = 560
        viewTblView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 560)
        tblView.reloadData()
        
        viewTop.layer.applySketchShadow(color: .black, alpha: 0.08, x: 0, y: 4, blur: 18, spread: 0)
        
        viewTop.layer.cornerRadius = 15
        viewTop.layer.maskedCorners = [.layerMinXMaxYCorner, . layerMaxXMaxYCorner] // Bottom Corner
        
        viewMain.layer.applySketchShadow(color: .black, alpha: 0.07, x: 0, y: 0, blur: 18, spread: 0)
        
        lblDEF.text = strName
        
        // Do any additional setup after loading the view.
    }
    
    func onAirCraftType(name: String, selectecIndex: Int) {
        self.lblAT.text = name
        
        selectedIndex = selectecIndex
    }
    
    @IBAction func clickedBack(_ sender: Any) {
        
        if isFromSide == true
        {
            appDelegate.setUpHome()
        }
        else
        {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    @IBAction func clickedOneWay(_ sender: Any) {
        strType = "oneway"
        viewOneWay.isHidden = false
        viewRoundTrip.isHidden = true
        viewReturnDate.isHidden = true
        viewHeightRD.constant = 0
        viewTopPass.constant = 0
        viewHeghtMain.constant = 560
        viewTblView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 560)
        tblView.reloadData()
    }
    @IBAction func clickedRoundTrip(_ sender: Any) {
        strType = "round"
        viewOneWay.isHidden = true
        viewRoundTrip.isHidden = false
        viewReturnDate.isHidden = false
        viewHeightRD.constant = 50
        viewTopPass.constant = 17
        viewHeghtMain.constant = 620
        viewTblView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 650)
        tblView.reloadData()
    }
    @IBAction func clickedSearch(_ sender: Any) {
        
        self.view.hideToast()
        let windows = UIApplication.shared.windows
        windows.last?.hideToast()
        
        if strDF_ID == ""
        {
            self.view.makeToast("Please select departing from")
            let windows = UIApplication.shared.windows
            windows.last?.makeToast("Please select departing from")

        }
        else if strDT_ID == ""
        {
            self.view.makeToast("Please select departing to")
            let windows = UIApplication.shared.windows
            windows.last?.makeToast("Please select departing to")
        }
        else if self.lblDD.text == ""
        {
            self.view.makeToast("Please enter departure date")
            let windows = UIApplication.shared.windows
            windows.last?.makeToast("Please enter departure date")
        }
        else if strSelectedTimeDT == ""
        {
            self.view.makeToast("Please enter departure time")
            let windows = UIApplication.shared.windows
            windows.last?.makeToast("Please enter departure time")
        }
        else if self.txtPaddenger.text == ""
        {
            self.view.makeToast("Please enter passenger")
            let windows = UIApplication.shared.windows
            windows.last?.makeToast("Please enter passenger")
        }
        else if self.lblAT.text == ""
        {
            self.view.makeToast("Please select aircraft type")
            let windows = UIApplication.shared.windows
            windows.last?.makeToast("Please select aircraft type")
        }
        else
        {
            callFightAPI()
        }
 
    }
    
  
    @IBAction func clickedDEF(_ sender: Any) {
        isDEF = true
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "SearchVC") as! SearchVC
        vc.delegateAddress = self
        vc.strFrom = self.strDF_ID
        vc.strTo = self.strDT_ID
        vc.isDEF = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func clickedDET(_ sender: Any) {
        isDEF = false
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "SearchVC") as! SearchVC
        vc.delegateAddress = self
        vc.strFrom = self.strDF_ID
        vc.strTo = self.strDT_ID
        vc.isDEF = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func clickedDD(_ sender: Any) {
        let selector = UIStoryboard(name: "WWCalendarTimeSelector", bundle: nil).instantiateInitialViewController() as! WWCalendarTimeSelector
        strSelectedDate = "DD"
        selector.delegate = self
        selector.optionCurrentDate = singleDate
        selector.optionCurrentDates = Set(multipleDates)
        selector.optionCurrentDateRange.setStartDate(multipleDates.first ?? singleDate)
        selector.optionCurrentDateRange.setEndDate(multipleDates.last ?? singleDate)
        
        selector.optionStyles.showDateMonth(true)
        selector.optionStyles.showMonth(false)
        selector.optionStyles.showYear(false)
        selector.optionStyles.showTime(false)
        self.present(selector, animated: true, completion: nil)
    }
    @IBAction func clickedDT(_ sender: Any) {
        let selector = UIStoryboard(name: "WWCalendarTimeSelector", bundle: nil).instantiateInitialViewController() as! WWCalendarTimeSelector
        strSelectedDate = "DT"
        selector.delegate = self
        selector.optionCurrentDate = singleDate
        selector.optionCurrentDates = Set(multipleDates)
        selector.optionCurrentDateRange.setStartDate(multipleDates.first ?? singleDate)
        selector.optionCurrentDateRange.setEndDate(multipleDates.last ?? singleDate)
        
        selector.optionStyles.showDateMonth(false)
        selector.optionStyles.showMonth(false)
        selector.optionStyles.showYear(false)
        selector.optionStyles.showTime(true)
        self.present(selector, animated: true, completion: nil)
    }
    @IBAction func clickedRD(_ sender: Any) {
        let selector = UIStoryboard(name: "WWCalendarTimeSelector", bundle: nil).instantiateInitialViewController() as! WWCalendarTimeSelector
        strSelectedDate = "RD"
        selector.delegate = self
        selector.optionCurrentDate = singleDate
        selector.optionCurrentDates = Set(multipleDates)
        selector.optionCurrentDateRange.setStartDate(multipleDates.first ?? singleDate)
        selector.optionCurrentDateRange.setEndDate(multipleDates.last ?? singleDate)
        
        selector.optionStyles.showDateMonth(true)
        selector.optionStyles.showMonth(false)
        selector.optionStyles.showYear(false)
        selector.optionStyles.showTime(false)
        self.present(selector, animated: true, completion: nil)
    }
    @IBAction func clickedRT(_ sender: Any) {
        let selector = UIStoryboard(name: "WWCalendarTimeSelector", bundle: nil).instantiateInitialViewController() as! WWCalendarTimeSelector
        strSelectedDate = "RT"
        selector.delegate = self
        selector.optionCurrentDate = singleDate
        selector.optionCurrentDates = Set(multipleDates)
        selector.optionCurrentDateRange.setStartDate(multipleDates.first ?? singleDate)
        selector.optionCurrentDateRange.setEndDate(multipleDates.last ?? singleDate)
        
        selector.optionStyles.showDateMonth(false)
        selector.optionStyles.showMonth(false)
        selector.optionStyles.showYear(false)
        selector.optionStyles.showTime(true)
        self.present(selector, animated: true, completion: nil)
    }
    @IBAction func clickedAT(_ sender: Any) {

        self.view.hideToast()
        let windows = UIApplication.shared.windows
        windows.last?.hideToast()
        
        if strDF_ID == ""
        {
            self.view.makeToast("Please select departing from")
            let windows = UIApplication.shared.windows
            windows.last?.makeToast("Please select departing from")

        }
        else if strDT_ID == ""
        {
            self.view.makeToast("Please select departing to")
            let windows = UIApplication.shared.windows
            windows.last?.makeToast("Please select departing to")
        }
        else
        {
            let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
            let vc = mainStoryboard.instantiateViewController(withIdentifier: "AirCraftTypeVC") as! AirCraftTypeVC
            vc.selectecIndex = self.selectedIndex
            vc.delagate = self
            vc.strFrom = self.strDF_ID
            vc.strTo = self.strDT_ID
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
        }
            
       
    }
    @IBAction func clickedFuelStop(_ sender: Any) {
        if imgFuel.image == UIImage(named: "Check Mark")
        {
            imgFuel.image = UIImage(named: "Tick Box")
        }
        else
        {
            imgFuel.image = UIImage(named: "Check Mark")
        }
    }
    
    // MARK: - WWCalendar Delegate
    
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date) {
        print("Selected \n\(date)\n---")
        singleDate = date
        
        if strSelectedDate == "DD"
        {
            objStartDateRange = date
            lblDD.text = date.stringFromFormat("yyyy-MM-dd")
        }
        else if strSelectedDate == "DT"
        {
            lblDT.text = date.stringFromFormat("hh:mm a")
            strSelectedTimeDT = date.stringFromFormat("HH:mm")
        }
        else if strSelectedDate == "RD"
        {
            objEndDateRange = date
            lblRD.text = date.stringFromFormat("yyyy-MM-dd")
        }
        else
        {
            lblRT.text = date.stringFromFormat("hh:mm a")
            strSelectedTimeRT = date.stringFromFormat("HH:mm")

        }
       
    }
    
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, dates: [Date]) {
        print("Selected Multiple Dates \n\(dates)\n---")
        if let date = dates.first {
            singleDate = date
            lblDD.text = date.stringFromFormat("yyyy-MM-dd")
        }
        else {
            lblDD.text = "No Date Selected"
        }
        multipleDates = dates
    }
    
    func WWCalendarTimeSelectorShouldSelectDate(_ selector: WWCalendarTimeSelector, date: Date) -> Bool {
        
        if strSelectedDate == "DD"
        {
            
            if lblRD.text == ""
            {
                if date >= Date()
                {
                    return true
                }
            }
            else
            {
                if date <= objEndDateRange && date >= Date()
                {
                    return true
                }
            }
            
            
        }
        else if strSelectedDate == "RD"
        {
            if date >= objStartDateRange
            {
                return true
            }
        }
        else
        {
            let tomorrow = Calendar.current.date(byAdding: .day, value: 0, to: objStartDateRange)
            
            if date >= tomorrow!
            {
                return true
            }
        }
        return false
    }
    
    // MARK: - callAPI
    
    func callFightAPI()
    {
        self.view.hideToast()
        let windows = UIApplication.shared.windows
        windows.last?.hideToast()
        
        var param = ["":""]
        
        if strType == "oneway"
        {
            param = ["userid":appDelegate.dicCurrentUserData.id ?? "","departing_from":self.strDF_ID,"departing_to":self.strDT_ID,"departure_time":self.strSelectedTimeDT,"departure_date":self.lblDD.text ?? "","passenger":self.txtPaddenger.text ?? "","aircraft_id":appDelegate.strAirCraftType,"trip_type":self.strType]
        }
        else
        {
            param = ["userid":appDelegate.dicCurrentUserData.id ?? "","departing_from":self.strDF_ID,"departing_to":self.strDT_ID,"departure_date":self.lblDD.text ?? "","departure_time":self.strSelectedTimeDT,"passenger":self.txtPaddenger.text ?? "","aircraft_id":appDelegate.strAirCraftType,"trip_type":self.strType,"return_date":self.lblRD.text ?? "","return_time":self.strSelectedTimeRT]
        }
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithOutHeaderPost(SEARCH_NEW_FLIGHT, parameters: param) { response, error, statusCode in
            
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
                        self.view.makeToast(msg)
                        let windows = UIApplication.shared.windows
                        windows.last?.makeToast(msg)
                        
                        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
                        let vc = mainStoryboard.instantiateViewController(withIdentifier: "AirCraftVC") as! AirCraftVC
                        vc.strFrom = self.strDF_ID
                        vc.strTo = self.strDT_ID
                        vc.strPassenger = self.txtPaddenger.text ?? ""
                        vc.strDepartureDate = self.lblDD.text ?? ""
                        vc.strDepartureTime = self.lblDT.text ?? ""
                        vc.strReturnDate = self.lblRD.text ?? ""
                        vc.strReturnTime = self.lblRT.text ?? ""
                        vc.strTripType = self.strType
                        vc.De_From_airportCode = self.De_From_airportCode
                        vc.De_To_airportCode = self.De_To_airportCode

                        self.navigationController?.pushViewController(vc, animated: false)
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

extension FlightSearchVC: LocationListingScreenDelegate
{
    func reloadSearch(objPlaceData: JBSearchFightListData) {
        
        if isDEF == true
        {
            self.lblDEF.text = "\(objPlaceData.airportName ?? "")(\(objPlaceData.airportCode ?? ""))"
            self.strDF_ID = objPlaceData.id ?? ""
            self.De_From_airportCode = objPlaceData.airportCode ?? ""

        }
        else
        {
            self.lblDET.text = "\(objPlaceData.airportName ?? "")(\(objPlaceData.airportCode ?? ""))"
            self.strDT_ID = objPlaceData.id ?? ""
            self.De_To_airportCode = objPlaceData.airportCode ?? ""

        }
        
    }
    
    
}
