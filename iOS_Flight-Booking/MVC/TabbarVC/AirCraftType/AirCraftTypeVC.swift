//
//  AirCraftTypeVC.swift
//  iOS_Flight-Booking
//
//  Created by Code on 15/02/23.
//

import UIKit

class AirCraftTypeVC: UIViewController {

    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var tblViewSelectAirCraft: UITableView!
    
    var arrAirCraftListMain: [JBAirCraftListData] = [JBAirCraftListData]()

    var selectedAllJetSection = false
    var selectedAllOtherSection = false

    var arrJetsSelectedID = NSMutableArray()
    var arrOtherSelectedID = NSMutableArray()
    
    var arrJetsSelectedName = NSMutableArray()
    var arrOtherSelectedName = NSMutableArray()
    
    var delagate: AirCraftTypeDelegate?
    
    var selectecIndex = -1
    
    var strFrom = ""
    var strTo = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewMain.clipsToBounds = true
        viewMain.layer.cornerRadius = 50
        viewMain.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top Corner
        
        tblViewSelectAirCraft.delegate = self
        tblViewSelectAirCraft.dataSource = self

        callAirCraftTypeAPI()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickedSubmit(_ sender: Any) {
        
        for obj in arrOtherSelectedID
        {
            arrJetsSelectedID.add(obj)
        }
        
        for obj in arrOtherSelectedName
        {
            arrJetsSelectedName.add(obj)
        }
        
        appDelegate.strAirCraftType = arrJetsSelectedID.componentsJoined(by: ",")
        
        delagate?.onAirCraftType(name: arrJetsSelectedName.componentsJoined(by: ","), selectecIndex: self.selectecIndex)
        
        self.dismiss(animated: true)
    }
    
    @IBAction func cllickedClose(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func callAirCraftTypeAPI()
    {
        self.view.hideToast()
        let windows = UIApplication.shared.windows
        windows.last?.hideToast()
        
        APIClient.sharedInstance.showIndicator()
        
        let param = ["departing_from":self.strFrom,"departing_to":self.strTo]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithOutHeaderGet(AIRCRAFT_TYPE_LIST, parameters: param) { response, error, statusCode in
            
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
                        self.arrAirCraftListMain.removeAll()

                        for obj in arrData!
                        {
                            let dicData = JBAirCraftListData(fromDictionary: obj as! NSDictionary)
                            
                            self.arrAirCraftListMain.append(dicData)
                        }
                        
                        self.tblViewSelectAirCraft.reloadData()
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
extension AirCraftTypeVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrAirCraftListMain.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = self.tblViewSelectAirCraft.dequeueReusableCell(withIdentifier: "AirCraftTypeTblViewCell") as! AirCraftTypeTblViewCell
        
        let dicData = arrAirCraftListMain[indexPath.row]
        
        cell.lblType.text = "\(dicData.name ?? "") (Max \(dicData.seats ?? "") seats)"
        
        if selectecIndex == indexPath.row
        {
            cell.imgCheck.image = UIImage(named: "Check Mark")
            
            arrJetsSelectedID.add(dicData.id ?? "")
            arrJetsSelectedName.add("\(dicData.name ?? "") (Max \(dicData.seats ?? "") seats)")
        }
        else
        {
            cell.imgCheck.image = UIImage(named: "Tick Box")
            
            arrJetsSelectedID.remove(dicData.id ?? "")
            arrJetsSelectedName.remove("\(dicData.name ?? "") (Max \(dicData.seats ?? "") seats)")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("AirCraftHeaderView", owner: self, options: [:])?.first as! AirCraftHeaderView
        
        headerView.isHidden = true
      
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        selectecIndex = indexPath.row
        self.tblViewSelectAirCraft.reloadData()
    }
  
    
    
}
class AirCraftTypeTblViewCell: UITableViewCell{
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var imgCheck: UIImageView!
    
}
