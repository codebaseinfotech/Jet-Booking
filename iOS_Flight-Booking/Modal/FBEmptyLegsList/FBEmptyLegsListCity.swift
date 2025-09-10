//
//	FBEmptyLegsListCity.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class FBEmptyLegsListCity : NSObject, NSCoding{

	var country : FBEmptyLegsListCountry!
	var id : Int!
	var name : String!


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
		if let countryData = dictionary["country"] as? NSDictionary{
			country = FBEmptyLegsListCountry(fromDictionary: countryData)
		}
		else
		{
			country = FBEmptyLegsListCountry(fromDictionary: NSDictionary.init())
		}
		id = dictionary["id"] as? Int == nil ? 0 : dictionary["id"] as? Int
		name = dictionary["name"] as? String == nil ? "" : dictionary["name"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if country != nil{
			dictionary["country"] = country.toDictionary()
		}
		if id != nil{
			dictionary["id"] = id
		}
		if name != nil{
			dictionary["name"] = name
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         country = aDecoder.decodeObject(forKey: "country") as? FBEmptyLegsListCountry
         id = aDecoder.decodeObject(forKey: "id") as? Int
         name = aDecoder.decodeObject(forKey: "name") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if country != nil{
			aCoder.encode(country, forKey: "country")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}

	}

}