//
//  AirCraftVC.swift
//  iOS_Flight-Booking
//
//  Created by Code on 15/02/23.
//

import UIKit

class AirCraftVC: UIViewController {
    
    
    
    @IBOutlet weak var viewCount: UIView!
    @IBOutlet weak var viewSend: UIView!
    
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var lblDepartingFrom: UILabel!
    @IBOutlet weak var lblDepartingTo: UILabel!
    @IBOutlet weak var lblTimeAndDate: UILabel!
    @IBOutlet weak var tblViewFlightDetail: UITableView!
    
    @IBOutlet weak var lblReDepartingFrom: UILabel!
    @IBOutlet weak var lblReDepartingTo: UILabel!
    @IBOutlet weak var lblReTimeAndDate: UILabel!
    @IBOutlet weak var lblReArrow: UIImageView!
    
    
    @IBOutlet weak var lblFightCount: UILabel!
    
    var arrAddFightList: [JBAddFightListData] = [JBAddFightListData]()
    
    var strFrom = ""
    var strTo = ""
    
    var strDepartureDate = ""
    var strDepartureTime = ""
    
    var strReturnDate = ""
    var strReturnTime = ""
    
    var strPassenger = ""
    
    var strAircraftId = ""
    
    var strTripType = ""
    
    
    var arrSelectedAirCartID = NSMutableArray()
    var arrSelectedPriceID = NSMutableArray()

    
    var De_From_airportCode = ""
    var De_To_airportCode = ""
    
    var strPrice = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblDepartingFrom.text = self.De_From_airportCode
        self.lblDepartingTo.text = self.De_To_airportCode
        
        let bidAccepted = "\(strDepartureDate) \(strDepartureTime)"
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm a"
        let date1 = formatter.date(from: bidAccepted)
        let Dform = DateFormatter()
        Dform.dateFormat = "dd MMM yyyy | h:mm a"
        let strDate = Dform.string(from: date1!)
        self.lblTimeAndDate.text = strDate
        
        if  self.strTripType == "round"
        {
            self.lblReDepartingFrom.isHidden = false
            self.lblReDepartingTo.isHidden = false
            self.lblReTimeAndDate.isHidden = false
            self.lblReArrow.isHidden = false
            
            self.lblReDepartingFrom.text = self.De_To_airportCode
            self.lblReDepartingTo.text = self.De_From_airportCode
            
            let bidAccepted = "\(strReturnDate) \(strReturnTime)"
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd hh:mm a"
            let date1 = formatter.date(from: bidAccepted)
            let Dform = DateFormatter()
            Dform.dateFormat = "dd MMM yyyy | h:mm a"
            let strDate = Dform.string(from: date1!)
            self.lblReTimeAndDate.text = strDate
            
        }
        else
        {
            self.lblReDepartingFrom.isHidden = true
            self.lblReDepartingTo.isHidden = true
            self.lblReTimeAndDate.isHidden = true
            self.lblReArrow.isHidden = true
        }
        
        self.lblFightCount.text = "0"
        
        viewTop.layer.applySketchShadow(color: .black,alpha: 0.08,x: 0,y: 0,blur: 18,spread: 0)
        
        viewTop.layer.cornerRadius = 20
        viewTop.layer.maskedCorners = [.layerMinXMaxYCorner, . layerMaxXMaxYCorner] // Bottom Corner
        
        tblViewFlightDetail.delegate = self
        tblViewFlightDetail.dataSource  = self
        
        callAddFlightAPI()
    }
    
    @IBAction func clickedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickedSend(_ sender: Any) {
        
        self.view.hideToast()
        let windows = UIApplication.shared.windows
        windows.last?.hideToast()
        
        if arrSelectedAirCartID.count == 0
        {
            self.view.makeToast("Please Select Any Jet or No Data Found")
        }
        else
        {
            let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
            let vc = mainStoryboard.instantiateViewController(withIdentifier: "PopUpRequestVC") as! PopUpRequestVC
            vc.strRquestPass = self.strPassenger
            vc.strRequestType = self.strTripType
            vc.strFightID = self.arrSelectedAirCartID
            vc.strCount = self.lblFightCount.text ?? ""
            vc.strDepartureDate = self.strDepartureDate
            vc.strDepartureTime = self.strDepartureTime
            vc.strReturnDate = self.strReturnDate
            vc.strReturnTime = self.strReturnTime
            vc.departingFrom_ID = self.strFrom
            vc.departingTo_ID = self.strTo
            vc.strPrice = self.arrSelectedPriceID
            let navController = UINavigationController(rootViewController: vc)
            navController.navigationBar.isHidden = true
            navController.modalPresentationStyle = .overFullScreen
            navController.modalTransitionStyle = .crossDissolve
            self.present(navController, animated: true, completion: nil)
        }
        
    }
    
    
    // MARK: - Tabbar Action
    
    @IBAction func clciekdTabHome(_ sender: Any) {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func clicekdTabMyBooking(_ sender: Any) {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "MyIntenariesVC") as! MyIntenariesVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func clicekdTabEmpty(_ sender: Any) {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "EmptyLegsVC") as! EmptyLegsVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func clickedTabprofile(_ sender: Any) {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func clickedCon(_ sender: Any) {
    }
    
    @IBAction func clickedCancel(_ sender: Any) {
    }
    
    
    func callAddFlightAPI()
    {
        self.view.hideToast()
        let windows = UIApplication.shared.windows
        windows.last?.hideToast()
        
        //  APIClient.sharedInstance.showIndicator()
        
        var param = ["":""]
        
        if strTripType == "oneway"
        {
            param = ["userid":appDelegate.dicCurrentUserData.id ?? "","departing_from":self.strFrom,"departing_to":self.strTo,"departure_time":self.strDepartureTime,"departure_date":self.strDepartureDate,"passenger":self.strPassenger,"aircraft_id":appDelegate.strAirCraftType,"trip_type":self.strTripType]
        }
        else
        {
            param = ["userid":appDelegate.dicCurrentUserData.id ?? "","departing_from":self.strFrom,"departing_to":self.strTo,"departure_date":self.strDepartureDate,"departure_time":self.strDepartureTime,"passenger":strPassenger,"aircraft_id":appDelegate.strAirCraftType,"trip_type":self.strTripType,"return_date":self.strReturnDate,"return_time":self.strReturnTime]
        }
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithOutHeaderPost(SEARCH_NEW_FLIGHT, parameters: param) { response, error, statusCode in
            
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
                        let arrData = response?.value(forKey: "data") as? NSArray
                        
                        for obj in arrData!
                        {
                            let dicData = JBAddFightListData(fromDictionary: obj as! NSDictionary)
                            self.arrAddFightList.append(dicData)
                            
                            self.view.makeToast(msg)
                            let windows = UIApplication.shared.windows
                            windows.last?.makeToast(msg)
                            
                        }
                        self.tblViewFlightDetail.reloadData()
                    }
                    else
                    {
                        self.view.makeToast(msg)
                        let windows = UIApplication.shared.windows
                        windows.last?.makeToast(msg)
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
    
}
extension AirCraftVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrAddFightList.count
    }
    
    func convertMinutesToHoursMinutes(minutes: Int) -> (hours: Int, minutes: Int) {
        let hours = minutes / 60
        let remainingMinutes = minutes % 60
        return (hours, remainingMinutes)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblViewFlightDetail.dequeueReusableCell(withIdentifier: "FlightDetailTblViewCell") as! FlightDetailTblViewCell
        
        
        let dicData = arrAddFightList[indexPath.row]
        
        let totalMinutes = Int(dicData.duration ?? 0)
        
        let (hours, minutes) = convertMinutesToHoursMinutes(minutes: totalMinutes ?? 0)
        
        cell.lblFlightDuration.text = "Duration: \(hours) hour \(minutes) minutes"
        
        cell.lblDePrice.text = "€\(dicData.price ?? 0)"
        cell.lblRePrice.text = "€\(dicData.price ?? 0)"
        
        cell.lblFlightName.text = dicData.title ?? ""
        
        cell.lblDeFrom.text = self.De_From_airportCode
        cell.lblDeT.text = self.self.De_To_airportCode
        
        cell.lblReFrom.text = self.De_To_airportCode
        cell.lblReTo.text = self.self.De_From_airportCode
        
        if self.strTripType == "round"
        {
            cell.lblReFrom.isHidden = false
            cell.lblReTo.isHidden = false
            cell.lblRePrice.isHidden = false
            cell.imgReSrrow.isHidden = false
        }
        else
        {
            cell.lblReFrom.isHidden = true
            cell.lblReTo.isHidden = true
            cell.lblRePrice.isHidden = true
            cell.imgReSrrow.isHidden = true
        }
        
        if arrSelectedAirCartID.contains(dicData.id ?? "")
        {
            cell.btnSelect.backgroundColor = UIColor.black
            cell.btnSelect.setTitleColor(UIColor(red: 236/255, green: 236/255, blue: 236/255, alpha: 1), for: .normal)
        }
        else
        {
            cell.btnSelect.backgroundColor = UIColor(red: 236/255, green: 236/255, blue: 236/255, alpha: 1)
            cell.btnSelect.setTitleColor(UIColor.black, for: .normal)
        }
        
        cell.btnSelect.tag = indexPath.row
        cell.btnSelect.addTarget(self, action: #selector(clickedSelect(_:)), for: .touchUpInside)
        
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
    
    @objc func clickedSelect(_ sender: UIButton)
    {
        let dicData = arrAddFightList[sender.tag]
        
        if arrSelectedAirCartID.contains(dicData.id ?? "")
        {
            arrSelectedAirCartID.remove(dicData.id ?? "")
            arrSelectedPriceID.remove(dicData.price ?? 0)
        }
        else
        {
            arrSelectedAirCartID.add(dicData.id ?? "")
            arrSelectedPriceID.add(dicData.price ?? 0)
        }
        
        self.lblFightCount.text = "\(self.arrSelectedAirCartID.count ?? 0)"
        
        self.tblViewFlightDetail.reloadData()
    }
    
    
}
class FlightDetailTblViewCell: UITableViewCell
{
    @IBOutlet weak var imgFlight: UIImageView!
    @IBOutlet weak var lblFlightName: UILabel!
    @IBOutlet weak var lblFlightDuration: UILabel!
    @IBOutlet weak var btnLearnMore: UIButton!
    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var lblDeFrom: UILabel!
    @IBOutlet weak var lblDeT: UILabel!
    @IBOutlet weak var lblDePrice: UILabel!
    
    
    
    @IBOutlet weak var lblReFrom: UILabel!
    @IBOutlet weak var imgReSrrow: UIImageView!
    @IBOutlet weak var lblReTo: UILabel!
    @IBOutlet weak var lblRePrice: UILabel!
    
    
}
