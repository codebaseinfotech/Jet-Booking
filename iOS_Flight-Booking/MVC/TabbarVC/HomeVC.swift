//
//  HomeVC.swift
//  iOS_Flight-Booking
//
//  Created by Code on 13/02/23.
//

import UIKit
import LGSideMenuController
import Kingfisher
import SwiftGifOrigin


class HomeVC: UIViewController {
    
    @IBOutlet weak var pagecontrll: UIPageControl!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var collectionViewSlider: UICollectionView!
    @IBOutlet weak var collectionViewCategory: UICollectionView!
    @IBOutlet weak var viewTabbar: UIView!
    @IBOutlet weak var imgProfile: UIImageView!
    
    let sectionInsetsSlider = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    let itemsPerRowSlider: CGFloat = 1
    
    var flowLayoutSlider: UICollectionViewFlowLayout {
        let _flowLayoutSlider = UICollectionViewFlowLayout()
        
        DispatchQueue.main.async {
            let paddingSpace = self.sectionInsetsSlider.left * (self.itemsPerRowSlider + 1)
            let availableWidth = self.view.frame.width - paddingSpace
            let widthPerItem = availableWidth / self.itemsPerRowSlider
            
            _flowLayoutSlider.itemSize = CGSize(width: widthPerItem, height: 173)
            
            _flowLayoutSlider.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
            _flowLayoutSlider.scrollDirection = UICollectionView.ScrollDirection.horizontal
            _flowLayoutSlider.minimumInteritemSpacing = 10
            _flowLayoutSlider.minimumLineSpacing = 10
            
        }
        
        // edit properties here
        return _flowLayoutSlider
    }
    
    let sectionInsetsCat = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
    let itemsPerRowCat: CGFloat = 2
    
    var flowLayoutCat: UICollectionViewFlowLayout {
        let _flowLayoutCat = UICollectionViewFlowLayout()
        
        DispatchQueue.main.async {
            let paddingSpace = self.sectionInsetsCat.left * (self.itemsPerRowCat + 1)
            let availableWidth = self.view.frame.width - paddingSpace
            let widthPerItem = availableWidth / self.itemsPerRowCat
            
            _flowLayoutCat.itemSize = CGSize(width: widthPerItem, height: 143)
            
            _flowLayoutCat.sectionInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
            _flowLayoutCat.scrollDirection = UICollectionView.ScrollDirection.vertical
            _flowLayoutCat.minimumInteritemSpacing = 10
            _flowLayoutCat.minimumLineSpacing = 17
            
        }
        
        // edit properties here
        return _flowLayoutCat
    }
    
    var arrSliderImg = ["FlyEliteJets Cessna Citation XLS+","FlyEliteJets XLS2"]
    
    var arrSliderName = ["Booking and take\noff from 90 minutes!","FlyEliteJets worldwide"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewSlider.delegate = self
        collectionViewSlider.dataSource = self
        collectionViewSlider.collectionViewLayout = flowLayoutSlider
        
        DispatchQueue.main.async {
            self.collectionViewCategory.delegate = self
            self.collectionViewCategory.dataSource = self
            self.collectionViewCategory.collectionViewLayout = self.flowLayoutCat
        }
        
        
        viewTabbar.clipsToBounds = true
        viewTabbar.layer.cornerRadius = 20
        viewTabbar.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top Corner
        
        viewTabbar.layer.applySketchShadow(color: .black, alpha: 0.11, x: 0, y: 0, blur: 15, spread: 0)
        
        pagecontrll.numberOfPages = 2
        
        collectionViewSlider.tag = 7
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        callUserProfileAPI()
    }
    
    @IBAction func clickedMenu(_ sender: Any) {
        self.sideMenuController?.showLeftView(animated: true, completion: nil)
    }
    @IBAction func clickedNoti(_ sender: Any) {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func clickedProfile(_ sender: Any) {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func clickedSearch(_ sender: Any) {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "FlightSearchVC") as! FlightSearchVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    // MARK: - Tabbar Action
    
    @IBAction func clickedTabMyBooking(_ sender: Any) {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "MyIntenariesVC") as! MyIntenariesVC
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
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if let collectionView = scrollView as? UICollectionView {
            switch collectionView.tag {
            case 7:
                let currentPage = scrollView.contentOffset.x / scrollView.frame.size.height;
                pagecontrll.currentPage = Int(currentPage)
            default:
                print("unknown")
            }
        } else{
            print("cant cast")
        }
    }
    
    func callUserProfileAPI()
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["userid":appDelegate.dicCurrentUserData.id ?? ""]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithOutHeaderPost(USER_PROFILE, parameters: param) { response, error, statusCode in
            
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
                        let dicData = response?.value(forKey: "data") as! NSDictionary
                        
                        self.imgProfile.kf.setImage(
                            with: URL(string: (dicData.value(forKey: "image_url") as! String) ),
                            placeholder: UIImage(named: "Profile Place"),
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
                    }
                    else
                    {
                        APIClient.sharedInstance.hideIndicator()
                    }
                }
            }
        }
    }
    
}
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewSlider
        {
            return arrSliderImg.count
        }
        else
        {
            return 4
           
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewSlider
        {
            let cell = self.collectionViewSlider.dequeueReusableCell(withReuseIdentifier: "SliderCollViewCell", for: indexPath) as! SliderCollViewCell
            
            cell.imgPic.image = UIImage(named: arrSliderImg[indexPath.row])
            
            cell.lblFlightDetail.text = arrSliderName[indexPath.row]
            
            cell.btnRequestNow.tag = indexPath.row
            cell.btnRequestNow.addTarget(self, action: #selector(clickedReq(_ :)), for: .touchUpInside)
            
            return cell
        }
        else
        {
            let cell = self.collectionViewCategory.dequeueReusableCell(withReuseIdentifier: "CategoryCollViewCell", for: indexPath) as! CategoryCollViewCell
            
            if indexPath.row == 0
            {
                cell.imgCategory.loadGif(name: "Request-Quote-unscreen")
                cell.lblCategoryType.text = "Request a  Flight"
            }
            else if indexPath.row == 1
            {
                cell.imgCategory.loadGif(name: "My-Itenaries-unscreen")
                cell.lblCategoryType.text = "My Itineraries"
            }
            else if indexPath.row == 2
            {
                cell.imgCategory.loadGif(name: "Empty-Legs-unscreen (1)")
                cell.lblCategoryType.text = "Empty Legs"
            }
            else if indexPath.row == 3
            {
                cell.imgCategory.loadGif(name: "Flyl-Elite-Info-unscreen")
                cell.lblCategoryType.text = "FlyElite Info"
            }
            
            return cell
        }
    }
    
    @objc func clickedReq(_ sender: UIButton)
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FlightSearchVC") as! FlightSearchVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == collectionViewSlider
        {
            
        }
        else
        {
            if indexPath.row == 0
            {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "FlightSearchVC") as! FlightSearchVC
                self.navigationController?.pushViewController(vc, animated: false)
            }
            if indexPath.row == 1
            {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyIntenariesVC") as! MyIntenariesVC
                self.navigationController?.pushViewController(vc, animated: false)
            }
            if indexPath.row == 2
            {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "EmptyLegsVC") as! EmptyLegsVC
                self.navigationController?.pushViewController(vc, animated: false)
            }
            if indexPath.row == 3
            {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
        
    }
    
}

class SliderCollViewCell: UICollectionViewCell{
    @IBOutlet weak var lblFlightDetail: UILabel!
    @IBOutlet weak var btnRequestNow: UIButton!
    
    @IBOutlet weak var imgPic: UIImageView!
}

class CategoryCollViewCell: UICollectionViewCell{
    @IBOutlet weak var lblCategoryType: UILabel!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var imgCategory: UIImageView!
}
