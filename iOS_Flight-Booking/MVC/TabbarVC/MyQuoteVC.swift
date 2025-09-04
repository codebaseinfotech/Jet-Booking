//
//  MyQuoteVC.swift`
//  iOS_Flight-Booking
//
//  Created by Code on 16/02/23.
//

import UIKit

class MyQuoteVC: UIViewController {
    
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var tblViewQuote: UITableView!
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var viewNo: UIView!
    
    var arrUpcomingItenaries: [JBUpcomingItenariesData] = [JBUpcomingItenariesData]()
    
    var currentIndex = -1
    
    var strDF = ""
    
    var strDT = ""
    
    var strDD = ""
    
    var strTitle = ""
    
    var strUID = ""
    
    var isFromMyBooking = false
    
    var isFromUpcoming = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewBG.isHidden = true
        
        tblViewQuote.delegate = self
        tblViewQuote.dataSource = self
        
        viewTop.layer.applySketchShadow(color: .black,alpha: 0.08,x: 0,y: 0,blur: 18,spread: 0)
        
        viewTop.layer.cornerRadius = 20
        viewTop.layer.maskedCorners = [.layerMinXMaxYCorner, . layerMaxXMaxYCorner] // Bottom Corner
        
        if isFromUpcoming == true
        {
            callUpcomingItenariesListAPI()
        }
        else
        {
            callPastItenariesListAPI()
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickedYes(_ sender: UIButton) {
        
        let dicData = arrUpcomingItenaries[currentIndex]
        callDeleteFightQueteAPI(request_id: dicData.id ?? "")
        self.tblViewQuote.reloadData()
    }
    
    @IBAction func clickedNo(_ sender: Any) {
        viewBG.isHidden = true
    }
    
    @IBAction func clickedBack(_ sender: Any) {
        
        appDelegate.isFromBackReq = true
        
        if isFromMyBooking == true
        {
            self.navigationController?.popViewController(animated: true)
        }
        else
        {
            appDelegate.setUpHome()
        }
        
    }
    
    @IBAction func clcikdTabHome(_ sender: Any) {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func clickedTabEmpty(_ sender: Any) {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "EmptyLegsVC") as! EmptyLegsVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func clickedTabProfile(_ sender: Any) {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func callDeleteFightQueteAPI(request_id:String)
    {
        self.view.hideToast()
        let windows = UIApplication.shared.windows
        windows.last?.hideToast()
        
        let param = ["id":request_id]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithOutHeaderPost(DELETE_FIGHT_RE, parameters: param) { response, error, statusCode in
            
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
                        
                        self.viewBG.isHidden = true
                        
                        self.callUpcomingItenariesListAPI()
                        
                        if self.arrUpcomingItenaries.count > 0
                        {
                            self.tblViewQuote.isHidden = false
                            self.viewNo.isHidden = true
                        }
                        else
                        {
                            self.tblViewQuote.isHidden = true
                            self.viewNo.isHidden = false
                        }
                        
                        self.view.makeToast(msg)
                        let windows = UIApplication.shared.windows
                        windows.last?.makeToast(msg)
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
    
    func callUpcomingItenariesListAPI()
    {
        let param = ["userid":appDelegate.dicCurrentUserData.id ?? "","departing_from":self.strDF,"departing_to":self.strDT]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithOutHeaderPost(UPACOMMING_ITEARIES_LIST, parameters: param) { response, error, statusCode in
            
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
                        let arrData = response?.value(forKey: "data") as? NSArray
                        self.arrUpcomingItenaries.removeAll()
                        
                        for obj in arrData!
                        {
                            let dicData = JBUpcomingItenariesData(fromDictionary: obj as! NSDictionary)
                            self.arrUpcomingItenaries.append(dicData)
                        }
                        
                        if self.arrUpcomingItenaries.count > 0
                        {
                            self.tblViewQuote.isHidden = false
                            self.viewNo.isHidden = true
                        }
                        else
                        {
                            self.tblViewQuote.isHidden = true
                            self.viewNo.isHidden = false
                        }
                        
                       // self.arrUpcomingItenaries = self.arrUpcomingItenaries.reversed()
                        
                        self.tblViewQuote.reloadData()
                    }
                    else
                    {
                        self.view.makeToast(msg)
                        let windows = UIApplication.shared.windows
                        windows.last?.makeToast(msg)
                        
                        if self.arrUpcomingItenaries.count > 0
                        {
                            self.tblViewQuote.isHidden = false
                            self.viewNo.isHidden = true
                        }
                        else
                        {
                            self.tblViewQuote.isHidden = true
                            self.viewNo.isHidden = false
                        }
                    }
                }
            }
        }
    }
    
    func callPastItenariesListAPI()
    {
        self.view.hideToast()
        let windows = UIApplication.shared.windows
        windows.last?.hideToast()
        
        let param = ["userid":appDelegate.dicCurrentUserData.id ?? "","departing_from":self.strDF,"departing_to":self.strDT]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithOutHeaderPost(PAST_DETAIL, parameters: param) { response, error, statusCode in
            
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
                        let arrData = response?.value(forKey: "data") as? NSArray
                        self.arrUpcomingItenaries.removeAll()
                        
                        for obj in arrData!
                        {
                            let dicData = JBUpcomingItenariesData(fromDictionary: obj as! NSDictionary)
                            self.arrUpcomingItenaries.append(dicData)
                        }
                        
                        if self.arrUpcomingItenaries.count > 0
                        {
                            self.tblViewQuote.isHidden = false
                            self.viewNo.isHidden = true
                        }
                        else
                        {
                            self.tblViewQuote.isHidden = true
                            self.viewNo.isHidden = false
                        }
                        
                    //
                        self.arrUpcomingItenaries = self.arrUpcomingItenaries.reversed()
                        
                        self.tblViewQuote.reloadData()
                    }
                    else
                    {
                        self.view.makeToast(msg)
                        let windows = UIApplication.shared.windows
                        windows.last?.makeToast(msg)
                        
                        if self.arrUpcomingItenaries.count > 0
                        {
                            self.tblViewQuote.isHidden = false
                            self.viewNo.isHidden = true
                        }
                        else
                        {
                            self.tblViewQuote.isHidden = true
                            self.viewNo.isHidden = false
                        }
                    }
                }
            }
        }
    }
    
    
}
extension MyQuoteVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrUpcomingItenaries.count
        
    }
    
    func convertMinutesToHoursMinutes(minutes: Int) -> (hours: Int, minutes: Int) {
        let hours = minutes / 60
        let remainingMinutes = minutes % 60
        return (hours, remainingMinutes)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = self.tblViewQuote.dequeueReusableCell(withIdentifier: "MyQuoteTblViewCell") as! MyQuoteTblViewCell
        
        let dicData = arrUpcomingItenaries[indexPath.row]
        
        if let objTitle = dicData.title
        {
            cell.lblFlightName.text = objTitle
        }
        else
        {
            cell.lblFlightName.text = " "
        }
        
        let totalMinutes = Int(dicData.duration ?? 0)
        
        let (hours, minutes) = convertMinutesToHoursMinutes(minutes: totalMinutes ?? 0)
        
        cell.lblFlightDuration.text = "Duration: \(hours) hour \(minutes) minutes"
        
        cell.btnStatus.setTitle(dicData.status ?? "", for: .normal)
        
        cell.lblDate.text = dicData.request_date ?? ""
        cell.lblTime.text = dicData.request_time ?? ""
        
        if dicData.requestId == ""
        {
            cell.lblReqID.text = "Request ID: #000\(dicData.id ?? "")"
        }
        else if dicData.requestId == nil
        {
            cell.lblReqID.text = "Request ID: #000\(dicData.id ?? "")"
        }
        else
        {
            cell.lblReqID.text = "Request ID: #000\(dicData.requestId ?? "")"
        }
        
        
        let bidAccepted = dicData.createdAt ?? ""
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date1 = formatter.date(from: bidAccepted)
        let Dform = DateFormatter()
        Dform.dateFormat = "dd MMM yyyy"
        let strDate = Dform.string(from: date1!)
        cell.lblReqDate.text = "Request date: \(strDate)"
        
        
        if let price = dicData.price
        {
            cell.lblPrice.text = "€\(dicData.price ?? "")"
        }
        else
        {
            cell.lblPrice.text = "€0"
        }
        
        
        if dicData.status == "cancelled"
        {
            cell.btnDeleteRequest.setTitle("Cancelled", for: .normal)
            cell.btnDeleteRequest.backgroundColor = UIColor(red: 236/255, green: 236/255, blue: 236/255, alpha: 1)
            cell.btnDeleteRequest.tag = indexPath.row
            cell.btnDeleteRequest.removeTarget(self, action: #selector(clickedDelete(_:)), for: .touchUpInside)
        }
        else
        {
            cell.btnDeleteRequest.setTitle("Delete Request", for: .normal)
            cell.btnDeleteRequest.backgroundColor = .black
            cell.btnDeleteRequest.tag = indexPath.row
            cell.btnDeleteRequest.addTarget(self, action: #selector(clickedDelete(_:)), for: .touchUpInside)
        }
        
        cell.imgFlight.kf.setImage(
            with: URL(string: dicData.image ?? ""),
            placeholder: UIImage(named: "airplane"),
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
        
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "FlightDetailVC") as! FlightDetailVC
        vc.strFlight_id = arrUpcomingItenaries[indexPath.row].flight_id ?? ""
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    
    @objc func clickedDelete(_ sender: UIButton)
    {
        self.currentIndex = sender.tag
        viewBG.isHidden = false
    }
    
    
}

class MyQuoteTblViewCell: UITableViewCell{
    @IBOutlet weak var imgFlight: UIImageView!
    @IBOutlet weak var lblFlightName: UILabel!
    @IBOutlet weak var lblFlightDuration: UILabel!
    @IBOutlet weak var btnStatus: UIButton!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnDeleteRequest: UIButton!
    
    @IBOutlet weak var lblReqDate: UILabel!
    @IBOutlet weak var lblReqID: UILabel!

}
