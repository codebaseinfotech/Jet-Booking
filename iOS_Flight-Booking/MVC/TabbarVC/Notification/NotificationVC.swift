//
//  NotificationVC.swift
//  iOS_Flight-Booking
//
//  Created by Code on 16/02/23.
//

import UIKit

class NotificationVC: UIViewController
{

    @IBOutlet weak var tblViewNotification: UITableView!
    @IBOutlet weak var viewTop: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewTop.layer.applySketchShadow(color: .black,alpha: 0.08,x: 0,y: 0,blur: 18,spread: 0)
        
        viewTop.layer.cornerRadius = 20
        viewTop.layer.maskedCorners = [.layerMinXMaxYCorner, . layerMaxXMaxYCorner] // Bottom Corner
        
        tblViewNotification.delegate = self
        tblViewNotification.dataSource = self
         // Do any additional setup after loading the view.
    }
    
    @IBAction func clickedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clicekdTabHome(_ sender: Any) {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func clickedTabMyBoooking(_ sender: Any) {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "MyIntenariesVC") as! MyIntenariesVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func clickedTabEmpty(_ sender: Any) {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "EmptyLegsVC") as! EmptyLegsVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func clciekdTabProfile(_ sender: Any) {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
}
extension NotificationVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblViewNotification.dequeueReusableCell(withIdentifier: "NotificationTblViewCell") as! NotificationTblViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("HeaderForNotification", owner: self, options: [:])?.first as! HeaderForNotification
        
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5
    }
    
    
}
class NotificationTblViewCell: UITableViewCell{
    @IBOutlet weak var lblNotification: UILabel!
    @IBOutlet weak var lblTimeAgo: UILabel!
    
}
