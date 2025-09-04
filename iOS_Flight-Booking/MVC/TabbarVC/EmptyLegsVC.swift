//
//  EmptyLegsVC.swift
//  iOS_Flight-Booking
//
//  Created by Code on 16/02/23.
//

import UIKit

class EmptyLegsVC: UIViewController {

    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var tblViewEmotyLegs: UITableView!
    @IBOutlet weak var viewTab: UIView!
    @IBOutlet weak var viewNoEvent: UIView!
    
    var arrEmptyLeg: [JBEmptyLegData] = [JBEmptyLegData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewTop.layer.applySketchShadow(color: .black,alpha: 0.08,x: 0,y: 0,blur: 18,spread: 0)
        
        viewTop.layer.cornerRadius = 20
        viewTop.layer.maskedCorners = [.layerMinXMaxYCorner, . layerMaxXMaxYCorner] // Bottom Corner
        
        tblViewEmotyLegs.delegate = self
        tblViewEmotyLegs.dataSource = self

        viewTab.clipsToBounds = true
        viewTab.layer.cornerRadius = 20
        viewTab.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top Corner
        
        viewTab.layer.applySketchShadow(color: .black, alpha: 0.11, x: 0, y: 0, blur: 15, spread: 0)
        
        callEmptyLegAPI()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickedBack(_ sender: Any) {
        AppUtilites.showAlert(title: "Are you sure want to exit?", message: "", actionButtonTitle: "Yes", cancelButtonTitle: "No") {
            appDelegate.setUpHome()
        }
    }
    
    // MARK: - TabbarAction
    
    @IBAction func clickedTabHome(_ sender: Any) {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func clickedTabMyBooking(_ sender: Any) {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "MyIntenariesVC") as! MyIntenariesVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func clickedTabProfile(_ sender: Any) {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    // MARK: - call API
    
    func callEmptyLegAPI()
    {
        self.view.hideToast()
        let windows = UIApplication.shared.windows
        windows.last?.hideToast()
        
        APIClient.sharedInstance.showIndicator()
        
        let param = ["":""]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithOutHeaderGet(EMPTY_LEGS, parameters: param) { response, error, statusCode in
            
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
                            let dicData = JBEmptyLegData(fromDictionary: obj as! NSDictionary)
                            self.arrEmptyLeg.append(dicData)
                        }
                        if self.arrEmptyLeg.count > 0
                        {
                            self.tblViewEmotyLegs.isHidden = false
                            self.viewNoEvent.isHidden = true
                        }
                        else
                        {
                            self.tblViewEmotyLegs.isHidden = true
                            self.viewNoEvent.isHidden = false
                        }
                        self.tblViewEmotyLegs.reloadData()
                    }
                    else
                    {
                        self.view.makeToast(msg)
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
extension EmptyLegsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrEmptyLeg.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblViewEmotyLegs.dequeueReusableCell(withIdentifier: "EmptyLegsTblViewCell") as! EmptyLegsTblViewCell
        
        let dicData = arrEmptyLeg[indexPath.row]
        
        cell.lblFrom.text = dicData.departingFrom ?? ""
        cell.lblTo.text = dicData.departingTo ?? ""
        cell.lblDuration.text = "Duration: \(dicData.duration ?? "")"
        cell.lblDate.text = dicData.departureDate ?? ""
        cell.lblCityCountryFrom.text = dicData.departingFromAddress ?? ""
        cell.lblCityCountyTo.text = dicData.departingToAddress ?? ""
        
        cell.lblSeatCount.text = dicData.seats ?? ""
        
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

        if let bidAccepted = dicData.departureTime
        {
            if bidAccepted != ""
            {
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "en_US")
                formatter.dateFormat = "HH:mm"
                let date1 = formatter.date(from: bidAccepted)
                let Dform = DateFormatter()
                Dform.dateFormat = "hh:mm a"
                let strDate = Dform.string(from: date1!)
                cell.lblTime.text = strDate
            }
        }
        
        cell.btnRequestQuote.tag = indexPath.row
        cell.btnRequestQuote.addTarget(self, action: #selector(clickedSelect(_ :)), for: .touchUpInside)
        
        
        
        return cell
    }
    
    @objc func clickedSelect(_ sender: UIButton)
    {
        let dicData = arrEmptyLeg[sender.tag]
        
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "PopUpRequestVC") as! PopUpRequestVC
        vc.strRquestPass = dicData.passenger ?? ""
        vc.strRequestType = "oneway"
        vc.strFightID = ["\(dicData.id ?? "")"]
        let navController = UINavigationController(rootViewController: vc)
        navController.navigationBar.isHidden = true
        navController.modalPresentationStyle = .overFullScreen
        navController.modalTransitionStyle = .crossDissolve
        self.present(navController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "FlightDetailVC") as! FlightDetailVC
        vc.strFlight_id =  arrEmptyLeg[indexPath.row].id ?? ""
        self.navigationController?.pushViewController(vc, animated: false)
    }
        
}

class EmptyLegsTblViewCell: UITableViewCell{
    @IBOutlet weak var lblFrom: UILabel!
    @IBOutlet weak var lblTo: UILabel!
    @IBOutlet weak var lblCityCountryFrom: UILabel!
    @IBOutlet weak var lblCityCountyTo: UILabel!
    @IBOutlet weak var lblFlightName: UILabel!
    @IBOutlet weak var imgFlight: UIImageView!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblSeatCount: UILabel!
    @IBOutlet weak var btnRequestQuote: UIButton!
}
