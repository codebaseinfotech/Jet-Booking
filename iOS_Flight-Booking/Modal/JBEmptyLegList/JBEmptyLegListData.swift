//
//	JBEmptyLegListData.swift
//
//	Create by iMac on 22/2/2023
//	Copyright © 2023. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class JBEmptyLegListData : NSObject, NSCoding{

	var aircradftId : String!
	var createdAt : String!
	var departingFrom : String!
	var departingTo : String!
	var departureDate : String!
	var id : String!
	var image : String!
	var seats : String!
	var updatedAt : String!
	var userid : String!


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
		aircradftId = dictionary["aircradft_id"] as? String == nil ? "" : dictionary["aircradft_id"] as? String
		createdAt = dictionary["created_at"] as? String == nil ? "" : dictionary["created_at"] as? String
		departingFrom = dictionary["departing_from"] as? String == nil ? "" : dictionary["departing_from"] as? String
		departingTo = dictionary["departing_to"] as? String == nil ? "" : dictionary["departing_to"] as? String
		departureDate = dictionary["departure_date"] as? String == nil ? "" : dictionary["departure_date"] as? String
		id = dictionary["id"] as? String == nil ? "" : dictionary["id"] as? String
		image = dictionary["image"] as? String == nil ? "" : dictionary["image"] as? String
		seats = dictionary["seats"] as? String == nil ? "" : dictionary["seats"] as? String
		updatedAt = dictionary["updated_at"] as? String == nil ? "" : dictionary["updated_at"] as? String
		userid = dictionary["userid"] as? String == nil ? "" : dictionary["userid"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if aircradftId != nil{
			dictionary["aircradft_id"] = aircradftId
		}
		if createdAt != nil{
			dictionary["created_at"] = createdAt
		}
		if departingFrom != nil{
			dictionary["departing_from"] = departingFrom
		}
		if departingTo != nil{
			dictionary["departing_to"] = departingTo
		}
		if departureDate != nil{
			dictionary["departure_date"] = departureDate
		}
		if id != nil{
			dictionary["id"] = id
		}
		if image != nil{
			dictionary["image"] = image
		}
		if seats != nil{
			dictionary["seats"] = seats
		}
		if updatedAt != nil{
			dictionary["updated_at"] = updatedAt
		}
		if userid != nil{
			dictionary["userid"] = userid
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         aircradftId = aDecoder.decodeObject(forKey: "aircradft_id") as? String
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         departingFrom = aDecoder.decodeObject(forKey: "departing_from") as? String
         departingTo = aDecoder.decodeObject(forKey: "departing_to") as? String
         departureDate = aDecoder.decodeObject(forKey: "departure_date") as? String
         id = aDecoder.decodeObject(forKey: "id") as? String
         image = aDecoder.decodeObject(forKey: "image") as? String
         seats = aDecoder.decodeObject(forKey: "seats") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
         userid = aDecoder.decodeObject(forKey: "userid") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if aircradftId != nil{
			aCoder.encode(aircradftId, forKey: "aircradft_id")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if departingFrom != nil{
			aCoder.encode(departingFrom, forKey: "departing_from")
		}
		if departingTo != nil{
			aCoder.encode(departingTo, forKey: "departing_to")
		}
		if departureDate != nil{
			aCoder.encode(departureDate, forKey: "departure_date")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if image != nil{
			aCoder.encode(image, forKey: "image")
		}
		if seats != nil{
			aCoder.encode(seats, forKey: "seats")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}
		if userid != nil{
			aCoder.encode(userid, forKey: "userid")
		}

	}

}