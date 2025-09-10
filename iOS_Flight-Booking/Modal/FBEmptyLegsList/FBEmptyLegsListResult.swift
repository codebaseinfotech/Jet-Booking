//
//	FBEmptyLegsListResult.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class FBEmptyLegsListResult : NSObject, NSCoding{

	var aircraftType : String!
	var arrAirport : FBEmptyLegsListArrAirport!
	var arrivalAirportIcao : String!
	var availabilityId : Int!
	var comment : String!
	var company : String!
	var currencyCode : String!
	var depAirport : FBEmptyLegsListArrAirport!
	var depAirportIcao : String!
	var fromDateUtc : String!
	var id : Int!
	var price : String!
	var registrationNumber : String!
	var toDateUtc : String!


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
		aircraftType = dictionary["aircraft_type"] as? String == nil ? "" : dictionary["aircraft_type"] as? String
		if let arrAirportData = dictionary["arr_airport"] as? NSDictionary{
			arrAirport = FBEmptyLegsListArrAirport(fromDictionary: arrAirportData)
		}
		else
		{
			arrAirport = FBEmptyLegsListArrAirport(fromDictionary: NSDictionary.init())
		}
		arrivalAirportIcao = dictionary["arrival_airport_icao"] as? String == nil ? "" : dictionary["arrival_airport_icao"] as? String
		availabilityId = dictionary["availability_id"] as? Int == nil ? 0 : dictionary["availability_id"] as? Int
		comment = dictionary["comment"] as? String == nil ? "" : dictionary["comment"] as? String
		company = dictionary["company"] as? String == nil ? "" : dictionary["company"] as? String
		currencyCode = dictionary["currency_code"] as? String == nil ? "" : dictionary["currency_code"] as? String
		if let depAirportData = dictionary["dep_airport"] as? NSDictionary{
			depAirport = FBEmptyLegsListArrAirport(fromDictionary: depAirportData)
		}
		else
		{
			depAirport = FBEmptyLegsListArrAirport(fromDictionary: NSDictionary.init())
		}
		depAirportIcao = dictionary["dep_airport_icao"] as? String == nil ? "" : dictionary["dep_airport_icao"] as? String
		fromDateUtc = dictionary["from_date_utc"] as? String == nil ? "" : dictionary["from_date_utc"] as? String
		id = dictionary["id"] as? Int == nil ? 0 : dictionary["id"] as? Int
		price = dictionary["price"] as? String == nil ? "" : dictionary["price"] as? String
		registrationNumber = dictionary["registration_number"] as? String == nil ? "" : dictionary["registration_number"] as? String
		toDateUtc = dictionary["to_date_utc"] as? String == nil ? "" : dictionary["to_date_utc"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if aircraftType != nil{
			dictionary["aircraft_type"] = aircraftType
		}
		if arrAirport != nil{
			dictionary["arr_airport"] = arrAirport.toDictionary()
		}
		if arrivalAirportIcao != nil{
			dictionary["arrival_airport_icao"] = arrivalAirportIcao
		}
		if availabilityId != nil{
			dictionary["availability_id"] = availabilityId
		}
		if comment != nil{
			dictionary["comment"] = comment
		}
		if company != nil{
			dictionary["company"] = company
		}
		if currencyCode != nil{
			dictionary["currency_code"] = currencyCode
		}
		if depAirport != nil{
			dictionary["dep_airport"] = depAirport.toDictionary()
		}
		if depAirportIcao != nil{
			dictionary["dep_airport_icao"] = depAirportIcao
		}
		if fromDateUtc != nil{
			dictionary["from_date_utc"] = fromDateUtc
		}
		if id != nil{
			dictionary["id"] = id
		}
		if price != nil{
			dictionary["price"] = price
		}
		if registrationNumber != nil{
			dictionary["registration_number"] = registrationNumber
		}
		if toDateUtc != nil{
			dictionary["to_date_utc"] = toDateUtc
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         aircraftType = aDecoder.decodeObject(forKey: "aircraft_type") as? String
         arrAirport = aDecoder.decodeObject(forKey: "arr_airport") as? FBEmptyLegsListArrAirport
         arrivalAirportIcao = aDecoder.decodeObject(forKey: "arrival_airport_icao") as? String
         availabilityId = aDecoder.decodeObject(forKey: "availability_id") as? Int
         comment = aDecoder.decodeObject(forKey: "comment") as? String
         company = aDecoder.decodeObject(forKey: "company") as? String
         currencyCode = aDecoder.decodeObject(forKey: "currency_code") as? String
         depAirport = aDecoder.decodeObject(forKey: "dep_airport") as? FBEmptyLegsListArrAirport
         depAirportIcao = aDecoder.decodeObject(forKey: "dep_airport_icao") as? String
         fromDateUtc = aDecoder.decodeObject(forKey: "from_date_utc") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         price = aDecoder.decodeObject(forKey: "price") as? String
         registrationNumber = aDecoder.decodeObject(forKey: "registration_number") as? String
         toDateUtc = aDecoder.decodeObject(forKey: "to_date_utc") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if aircraftType != nil{
			aCoder.encode(aircraftType, forKey: "aircraft_type")
		}
		if arrAirport != nil{
			aCoder.encode(arrAirport, forKey: "arr_airport")
		}
		if arrivalAirportIcao != nil{
			aCoder.encode(arrivalAirportIcao, forKey: "arrival_airport_icao")
		}
		if availabilityId != nil{
			aCoder.encode(availabilityId, forKey: "availability_id")
		}
		if comment != nil{
			aCoder.encode(comment, forKey: "comment")
		}
		if company != nil{
			aCoder.encode(company, forKey: "company")
		}
		if currencyCode != nil{
			aCoder.encode(currencyCode, forKey: "currency_code")
		}
		if depAirport != nil{
			aCoder.encode(depAirport, forKey: "dep_airport")
		}
		if depAirportIcao != nil{
			aCoder.encode(depAirportIcao, forKey: "dep_airport_icao")
		}
		if fromDateUtc != nil{
			aCoder.encode(fromDateUtc, forKey: "from_date_utc")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if price != nil{
			aCoder.encode(price, forKey: "price")
		}
		if registrationNumber != nil{
			aCoder.encode(registrationNumber, forKey: "registration_number")
		}
		if toDateUtc != nil{
			aCoder.encode(toDateUtc, forKey: "to_date_utc")
		}

	}

}