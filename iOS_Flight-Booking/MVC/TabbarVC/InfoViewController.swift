//
//  InfoViewController.swift
//  Fly Elitejets
//
//  Created by Ankit Gabani on 28/02/23.
//

import UIKit

class InfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var viewTop: UIView!
    
    var arrQue = ["How it works?","What are FlyEliteJets Empty Legs?"]
    
    var arrAns = ["To use the FlyElite Jets App please select\n\n1. Your desired flight route\n2. One way, return or multiple leg flights\n3. Dates of travel\n4. Number of passengers\n5. Preferred aircraft type.","FlyElite Jets empty legs are flights where aircraft are flying empty between airports and can be chartered at a significant discount.\n\nSearch the FlyElite Jets App for a full list of empty legs or search by your desired departure and arrival airports or dates."]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblView.delegate = self
        tblView.dataSource = self

        viewTop.layer.applySketchShadow(color: .black,alpha: 0.08,x: 0,y: 0,blur: 18,spread: 0)

        viewTop.layer.cornerRadius = 20
        viewTop.layer.maskedCorners = [.layerMinXMaxYCorner, . layerMaxXMaxYCorner] // Bottom Corner
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let cell = tblView.dequeueReusableCell(withIdentifier: "InfoTblViewCell") as! InfoTblViewCell
        
        cell.lblQue.text = arrQue[indexPath.row]
        cell.lblAns.text = arrAns[indexPath.row]

        if indexPath.row == 0
        {
            cell.lineView.isHidden = true
        }
        else
        {
            cell.lineView.isHidden = false
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    

    @IBAction func clickedBack(_ sender: Any) {
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
                self.navigationController?.popViewController(animated: true)
            } else {
                self.navigationController?.viewControllers.insert(controller, at: (viewcontrollers?.count)!)
                self.navigationController?.popToViewController(controller, animated: false)
            }
        }
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

class InfoTblViewCell: UITableViewCell{
    @IBOutlet weak var lblQue: UILabel!
    @IBOutlet weak var lblAns: UILabel!
    @IBOutlet weak var lineView: UIView!
    
}
