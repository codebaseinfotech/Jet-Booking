//
//  SearchVC.swift
//  Jet Booking
//
//  Created by iMac on 21/02/23.
//

import UIKit

protocol LocationListingScreenDelegate {
    func reloadSearch(objPlaceData : JBSearchFightListData)
}

class SearchVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var tblViewSearch: UITableView!
    @IBOutlet weak var txtSearch: UITextField!
    
    var arrSearchList: [JBSearchFightListData] = [JBSearchFightListData]()
    
    var arrRecentData: [JBSearchFightListData] = [JBSearchFightListData]()
    
    var delegateAddress: LocationListingScreenDelegate?
    
    var isDEF = false
    var strFrom = ""
    
    var strTo = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // arrRecentData = getCurrentSearchData()
        
        for obj in getCurrentSearchData()
        {
            if isDEF == true
            {
                if obj.id != strTo
                {
                    arrRecentData.append(obj)
                }
            }
            else
            {
                if obj.id != strFrom
                {
                    arrRecentData.append(obj)
                }
            }
             
        }

        viewTop.layer.applySketchShadow(color: .black,alpha: 0.08,x: 0,y: 0,blur: 18,spread: 0)
        
       // viewTop.clipsToBounds = true
        viewTop.layer.cornerRadius = 20
        viewTop.layer.maskedCorners = [.layerMinXMaxYCorner, . layerMaxXMaxYCorner] // Bottom Corner
        
        tblViewSearch.delegate = self
        tblViewSearch.dataSource = self
        
        self.txtSearch.delegate = self
        self.txtSearch.addTarget(self, action: #selector(searchWorkersAsPerText(_ :)), for: .editingChanged)
        // Do any additional setup after loading the view.
    }
    
    @objc func searchWorkersAsPerText(_ textfield:UITextField)
    {
        if textfield.text?.count == 0
        {
            tblViewSearch.reloadData()
        }
        else
        {
            callSearchFightAPI()
        }
       
    }
    
    func saveCurrentSearchData(array: [JBSearchFightListData])
    {
        let data = NSKeyedArchiver.archivedData(withRootObject: array)
        UserDefaults.standard.setValue(data, forKey: "currentSearchData")
        UserDefaults.standard.synchronize()
    }
    
    func getCurrentSearchData() -> [JBSearchFightListData]
    {
        if let data = UserDefaults.standard.object(forKey: "currentSearchData"){
            
            let arrayObjc = NSKeyedUnarchiver.unarchiveObject(with: data as! Data)
            return arrayObjc as! [JBSearchFightListData]
        }
        return [JBSearchFightListData]()
    }
    
    @IBAction func clickedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func callSearchFightAPI()
    {
        self.view.hideToast()
        let windows = UIApplication.shared.windows
        windows.last?.hideToast()
        
        APIClient.sharedInstance.showIndicator()
        
        let param = ["search":self.txtSearch.text ?? ""]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithOutHeaderPost(SEARCH_FLIGHT, parameters: param) { response, error, statusCode in
            
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
                        self.arrSearchList.removeAll()
                        for obj in arrData!
                        {
                            let dicData = JBSearchFightListData(fromDictionary: obj as! NSDictionary)
                            
                            if self.isDEF == true
                            {
                                if dicData.id != self.strTo
                                {
                                    self.arrSearchList.append(dicData)
                                }
                            }
                            else
                            {
                                if dicData.id != self.strFrom
                                {
                                    self.arrSearchList.append(dicData)
                                }
                            }
                           
                        }
                        self.tblViewSearch.reloadData()
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

extension SearchVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if txtSearch.text == ""
        {
            return arrRecentData.count
        }
        else
        {
            return arrSearchList.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if txtSearch.text == ""
        {
            let cell = self.tblViewSearch.dequeueReusableCell(withIdentifier: "SearchTblCell") as! SearchTblCell
            
            cell.lblName.text = arrRecentData[indexPath.row].location ?? ""
            cell.lblSName.text = arrRecentData[indexPath.row].airportCode ?? ""
            cell.lblDes.text = arrRecentData[indexPath.row].airportName ?? ""

            return cell
        }
        else
        {
            let cell = self.tblViewSearch.dequeueReusableCell(withIdentifier: "SearchTblCell") as! SearchTblCell
            
            let dicData = arrSearchList[indexPath.row]
            
            cell.lblName.text = dicData.location ?? ""
            cell.lblSName.text = dicData.airportCode ?? ""
            cell.lblDes.text = dicData.airportName ?? ""
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if txtSearch.text == ""
        {
            txtSearch.text = arrRecentData[indexPath.row].airportName ?? ""
           
            self.delegateAddress?.reloadSearch(objPlaceData: arrRecentData[indexPath.row])
            self.navigationController?.popViewController(animated: true)

        }
        else
        {
            let dicData = arrSearchList[indexPath.row]
            
            var arrSearch = getCurrentSearchData()
            arrSearch.append(dicData)
            saveCurrentSearchData(array: arrSearch)
            
            self.delegateAddress?.reloadSearch(objPlaceData: dicData)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}

class SearchTblCell: UITableViewCell
{
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDes: UILabel!
    @IBOutlet weak var lblSName: UILabel!
}
