//
//  NewEmptyLegsVC.swift
//  FLY ELITEJETS
//
//  Created by iMac on 09/09/25.
//

import UIKit

class NewEmptyLegsVC: UIViewController {
    
    @IBOutlet weak var lblDis: UILabel!
    @IBOutlet weak var lblFlightsCount: UILabel!
    
    @IBOutlet weak var tblViewFlightsList: UITableView!
    
    var flights: [FBEmptyLegsListResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblViewFlightsList.register(UINib(nibName: "NewEmptyLegsTblViewCell", bundle: nil), forCellReuseIdentifier: "NewEmptyLegsTblViewCell")
        tblViewFlightsList.dataSource = self
        tblViewFlightsList.delegate = self
        
        callEmptyLegsAviPagesAPI()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickedHome(_ sender: Any) {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func clickedMyBookings(_ sender: Any) {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "MyIntenariesVC") as! MyIntenariesVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func clickedProfile(_ sender: Any) {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func clickedBookNow(_ sender: Any) {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "BookYourFlightVC") as! BookYourFlightVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    
    //MARK: - callEmptyLegsAviPagesAPI()
    func callEmptyLegsAviPagesAPI() {
        APIClient.sharedInstance.showIndicator()
        
        let param: [String: Any] = [:] // If no params needed, keep empty
        
        APIClient.sharedInstance.MakeAPICallWithOutHeaderPostNew("https://appadmin.flyelitejets.com/api/user/getAvailabilities", parameters: param) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            APIClient.sharedInstance.hideIndicator()
            
            if error == nil {
                if statusCode == 200 {
                    let status = response?.value(forKey: "status") as? Bool ?? false
                    let msg = response?.value(forKey: "msg") as? String ?? ""
                    
                    if status {
                        if let dataDict = response?.value(forKey: "data") as? NSDictionary {
                            if let results = dataDict.value(forKey: "results") as? [NSDictionary] {
                                
                                let totalCount = dataDict.value(forKey: "count") as? Int ?? 0
                                
                                // Parse model
                                self.flights.removeAll()
                                for dict in results {
                                    let obj = FBEmptyLegsListResult(fromDictionary: dict)
                                    self.flights.append(obj)
                                }
                                
                                DispatchQueue.main.async {
                                    self.lblFlightsCount.text = "\(totalCount) flights"
                                    self.tblViewFlightsList.reloadData()
                                }
                            }
                        }
                    } else {
                        print("❌ API Failed:", msg)
                    }
                }
            } else {
                print("❌ Error:", error?.localizedDescription ?? "Unknown error")
            }
        }
    }
    
    func formatFlightDate(_ dateString: String?) -> String {
        guard let dateString = dateString, !dateString.isEmpty else { return "" }
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"  // <-- matches your API format
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        inputFormatter.timeZone = TimeZone(abbreviation: "UTC") // API is in UTC
        
        guard let date = inputFormatter.date(from: dateString) else {
            return dateString
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd MMM yyyy, HH:mm" // Example: "10 Sep 2025, 20:30"
        outputFormatter.locale = Locale(identifier: "en_US_POSIX")
        outputFormatter.timeZone = TimeZone.current // show in device's local time
        
        return outputFormatter.string(from: date)
    }
    
}

extension NewEmptyLegsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flights.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblViewFlightsList.dequeueReusableCell(withIdentifier: "NewEmptyLegsTblViewCell") as! NewEmptyLegsTblViewCell
        
        let flight = flights[indexPath.row]
        cell.lblJetType.text = flight.aircraftType ?? ""
        cell.lblTime.text = formatFlightDate(flight.fromDateUtc)
        cell.lblFromName.text = "\(flight.depAirport?.name ?? "") (\(flight.depAirport?.iata ?? ""))"
        cell.lblToName.text = "\(flight.arrAirport?.name ?? "") (\(flight.arrAirport?.iata ?? ""))"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
