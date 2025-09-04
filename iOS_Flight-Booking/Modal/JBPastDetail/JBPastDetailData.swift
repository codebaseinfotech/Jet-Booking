//
//	JBPastDetailData.swift
//
//	Create by iMac on 4/3/2023
//	Copyright © 2023. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class JBPastDetailData : NSObject, NSCoding{

	var aircraftId : String!
	var aircraftType : String!
	var createdAt : String!
	var departingFrom : String!
	var departingFromSubTitle : String!
	var departingTo : String!
	var departingToSubTitle : String!
	var departureDate : String!
	var departureTime : String!
	var descriptionField : String!
	var duration : String!
	var id : String!
	var image : String!
	var manufacturingYear : String!
	var passenger : String!
	var price : String!
	var returnDate : String!
	var returnTime : String!
	var seats : String!
	var services : String!
	var title : String!
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
		aircraftId = dictionary["aircraft_id"] as? String == nil ? "" : dictionary["aircraft_id"] as? String
		aircraftType = dictionary["aircraft_type"] as? String == nil ? "" : dictionary["aircraft_type"] as? String
		createdAt = dictionary["created_at"] as? String == nil ? "" : dictionary["created_at"] as? String
		departingFrom = dictionary["departing_from"] as? String == nil ? "" : dictionary["departing_from"] as? String
		departingFromSubTitle = dictionary["departing_from_sub_title"] as? String == nil ? "" : dictionary["departing_from_sub_title"] as? String
		departingTo = dictionary["departing_to"] as? String == nil ? "" : dictionary["departing_to"] as? String
		departingToSubTitle = dictionary["departing_to_sub_title"] as? String == nil ? "" : dictionary["departing_to_sub_title"] as? String
		departureDate = dictionary["departure_date"] as? String == nil ? "" : dictionary["departure_date"] as? String
		departureTime = dictionary["departure_time"] as? String == nil ? "" : dictionary["departure_time"] as? String
		descriptionField = dictionary["description"] as? String == nil ? "" : dictionary["description"] as? String
		duration = dictionary["duration"] as? String == nil ? "" : dictionary["duration"] as? String
		id = dictionary["id"] as? String == nil ? "" : dictionary["id"] as? String
		image = dictionary["image"] as? String == nil ? "" : dictionary["image"] as? String
		manufacturingYear = dictionary["manufacturing_year"] as? String == nil ? "" : dictionary["manufacturing_year"] as? String
		passenger = dictionary["passenger"] as? String == nil ? "" : dictionary["passenger"] as? String
		price = dictionary["price"] as? String == nil ? "" : dictionary["price"] as? String
		returnDate = dictionary["return_date"] as? String == nil ? "" : dictionary["return_date"] as? String
		returnTime = dictionary["return_time"] as? String == nil ? "" : dictionary["return_time"] as? String
		seats = dictionary["seats"] as? String == nil ? "" : dictionary["seats"] as? String
		services = dictionary["services"] as? String == nil ? "" : dictionary["services"] as? String
		title = dictionary["title"] as? String == nil ? "" : dictionary["title"] as? String
		updatedAt = dictionary["updated_at"] as? String == nil ? "" : dictionary["updated_at"] as? String
		userid = dictionary["userid"] as? String == nil ? "" : dictionary["userid"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if aircraftId != nil{
			dictionary["aircraft_id"] = aircraftId
		}
		if aircraftType != nil{
			dictionary["aircraft_type"] = aircraftType
		}
		if createdAt != nil{
			dictionary["created_at"] = createdAt
		}
		if departingFrom != nil{
			dictionary["departing_from"] = departingFrom
		}
		if departingFromSubTitle != nil{
			dictionary["departing_from_sub_title"] = departingFromSubTitle
		}
		if departingTo != nil{
			dictionary["departing_to"] = departingTo
		}
		if departingToSubTitle != nil{
			dictionary["departing_to_sub_title"] = departingToSubTitle
		}
		if departureDate != nil{
			dictionary["departure_date"] = departureDate
		}
		if departureTime != nil{
			dictionary["departure_time"] = departureTime
		}
		if descriptionField != nil{
			dictionary["description"] = descriptionField
		}
		if duration != nil{
			dictionary["duration"] = duration
		}
		if id != nil{
			dictionary["id"] = id
		}
		if image != nil{
			dictionary["image"] = image
		}
		if manufacturingYear != nil{
			dictionary["manufacturing_year"] = manufacturingYear
		}
		if passenger != nil{
			dictionary["passenger"] = passenger
		}
		if price != nil{
			dictionary["price"] = price
		}
		if returnDate != nil{
			dictionary["return_date"] = returnDate
		}
		if returnTime != nil{
			dictionary["return_time"] = returnTime
		}
		if seats != nil{
			dictionary["seats"] = seats
		}
		if services != nil{
			dictionary["services"] = services
		}
		if title != nil{
			dictionary["title"] = title
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
         aircraftId = aDecoder.decodeObject(forKey: "aircraft_id") as? String
         aircraftType = aDecoder.decodeObject(forKey: "aircraft_type") as? String
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         departingFrom = aDecoder.decodeObject(forKey: "departing_from") as? String
         departingFromSubTitle = aDecoder.decodeObject(forKey: "departing_from_sub_title") as? String
         departingTo = aDecoder.decodeObject(forKey: "departing_to") as? String
         departingToSubTitle = aDecoder.decodeObject(forKey: "departing_to_sub_title") as? String
         departureDate = aDecoder.decodeObject(forKey: "departure_date") as? String
         departureTime = aDecoder.decodeObject(forKey: "departure_time") as? String
         descriptionField = aDecoder.decodeObject(forKey: "description") as? String
         duration = aDecoder.decodeObject(forKey: "duration") as? String
         id = aDecoder.decodeObject(forKey: "id") as? String
         image = aDecoder.decodeObject(forKey: "image") as? String
         manufacturingYear = aDecoder.decodeObject(forKey: "manufacturing_year") as? String
         passenger = aDecoder.decodeObject(forKey: "passenger") as? String
         price = aDecoder.decodeObject(forKey: "price") as? String
         returnDate = aDecoder.decodeObject(forKey: "return_date") as? String
         returnTime = aDecoder.decodeObject(forKey: "return_time") as? String
         seats = aDecoder.decodeObject(forKey: "seats") as? String
         services = aDecoder.decodeObject(forKey: "services") as? String
         title = aDecoder.decodeObject(forKey: "title") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
         userid = aDecoder.decodeObject(forKey: "userid") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if aircraftId != nil{
			aCoder.encode(aircraftId, forKey: "aircraft_id")
		}
		if aircraftType != nil{
			aCoder.encode(aircraftType, forKey: "aircraft_type")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if departingFrom != nil{
			aCoder.encode(departingFrom, forKey: "departing_from")
		}
		if departingFromSubTitle != nil{
			aCoder.encode(departingFromSubTitle, forKey: "departing_from_sub_title")
		}
		if departingTo != nil{
			aCoder.encode(departingTo, forKey: "departing_to")
		}
		if departingToSubTitle != nil{
			aCoder.encode(departingToSubTitle, forKey: "departing_to_sub_title")
		}
		if departureDate != nil{
			aCoder.encode(departureDate, forKey: "departure_date")
		}
		if departureTime != nil{
			aCoder.encode(departureTime, forKey: "departure_time")
		}
		if descriptionField != nil{
			aCoder.encode(descriptionField, forKey: "description")
		}
		if duration != nil{
			aCoder.encode(duration, forKey: "duration")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if image != nil{
			aCoder.encode(image, forKey: "image")
		}
		if manufacturingYear != nil{
			aCoder.encode(manufacturingYear, forKey: "manufacturing_year")
		}
		if passenger != nil{
			aCoder.encode(passenger, forKey: "passenger")
		}
		if price != nil{
			aCoder.encode(price, forKey: "price")
		}
		if returnDate != nil{
			aCoder.encode(returnDate, forKey: "return_date")
		}
		if returnTime != nil{
			aCoder.encode(returnTime, forKey: "return_time")
		}
		if seats != nil{
			aCoder.encode(seats, forKey: "seats")
		}
		if services != nil{
			aCoder.encode(services, forKey: "services")
		}
		if title != nil{
			aCoder.encode(title, forKey: "title")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}
		if userid != nil{
			aCoder.encode(userid, forKey: "userid")
		}

	}

}