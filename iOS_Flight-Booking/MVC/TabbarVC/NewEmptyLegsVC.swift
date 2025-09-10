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
    
    var currentPage = 1
    var isLoading = false
    var totalFlights = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblViewFlightsList.register(UINib(nibName: "NewEmptyLegsTblViewCell", bundle: nil), forCellReuseIdentifier: "NewEmptyLegsTblViewCell")
        tblViewFlightsList.dataSource = self
        tblViewFlightsList.delegate = self
        
        callEmptyLegsAviPagesAPI(page: currentPage)
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
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //MARK: - callEmptyLegsAviPagesAPI()
    func callEmptyLegsAviPagesAPI(page: Int) {
            guard !isLoading else { return } // prevent multiple requests
            isLoading = true
            
            APIClient.sharedInstance.showIndicator()
            
            // ✅ Current UTC time and +10 days
            let now = Date()
            let tenDaysLater = Calendar.current.date(byAdding: .day, value: 9, to: now)!
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm" // ✅ Matches API format
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone(abbreviation: "UTC") // UTC output
            
            let fromDateUTC = formatter.string(from: now)
            let toDateUTC = formatter.string(from: tenDaysLater)
            
            let param: [String: Any] = [
                "from_date_utc": fromDateUTC,
                "to_date_utc": toDateUTC,
                "page": "\(page)"
            ]
            
            print("PARAMS:", param)
            
            APIClient.sharedInstance.MakeAPICallWithOutHeaderPostNew(
                "https://appadmin.flyelitejets.com/api/user/getAvailabilities",
                parameters: param
            ) { response, error, statusCode in
                
                print("STATUS CODE \(String(describing: statusCode))")
                print("RESPONSE \(String(describing: response))")
                
                APIClient.sharedInstance.hideIndicator()
                self.isLoading = false
                
                if error == nil {
                    if statusCode == 200 {
                        let status = response?.value(forKey: "status") as? Bool ?? false
                        let msg = response?.value(forKey: "msg") as? String ?? ""
                        
                        if status {
                            if let dataDict = response?.value(forKey: "data") as? NSDictionary {
                                if let results = dataDict.value(forKey: "results") as? [NSDictionary] {
                                    
                                    let totalCount = dataDict.value(forKey: "count") as? Int ?? 0
                                    self.totalFlights = totalCount
                                    
                                    // Parse model
                                    if page == 1 {
                                        self.flights.removeAll()
                                    }
                                    
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
    
    // Pagination trigger
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height - 100 { // when reaching near bottom
            if !isLoading && flights.count < totalFlights {
                currentPage += 1
                callEmptyLegsAviPagesAPI(page: currentPage)
            }
        }
    }
}
