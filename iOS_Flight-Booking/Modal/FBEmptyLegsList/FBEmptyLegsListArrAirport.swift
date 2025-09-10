//
//	FBEmptyLegsListArrAirport.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class FBEmptyLegsListArrAirport : NSObject, NSCoding{

	var city : FBEmptyLegsListCity!
	var iata : String!
	var icao : String!
	var id : Int!
	var lid : String!
	var name : String!
	var slug : String!


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
		if let cityData = dictionary["city"] as? NSDictionary{
			city = FBEmptyLegsListCity(fromDictionary: cityData)
		}
		else
		{
			city = FBEmptyLegsListCity(fromDictionary: NSDictionary.init())
		}
		iata = dictionary["iata"] as? String == nil ? "" : dictionary["iata"] as? String
		icao = dictionary["icao"] as? String == nil ? "" : dictionary["icao"] as? String
		id = dictionary["id"] as? Int == nil ? 0 : dictionary["id"] as? Int
		lid = dictionary["lid"] as? String == nil ? "" : dictionary["lid"] as? String
		name = dictionary["name"] as? String == nil ? "" : dictionary["name"] as? String
		slug = dictionary["slug"] as? String == nil ? "" : dictionary["slug"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if city != nil{
			dictionary["city"] = city.toDictionary()
		}
		if iata != nil{
			dictionary["iata"] = iata
		}
		if icao != nil{
			dictionary["icao"] = icao
		}
		if id != nil{
			dictionary["id"] = id
		}
		if lid != nil{
			dictionary["lid"] = lid
		}
		if name != nil{
			dictionary["name"] = name
		}
		if slug != nil{
			dictionary["slug"] = slug
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         city = aDecoder.decodeObject(forKey: "city") as? FBEmptyLegsListCity
         iata = aDecoder.decodeObject(forKey: "iata") as? String
         icao = aDecoder.decodeObject(forKey: "icao") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         lid = aDecoder.decodeObject(forKey: "lid") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String
         slug = aDecoder.decodeObject(forKey: "slug") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if city != nil{
			aCoder.encode(city, forKey: "city")
		}
		if iata != nil{
			aCoder.encode(iata, forKey: "iata")
		}
		if icao != nil{
			aCoder.encode(icao, forKey: "icao")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if lid != nil{
			aCoder.encode(lid, forKey: "lid")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if slug != nil{
			aCoder.encode(slug, forKey: "slug")
		}

	}

}