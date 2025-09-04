//
//  AppDelegate.swift
//  iOS_Flight-Booking
//
//  Created by macOS on 03/02/23.
//

import UIKit
import IQKeyboardManagerSwift
import LGSideMenuController
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var dicCurrentUserData = JBLoginUserData()
    
    var strAirCraftType = ""
    
    var isFromBackReq = false
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        sleep(1)
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        IQKeyboardManager.shared.enable = true
        
        
        try? isUpdateAvailable {[self] (update, error) in
            if let error = error {
                print(error)
            } else if update ?? false {
                // show alert
                
                DispatchQueue.main.async {
                    let alertMessage = "An update to the app is required to continue.\nPlease go to the app store and upgrade your application."

                    let alertController = UIAlertController(title: "You have new updates", message: alertMessage, preferredStyle: .alert)
     
                    let updateButton = UIAlertAction(title: "Update App", style: .default) { (action:UIAlertAction) in
                        guard let url = URL(string: "https://itunes.apple.com/app/id6468663680") else {
                            return
                        }
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        } else {
                            UIApplication.shared.openURL(url)
                        }
                    }

                    alertController.addAction(updateButton)
                    self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
                }
                
                
            }
        }
        
        if let isFinishIntro = UserDefaults.standard.value(forKey: "isFinishIntro") as? Bool
        {
            if isFinishIntro == true
            {
                let userLogin = UserDefaults.standard.value(forKey: "userLogin") as? Bool

                if userLogin == true
                {
                    dicCurrentUserData = getCurrentUserData()

                    setUpHome()
                }
                else
                {
                    setUpLogin()
                }
            }
            else
            {
                setUpLogin()
            }
        }
        else
        {
            let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let home: ViewController = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            let homeNavigation = UINavigationController(rootViewController: home)
            homeNavigation.navigationBar.isHidden = true
            self.window?.rootViewController = homeNavigation
            self.window?.makeKeyAndVisible()
        }
        
        return true
    }
    
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
        try? isUpdateAvailable {[self] (update, error) in
            if let error = error {
                print(error)
            } else if update ?? false {
                // show alert
                
                DispatchQueue.main.async {
                    let alertMessage = "An update to the app is required to continue.\nPlease go to the app store and upgrade your application."

                    let alertController = UIAlertController(title: "You have new updates", message: alertMessage, preferredStyle: .alert)
     
                    let updateButton = UIAlertAction(title: "Update App", style: .default) { (action:UIAlertAction) in
                        guard let url = URL(string: "https://itunes.apple.com/app/id6468663680") else {
                            return
                        }
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        } else {
                            UIApplication.shared.openURL(url)
                        }
                    }

                    alertController.addAction(updateButton)
                    self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
                }
                
                
            }
        }
    }
    
    func setUpHome()
    {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let home: HomeVC = mainStoryboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        let homeNavigation = UINavigationController(rootViewController: home)
        let leftViewController: SideBarVC = mainStoryboard.instantiateViewController(withIdentifier: "SideBarVC") as! SideBarVC
        let controller = LGSideMenuController.init(rootViewController: homeNavigation, leftViewController: leftViewController, rightViewController: nil)
        controller.leftViewWidth = home.view.frame.size.width - 70
        homeNavigation.navigationBar.isHidden = true
        self.window?.rootViewController = controller
        self.window?.makeKeyAndVisible()
    }
    
    func setUpLogin()
    {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let home: loginVC = mainStoryboard.instantiateViewController(withIdentifier: "loginVC") as! loginVC
        let homeNavigation = UINavigationController(rootViewController: home)
        homeNavigation.navigationBar.isHidden = true
        self.window?.rootViewController = homeNavigation
        self.window?.makeKeyAndVisible()
    }
    
    func saveCurrentUserData(dic: JBLoginUserData)
    {
        let data = NSKeyedArchiver.archivedData(withRootObject: dic)
        UserDefaults.standard.setValue(data, forKey: "currentUserDataFB")
        UserDefaults.standard.synchronize()
    }
    
    func getCurrentUserData() -> JBLoginUserData
    {
        if let data = UserDefaults.standard.object(forKey: "currentUserDataFB"){
            
            let arrayObjc = NSKeyedUnarchiver.unarchiveObject(with: data as! Data)
            return arrayObjc as! JBLoginUserData
        }
        return JBLoginUserData()
        
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // Handle the notification content here
        
        // After handling the notification, remove the badge
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
   

}


enum VersionError: Error {
    case invalidResponse, invalidBundleInfo
}

@discardableResult
func isUpdateAvailable(completion: @escaping (Bool?, Error?) -> Void) throws -> URLSessionDataTask {
    guard let info = Bundle.main.infoDictionary,
        let currentVersion = info["CFBundleShortVersionString"] as? String,
        let identifier = info["CFBundleIdentifier"] as? String,
        let url = URL(string: "http://itunes.apple.com/lookup?bundleId=\(identifier)") else {
            throw VersionError.invalidBundleInfo
    }
        
    let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalCacheData)
    
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        do {
            if let error = error { throw error }
            
            guard let data = data else { throw VersionError.invalidResponse }
                        
            let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any]
                        
            guard let result = (json?["results"] as? [Any])?.first as? [String: Any], let lastVersion = result["version"] as? String else {
                throw VersionError.invalidResponse
            }
            completion(lastVersion > currentVersion, nil)
        } catch {
            completion(nil, error)
        }
    }
    
    task.resume()
    return task
}
