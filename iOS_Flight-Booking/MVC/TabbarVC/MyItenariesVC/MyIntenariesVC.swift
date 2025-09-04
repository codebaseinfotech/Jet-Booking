//
//  MyIntenariesVC.swift
//  iOS_Flight-Booking
//
//  Created by Code on 15/02/23.
//

import UIKit

class MyIntenariesVC: UIViewController {

    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var viewUpcoming: UIView!
    @IBOutlet weak var lblUpComing: UILabel!
    @IBOutlet weak var viewPast: UIView!
    @IBOutlet weak var lblPast: UILabel!
    @IBOutlet weak var tblViewUpcoming: UITableView!
    @IBOutlet weak var tblViewPast: UITableView!
    @IBOutlet weak var viewTabbar: UIView!
    @IBOutlet weak var viewNoEvent: UIView!
    
    var arrUpCommingItenarieList: [JBItenariesListData] = [JBItenariesListData]()
    
    var arrPastItenarieList: [JBItenariesListData] = [JBItenariesListData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewNoEvent.isHidden = true
        
        viewTop.layer.applySketchShadow(color: .black,alpha: 0.08,x: 0,y: 0,blur: 18,spread: 0)
        
        viewTop.layer.cornerRadius = 20
        viewTop.layer.maskedCorners = [.layerMinXMaxYCorner, . layerMaxXMaxYCorner] // Bottom Corner
        
        tblViewUpcoming.delegate = self
        tblViewUpcoming.dataSource = self
        
        tblViewPast.delegate = self
        tblViewPast.dataSource = self
        
        tblViewUpcoming.register(UINib(nibName: "MyItenariesTblViewCell", bundle: nil), forCellReuseIdentifier: "MyItenariesTblViewCell")
        
        tblViewPast.register(UINib(nibName: "MyItenariesTblViewCell", bundle: nil), forCellReuseIdentifier: "MyItenariesTblViewCell")
        
        viewTabbar.clipsToBounds = true
        viewTabbar.layer.cornerRadius = 20
        viewTabbar.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top Corner
        
        viewTabbar.layer.applySketchShadow(color: .black, alpha: 0.11, x: 0, y: 0, blur: 15, spread: 0)
        
        viewUpcoming.backgroundColor = APP_BLACK
        viewPast.backgroundColor = APP_CREAM
        lblUpComing.textColor = .white
        lblPast.textColor = .black
        tblViewUpcoming.isHidden = false
        tblViewPast.isHidden = true
        callUpcommingIAPI()
        
    }
    
    @IBAction func clickedBack(_ sender: Any) {
        AppUtilites.showAlert(title: "Are you sure want to exit?", message: "", actionButtonTitle: "Yes", cancelButtonTitle: "No") {
            if let controller = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC {
                
                let viewcontrollers = self.navigationController?.viewControllers
                var isExist = false
                for viewcontroller in viewcontrollers! {
                    if viewcontroller.isKind(of: HomeVC.self) {
                        isExist = true
                        break
                    }
                }
                if isExist == true {
                    self.navigationController?.popViewController(animated: false)
                } else {
                    self.navigationController?.viewControllers.insert(controller, at: (viewcontrollers?.count)!)
                    appDelegate.setUpHome()
                }
            }
        }
    }
    
    @IBAction func clickedUpcoming(_ sender: Any) {
        viewUpcoming.backgroundColor = APP_BLACK
        viewPast.backgroundColor = APP_CREAM
        lblUpComing.textColor = .white
        lblPast.textColor = .black
        tblViewUpcoming.isHidden = false
        tblViewPast.isHidden = true
        callUpcommingIAPI()
    }
    
    @IBAction func clickedPast(_ sender: Any) {
        viewUpcoming.backgroundColor = APP_CREAM
        viewPast.backgroundColor = APP_BLACK
        lblUpComing.textColor = .black
        lblPast.textColor = .white
        tblViewUpcoming.isHidden = true
        tblViewPast.isHidden = false
        callPastIAPI()
    }
    
    // MARK: - Tab Action
    
    @IBAction func clickedTabHome(_ sender: Any) {
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
    
    // MARK: - Call API
    
    func callUpcommingIAPI()
    {
        self.view.hideToast()
        let windows = UIApplication.shared.windows
        windows.last?.hideToast()
        
        let param = ["userid":appDelegate.dicCurrentUserData.id ?? ""]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithOutHeaderPost(UPACOMMING_ITEARIES, parameters: param) { response, error, statusCode in
            
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
                        self.arrUpCommingItenarieList.removeAll()
                        for obj in arrData!
                        {
                            let dicData = JBItenariesListData(fromDictionary: obj as! NSDictionary)
                            self.arrUpCommingItenarieList.append(dicData)
                        }
                        if self.arrUpCommingItenarieList.count > 0
                        {
                            self.tblViewUpcoming.isHidden = false
                            self.viewNoEvent.isHidden = true
                        }
                        else
                        {
                            self.tblViewUpcoming.isHidden = true
                            self.viewNoEvent.isHidden = false
                        }
                        
                        self.arrUpCommingItenarieList = self.arrUpCommingItenarieList.reversed()
                        
                        self.tblViewUpcoming.reloadData()
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
    
    func callPastIAPI()
    {
        
        let param = ["userid":appDelegate.dicCurrentUserData.id ?? ""]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithOutHeaderPost(PAST_ITEARIES, parameters: param) { response, error, statusCode in
            
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
                        self.arrPastItenarieList.removeAll()
                        for obj in arrData!
                        {
                            let dicData = JBItenariesListData(fromDictionary: obj as! NSDictionary)
                            self.arrPastItenarieList.append(dicData)
                        }
                        if self.arrPastItenarieList.count > 0
                        {
                            self.tblViewPast.isHidden = false
                            self.viewNoEvent.isHidden = true
                        }
                        else
                        {
                            self.tblViewPast.isHidden = true
                            self.viewNoEvent.isHidden = false
                        }
                        
                        
                        self.arrPastItenarieList = self.arrPastItenarieList.reversed()

                        
                        self.tblViewPast.reloadData()
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

extension MyIntenariesVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblViewUpcoming
        {
            return arrUpCommingItenarieList.count
        }
        else
        {
            return arrPastItenarieList.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tblViewUpcoming
        {
            let cell = self.tblViewUpcoming.dequeueReusableCell(withIdentifier: "MyItenariesTblViewCell") as! MyItenariesTblViewCell
            cell.selectionStyle = .none
            
            let dicData = arrUpCommingItenarieList[indexPath.row]
            
            cell.lblStartCity.text = dicData.departing ?? ""
            cell.lblEndCity.text = dicData.arrival ?? ""
            
            return cell
        }
        else
        {
            let cell = self.tblViewPast.dequeueReusableCell(withIdentifier: "MyItenariesTblViewCell") as! MyItenariesTblViewCell
            cell.selectionStyle = .none
            
            let dicData = arrPastItenarieList[indexPath.row]
            
            cell.lblStartCity.text = dicData.departing ?? ""
            cell.lblEndCity.text = dicData.arrival ?? ""

            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tblViewUpcoming
        {
            let dicData = arrUpCommingItenarieList[indexPath.row]
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyQuoteVC") as! MyQuoteVC
            vc.strDF = dicData.departingFrom ?? ""
            vc.strDT = dicData.departingTo ?? ""
            vc.strDD = dicData.departureDate ?? ""
            vc.strUID = dicData.userid ?? ""
            vc.isFromMyBooking = true
            vc.isFromUpcoming = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else
        {
            let dicData = arrPastItenarieList[indexPath.row]
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyQuoteVC") as! MyQuoteVC
            vc.strDF = dicData.departingFrom ?? ""
            vc.strDT = dicData.departingTo ?? ""
            vc.strDD = dicData.departureDate ?? ""
            vc.strUID = dicData.userid ?? ""
            vc.isFromMyBooking = true
            vc.isFromUpcoming = false
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
