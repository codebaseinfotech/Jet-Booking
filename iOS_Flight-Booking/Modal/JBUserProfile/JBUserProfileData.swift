//
//	JBUserProfileData.swift
//
//	Create by iMac on 22/2/2023
//	Copyright © 2023. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class JBUserProfileData : NSObject, NSCoding{

	var createdAt : String!
	var email : String!
	var firstName : String!
	var id : String!
	var image : String!
	var imageUrl : String!
	var lastName : String!
	var mobile : String!
	var passport : String!
	var password : String!
	var updatedAt : String!


	/**
	 * Overiding init method
	 */
	init(fromDictionary dictionary: NSDictionary)
	{
		super.init()
		parseJSONData(fromDictionary: dictionary)
	}

	/**
	 * Overiding init method
	 */
	override init(){
	}

	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	@objc func parseJSONData(fromDictionary dictionary: NSDictionary)
	{
		createdAt = dictionary["created_at"] as? String == nil ? "" : dictionary["created_at"] as? String
		email = dictionary["email"] as? String == nil ? "" : dictionary["email"] as? String
		firstName = dictionary["first_name"] as? String == nil ? "" : dictionary["first_name"] as? String
		id = dictionary["id"] as? String == nil ? "" : dictionary["id"] as? String
		image = dictionary["image"] as? String == nil ? "" : dictionary["image"] as? String
		imageUrl = dictionary["image_url"] as? String == nil ? "" : dictionary["image_url"] as? String
		lastName = dictionary["last_name"] as? String == nil ? "" : dictionary["last_name"] as? String
		mobile = dictionary["mobile"] as? String == nil ? "" : dictionary["mobile"] as? String
		passport = dictionary["passport"] as? String == nil ? "" : dictionary["passport"] as? String
		password = dictionary["password"] as? String == nil ? "" : dictionary["password"] as? String
		updatedAt = dictionary["updated_at"] as? String == nil ? "" : dictionary["updated_at"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if createdAt != nil{
			dictionary["created_at"] = createdAt
		}
		if email != nil{
			dictionary["email"] = email
		}
		if firstName != nil{
			dictionary["first_name"] = firstName
		}
		if id != nil{
			dictionary["id"] = id
		}
		if image != nil{
			dictionary["image"] = image
		}
		if imageUrl != nil{
			dictionary["image_url"] = imageUrl
		}
		if lastName != nil{
			dictionary["last_name"] = lastName
		}
		if mobile != nil{
			dictionary["mobile"] = mobile
		}
		if passport != nil{
			dictionary["passport"] = passport
		}
		if password != nil{
			dictionary["password"] = password
		}
		if updatedAt != nil{
			dictionary["updated_at"] = updatedAt
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         email = aDecoder.decodeObject(forKey: "email") as? String
         firstName = aDecoder.decodeObject(forKey: "first_name") as? String
         id = aDecoder.decodeObject(forKey: "id") as? String
         image = aDecoder.decodeObject(forKey: "image") as? String
         imageUrl = aDecoder.decodeObject(forKey: "image_url") as? String
         lastName = aDecoder.decodeObject(forKey: "last_name") as? String
         mobile = aDecoder.decodeObject(forKey: "mobile") as? String
         passport = aDecoder.decodeObject(forKey: "passport") as? String
         password = aDecoder.decodeObject(forKey: "password") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if email != nil{
			aCoder.encode(email, forKey: "email")
		}
		if firstName != nil{
			aCoder.encode(firstName, forKey: "first_name")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if image != nil{
			aCoder.encode(image, forKey: "image")
		}
		if imageUrl != nil{
			aCoder.encode(imageUrl, forKey: "image_url")
		}
		if lastName != nil{
			aCoder.encode(lastName, forKey: "last_name")
		}
		if mobile != nil{
			aCoder.encode(mobile, forKey: "mobile")
		}
		if passport != nil{
			aCoder.encode(passport, forKey: "passport")
		}
		if password != nil{
			aCoder.encode(password, forKey: "password")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}

	}

}