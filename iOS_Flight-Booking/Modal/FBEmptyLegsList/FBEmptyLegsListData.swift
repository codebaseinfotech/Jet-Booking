//
//	FBEmptyLegsListData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class FBEmptyLegsListData : NSObject, NSCoding{

	var count : Int!
	var next : String!
	var perPage : Int!
	var previous : String!
	var results : [FBEmptyLegsListResult]!


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
		count = dictionary["count"] as? Int == nil ? 0 : dictionary["count"] as? Int
		next = dictionary["next"] as? String == nil ? "" : dictionary["next"] as? String
		perPage = dictionary["per_page"] as? Int == nil ? 0 : dictionary["per_page"] as? Int
		previous = dictionary["previous"] as? String == nil ? "" : dictionary["previous"] as? String
		results = [FBEmptyLegsListResult]()
		if let resultsArray = dictionary["results"] as? [NSDictionary]{
			for dic in resultsArray{
				let value = FBEmptyLegsListResult(fromDictionary: dic)
				results.append(value)
			}
		}
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if count != nil{
			dictionary["count"] = count
		}
		if next != nil{
			dictionary["next"] = next
		}
		if perPage != nil{
			dictionary["per_page"] = perPage
		}
		if previous != nil{
			dictionary["previous"] = previous
		}
		if results != nil{
			var dictionaryElements = [NSDictionary]()
			for resultsElement in results {
				dictionaryElements.append(resultsElement.toDictionary())
			}
			dictionary["results"] = dictionaryElements
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         count = aDecoder.decodeObject(forKey: "count") as? Int
         next = aDecoder.decodeObject(forKey: "next") as? String
         perPage = aDecoder.decodeObject(forKey: "per_page") as? Int
         previous = aDecoder.decodeObject(forKey: "previous") as? String
         results = aDecoder.decodeObject(forKey: "results") as? [FBEmptyLegsListResult]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder) 
	{
		if count != nil{
			aCoder.encode(count, forKey: "count")
		}
		if next != nil{
			aCoder.encode(next, forKey: "next")
		}
		if perPage != nil{
			aCoder.encode(perPage, forKey: "per_page")
		}
		if previous != nil{
			aCoder.encode(previous, forKey: "previous")
		}
		if results != nil{
			aCoder.encode(results, forKey: "results")
		}

	}

}