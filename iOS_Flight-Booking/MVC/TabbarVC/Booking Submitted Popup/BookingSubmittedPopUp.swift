//
//  BookingSubmittedPopUp.swift
//  FLY ELITEJETS
//
//  Created by iMac on 10/09/25.
//

import UIKit

class BookingSubmittedPopUp: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickedDone(_ sender: Any) {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "NewEmptyLegsVC") as! NewEmptyLegsVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    

}
