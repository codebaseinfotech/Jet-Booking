//
//	JBSearchFightListData.swift
//
//	Create by iMac on 25/2/2023
//	Copyright © 2023. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class JBSearchFightListData : NSObject, NSCoding{

    var airportCode : String!
    var airportName : String!
    var continentId : String!
    var countryId : String!
    var createdAt : String!
    var id : String!
    var location : String!


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
        airportCode = dictionary["airport_code"] as? String == nil ? "" : dictionary["airport_code"] as? String
        airportName = dictionary["airport_name"] as? String == nil ? "" : dictionary["airport_name"] as? String
        continentId = dictionary["continent_id"] as? String == nil ? "" : dictionary["continent_id"] as? String
        countryId = dictionary["country_id"] as? String == nil ? "" : dictionary["country_id"] as? String
        createdAt = dictionary["created_at"] as? String == nil ? "" : dictionary["created_at"] as? String
        id = dictionary["id"] as? String == nil ? "" : dictionary["id"] as? String
        location = dictionary["location"] as? String == nil ? "" : dictionary["location"] as? String
    }

    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if airportCode != nil{
            dictionary["airport_code"] = airportCode
        }
        if airportName != nil{
            dictionary["airport_name"] = airportName
        }
        if continentId != nil{
            dictionary["continent_id"] = continentId
        }
        if countryId != nil{
            dictionary["country_id"] = countryId
        }
        if createdAt != nil{
            dictionary["created_at"] = createdAt
        }
        if id != nil{
            dictionary["id"] = id
        }
        if location != nil{
            dictionary["location"] = location
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         airportCode = aDecoder.decodeObject(forKey: "airport_code") as? String
         airportName = aDecoder.decodeObject(forKey: "airport_name") as? String
         continentId = aDecoder.decodeObject(forKey: "continent_id") as? String
         countryId = aDecoder.decodeObject(forKey: "country_id") as? String
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         id = aDecoder.decodeObject(forKey: "id") as? String
         location = aDecoder.decodeObject(forKey: "location") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    public func encode(with aCoder: NSCoder)
    {
        if airportCode != nil{
            aCoder.encode(airportCode, forKey: "airport_code")
        }
        if airportName != nil{
            aCoder.encode(airportName, forKey: "airport_name")
        }
        if continentId != nil{
            aCoder.encode(continentId, forKey: "continent_id")
        }
        if countryId != nil{
            aCoder.encode(countryId, forKey: "country_id")
        }
        if createdAt != nil{
            aCoder.encode(createdAt, forKey: "created_at")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if location != nil{
            aCoder.encode(location, forKey: "location")
        }

    }

}
