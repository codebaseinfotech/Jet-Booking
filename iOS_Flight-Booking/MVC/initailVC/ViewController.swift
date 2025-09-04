//
//  ViewController.swift
//  iOS_Flight-Booking
//
//  Created by macOS on 03/02/23.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var arrImg = ["GLOBAL-6000-CABIN 1","FlyEliteJets-Bombardier-Global-Express-and-Rolls-Royce 1","GLOBAL-6000-CABIN 1 (1)","FlyEliteJets_1158458608 1","STEWARDESS CHAMPAGNE 1"]
    var arrlbl = ["Fly Elite Jets","Limo to Jet \nService","Award Winning \nInflight Service","Sit Back, Relax & Fly \nthe Elite, FlyElite Jets","FlyEliteJets worldwide in \nsafety and comfort"]
    var arrname = ["The Award Winning \nPrivate Jet Co.","","","","Elite service from the award \nwinning private jet co."]
    
    @IBOutlet weak var ViewCollection: UICollectionView!
    @IBOutlet weak var NextView: UIView!
    @IBOutlet weak var PageControl: UIPageControl!
    let sectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    let itemsPerRow: CGFloat = 1
    var flowLayout: UICollectionViewFlowLayout {
        let _flowLayout = UICollectionViewFlowLayout()
        
        DispatchQueue.main.async {
            
            let paddingSpace = self.sectionInsets.left * (self.itemsPerRow + 1)
            let availableWidth = self.ViewCollection.frame.width - paddingSpace
            let widthPerItem = availableWidth / self.itemsPerRow
            
            _flowLayout.itemSize = CGSize(width: self.ViewCollection.frame.width, height: self.ViewCollection.frame.height)
            
            _flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            _flowLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
            _flowLayout.minimumInteritemSpacing = 0
            _flowLayout.minimumLineSpacing = 0
        }
        return _flowLayout
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ViewCollection.tag = 7
        
        PageControl.numberOfPages = arrImg.count
        
        ViewCollection.delegate = self
        ViewCollection.dataSource = self
        ViewCollection.collectionViewLayout = flowLayout
        
        NextView.clipsToBounds = true
        NextView.layer.cornerRadius = self.NextView.frame.height / 2
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImg.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.ViewCollection.dequeueReusableCell(withReuseIdentifier: "introCollectionCell", for: indexPath) as! introCollectionCell
        
        if indexPath.row == 0
        {
            cell.MainImg.image = UIImage(named: arrImg[indexPath.row])
            cell.lblTitel.text = arrlbl[indexPath.row]
            cell.lblname.text = arrname[indexPath.row]
            cell.lblname.isHidden = false
        }
        else if indexPath.row == 4
        {
            cell.MainImg.image = UIImage(named: arrImg[indexPath.row])
            cell.lblTitel.text = arrlbl[indexPath.row]
            cell.lblname.text = arrname[indexPath.row]
            cell.lblname.isHidden = false
        }
        else
        {
            cell.MainImg.image = UIImage(named: arrImg[indexPath.row])
            cell.lblTitel.text = arrlbl[indexPath.row]
            cell.lblname.isHidden = true
        }
        
        
        cell.MainView.layer.cornerRadius = 25
        cell.MainView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top Corner
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if let collectionView = scrollView as? UICollectionView {
            switch collectionView.tag {
            case 7:
                let currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
                PageControl.currentPage = Int(currentPage)
            default:
                print("unknown")
            }
        } else{
            print("cant cast")
        }
    }
    
    
    @IBAction func clickedSkip(_ sender: Any) {
        UserDefaults.standard.setValue(true, forKey: "isFinishIntro")
        UserDefaults.standard.synchronize()
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "loginVC") as! loginVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func clickedNext(_ sender: Any) {
        scrollToPreviousOrNextCell(direction: "Next")
    }
    
    
    func scrollToPreviousOrNextCell(direction: String) {
        
        DispatchQueue.global(qos: .background).async {
            
            DispatchQueue.main.async {
                
                let firstIndex = 0
                let lastIndex = self.arrImg.count - 1
                
                let visibleIndices = self.ViewCollection.indexPathsForVisibleItems
                
                let nextIndex = visibleIndices[0].row + 1
                let previousIndex = visibleIndices[0].row - 1
                
                let nextIndexPath: IndexPath = IndexPath.init(item: nextIndex, section: 0)
                let previousIndexPath: IndexPath = IndexPath.init(item: previousIndex, section: 0)
                
                if direction == "Previous" {
                    if previousIndex < firstIndex {
                        
                    } else {
                        self.ViewCollection.scrollToItem(at: previousIndexPath, at: .centeredHorizontally, animated: true)
                    }
                } else if direction == "Next" {
                    
                    if nextIndex > lastIndex {
                        
                        UserDefaults.standard.setValue(true, forKey: "isFinishIntro")
                        UserDefaults.standard.synchronize()
                        
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "loginVC") as! loginVC
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    } else {
                        
                        self.ViewCollection.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
                    }
                }
            }
        }
    }
}

