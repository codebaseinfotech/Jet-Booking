//
//  EditProfileVC.swift
//  iOS_Flight-Booking
//
//  Created by Code on 13/02/23.
//

import UIKit
import MobileCoreServices
import Kingfisher

extension Notification.Name {
    
    public static let myNotificationKey = Notification.Name(rawValue: "myNotificationKey")
}

class EditProfileVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var viewFirstName: UIView!
    @IBOutlet weak var viewLastName: UIView!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var viewMobile: UIView!
    @IBOutlet weak var viewPassport: UIView!
    @IBOutlet weak var viewImageInside: UIView!
    @IBOutlet weak var imgProfilePic: UIImageView!
    
    @IBOutlet weak var txtFName: UITextField!
    @IBOutlet weak var txtLName: UITextField!
    @IBOutlet weak var txtEmain: UITextField!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtPassport: UITextField!
    @IBOutlet weak var viewProfile: UIView!
    
    var imagePicker: ImagePicker!
    var selectedImg: String?
    
    var imagePickerNew = UIImagePickerController()
    
    var strImg = ""
    
    var strFName = ""
    
    var strLName = ""
    
    var strEmail = ""
    
    var strMobile = ""
    
    var strPassport = ""
    
    var isProfileUpload = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtFName.text = strFName
        txtLName.text = strLName
        txtEmain.text = strEmail
        txtMobile.text = strMobile
        txtPassport.text = strPassport
        
      
        self.imgProfilePic.kf.setImage(
            with: URL(string: strImg),
            placeholder: nil,
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
 
        if strImg != ""
        {
            isProfileUpload = true
        }
 
        viewFirstName.layer.cornerRadius = 10
        viewFirstName.layer.borderWidth = 1
        viewFirstName.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        
        viewLastName.layer.cornerRadius = 10
        viewLastName.layer.borderWidth = 1
        viewLastName.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        
        viewEmail.layer.cornerRadius = 10
        viewEmail.layer.borderWidth = 1
        viewEmail.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        
        viewMobile.layer.cornerRadius = 10
        viewMobile.layer.borderWidth = 1
        viewMobile.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        
        viewPassport.layer.cornerRadius = 10
        viewPassport.layer.borderWidth = 1
        viewPassport.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        
        viewImageInside.layer.applySketchShadow(color: .black,alpha: 0.25,x: 0,y: 4,blur: 4,spread: 0)
        
    }
    
    @IBAction func clickedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func clickedChanfePic(_ sender: Any) {
        let alert1 = UIAlertController(title: "Photo Library" , message: nil, preferredStyle: .actionSheet)
        
        alert1.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert1.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        
        alert1.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert1, animated: true, completion: nil)
    }
    @IBAction func clickedSave(_ sender: Any) {
        
        if isValidLogin()
        {
            if isProfileUpload == false
            {
                self.navigationController?.popViewController(animated: false)
            }
            else
            {
                myImageUploadRequest(imageToUpload: imgProfilePic.image!, imgKey: "image")
            }
        }
        
    }
    
    func isValidLogin() -> Bool
    {
        self.view.hideToast()
        let windows = UIApplication.shared.windows
        windows.last?.hideToast()
        
        if txtFName.text == ""
        {
            self.view.makeToast("Please enter first name")
            
            let windows = UIApplication.shared.windows
            windows.last?.makeToast("Please enter first name")
            return false
        }
        else if txtLName.text == ""
        {
            self.view.makeToast("Please enter last name")
            let windows = UIApplication.shared.windows
            windows.last?.makeToast("Please enter last name")
            return false
        }
        else if txtEmain.text == ""
        {
            self.view.makeToast("Please enter email")
            let windows = UIApplication.shared.windows
            windows.last?.makeToast("Please enter email")
            return false
        }
        else if !AppUtilites.isValidEmail(testStr: txtEmain.text ?? "")
        {
            self.view.makeToast("Please enter valid email")
            let windows = UIApplication.shared.windows
            windows.last?.makeToast("Please enter valid email")
            return false
        }
        else if txtMobile.text == ""
        {
            self.view.makeToast("Please enter mobile number")
            let windows = UIApplication.shared.windows
            windows.last?.makeToast("Please enter mobile number")
            return false
        }
        else if (txtMobile.text?.count ?? 0) < 8
        {
            self.view.makeToast("Enter valid mobile number")
            return false
        }
        else if isProfileUpload == false
        {
            self.view.makeToast("Please upload profile picture")
            let windows = UIApplication.shared.windows
            windows.last?.makeToast("Please upload profile picture")
            return false
        }
        else if txtPassport.text == ""
        {
            self.view.makeToast("Please enter passport")
            let windows = UIApplication.shared.windows
            windows.last?.makeToast("Please enter passport")
            return false
        }
        
        return true
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePickerNew.delegate = self
            imagePickerNew.sourceType = UIImagePickerController.SourceType.camera
            imagePickerNew.allowsEditing = true
            imagePickerNew.mediaTypes = [kUTTypeImage as String]
            self.present(imagePickerNew, animated: true, completion: nil)
        }
        else
        {
            
            let windows = UIApplication.shared.windows
            windows.last?.makeToast("You don't have camera")
        }
    }
    
    func openGallary()
    {
        
        imagePickerNew.delegate = self
        imagePickerNew.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePickerNew.allowsEditing = true
        imagePickerNew.mediaTypes = ["public.image"]
        self.present(imagePickerNew, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        {
            let imageurl = info[UIImagePickerController.InfoKey.mediaURL] as? URL
            self.selectedImg = imageurl?.lastPathComponent
            self.isProfileUpload = true
            DispatchQueue.main.async {
                self.imgProfilePic.image = image
            }
        }
        else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            let imageurl = info[UIImagePickerController.InfoKey.mediaURL] as? URL
            
            self.selectedImg = imageurl?.lastPathComponent
            self.isProfileUpload = true
            DispatchQueue.main.async {
                self.imgProfilePic.image = image
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    func myImageUploadRequest(imageToUpload: UIImage, imgKey: String) {
        
        self.view.hideToast()
        let windows = UIApplication.shared.windows
        windows.last?.hideToast()
        
        APIClient.sharedInstance.showIndicator()
        
        let myUrl = NSURL(string: BASE_URL + UPDATE_USER_PROFILE);
        let request = NSMutableURLRequest(url:myUrl! as URL);
        request.httpMethod = "POST";
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let params = ["first_name":self.txtFName.text ?? "","last_name":self.txtLName.text ?? "","email":self.txtEmain.text ?? "","mobile":txtMobile.text ?? "","userid":appDelegate.dicCurrentUserData.id ?? "","passport":self.txtPassport.text ?? ""]
        
        let boundary = generateBoundaryString()
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        
        let imageData = imageToUpload.jpegData(compressionQuality: 1)
        if imageData == nil  {
            return
        }
        
        request.httpBody = createBodyWithParameters(parameters: params, filePathKey: imgKey, imageDataKey: imageData! as NSData, boundary: boundary, imgKey: imgKey) as Data
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            APIClient.sharedInstance.hideIndicator()
            
            if error != nil {
                print("error=\(error!)")
                return
            }
            
            // print reponse body
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("response data = \(responseString!)")
            
            do{
                
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                    
                    // try to read out a string array
                    if let message = json["msg"] as? String
                    {
                        let status = json["status"] as? Int

                        DispatchQueue.main.async {
                            
                            self.view.makeToast(message)
                            let windows = UIApplication.shared.windows
                            windows.last?.makeToast(message)
                            
                            if status == 1
                            {
                                NotificationCenter.default.post(name: Notification.Name.myNotificationKey, object: nil, userInfo:["imgProfile":self.imgProfilePic.image!]) // Notification
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    self.navigationController?.popViewController(animated: true)
                                }
                            }
                           
                        }
                    }
                    
                }
                
            }catch{
                
            }
            
        }
        
        task.resume()
    }
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String, imgKey: String) -> NSData {
        
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
            }
        }
        
        let filename = "\(imgKey).jpg"
        let mimetype = "image/jpeg"
        
        body.appendString(string: "--\(boundary)\r\n")
        body.appendString(string: "Content-Disposition: form-data; name=\"\("image")\"; filename=\"\(filename)\"\r\n")
        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey as Data)
        body.appendString(string: "\r\n")
        body.appendString(string: "--\(boundary)--\r\n")
        
        
        return body
    }
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    func randomString(of length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var s = ""
        for _ in 0 ..< length {
            s.append(letters.randomElement()!)
        }
        return s
    }
    
    
}

extension NSMutableData {
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}

