//
//  FlightDetailVC.swift
//  iOS_Flight-Booking
//
//  Created by Code on 16/02/23.
//

import UIKit

class FlightDetailVC: UIViewController
{
    
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var tblViewDetail: UITableView!
    
    var dicFlightDetail = FBFlightDetailData()
    
    var strFlight_id = ""
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewTop.layer.applySketchShadow(color: .black,alpha: 0.08,x: 0,y: 0,blur: 18,spread: 0)
        
        viewTop.layer.cornerRadius = 20
        viewTop.layer.maskedCorners = [.layerMinXMaxYCorner, . layerMaxXMaxYCorner] // Bottom Corner
        
        tblViewDetail.delegate = self
        tblViewDetail.dataSource = self
        
        callFightDetailAPI(flight_id: strFlight_id)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func callFightDetailAPI(flight_id:String)
    {
        self.view.hideToast()
        let windows = UIApplication.shared.windows
        windows.last?.hideToast()
        
        let param = ["flight_id":flight_id]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithOutHeaderPost(FLIGHT_DETAILS, parameters: param) { response, error, statusCode in
            
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
                        let dic = response?.value(forKey: "data") as? NSDictionary
                        
                        let dicData = FBFlightDetailData(fromDictionary: dic!)
                        self.dicFlightDetail = dicData
                        
                        self.tblViewDetail.reloadData()
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
extension FlightDetailVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblViewDetail.dequeueReusableCell(withIdentifier: "PlaneDetailTblViewCell") as! PlaneDetailTblViewCell
        
//        cell.lblManufacturingYear.text = dicUpcomingItenaries.manufacturingYear ?? ""
//        cell.lblFlightServices.text = dicUpcomingItenaries.services ?? ""
        
        cell.planeType.text = self.dicFlightDetail.name ?? ""
        cell.lblDescription.text = dicFlightDetail.descriptionField ?? ""
        
        cell.planePhoto.kf.setImage(
            with: URL(string: self.dicFlightDetail.image ?? ""),
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
    
}

class PlaneDetailTblViewCell: UITableViewCell{
    @IBOutlet weak var planeType: UILabel!
    @IBOutlet weak var planePhoto: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblManufacturingYear: UILabel!
    @IBOutlet weak var lblFlightServices: UILabel!
}
