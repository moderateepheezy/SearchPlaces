//
//  Result.swift
//
//  Created by SimpuMind on 9/9/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Result: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let reference = "reference"
    static let icon = "icon"
    static let name = "name"
    static let adrAddress = "adr_address"
    static let addressComponents = "address_components"
    static let website = "website"
    static let placeId = "place_id"
    static let formattedAddress = "formatted_address"
    static let rating = "rating"
    static let scope = "scope"
    static let photos = "photos"
    static let reviews = "reviews"
    static let types = "types"
    static let geometry = "geometry"
    static let vicinity = "vicinity"
    static let id = "id"
    static let formattedPhoneNumber = "formatted_phone_number"
    static let internationalPhoneNumber = "international_phone_number"
    static let utcOffset = "utc_offset"
    static let openingHours = "opening_hours"
    static let url = "url"
  }

  // MARK: Properties
  public var reference: String?
  public var icon: String?
  public var name: String?
  public var adrAddress: String?
  public var addressComponents: [AddressComponents]?
  public var website: String?
  public var placeId: String?
  public var formattedAddress: String?
  public var rating: Float?
  public var scope: String?
  public var photos: [Photos]?
  public var reviews: [Reviews]?
  public var types: [String]?
  public var geometry: Geometry?
  public var vicinity: String?
  public var id: String?
  public var formattedPhoneNumber: String?
  public var internationalPhoneNumber: String?
  public var utcOffset: Int?
  public var openingHours: OpeningHours?
  public var url: String?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    reference = json[SerializationKeys.reference].string
    icon = json[SerializationKeys.icon].string
    name = json[SerializationKeys.name].string
    adrAddress = json[SerializationKeys.adrAddress].string
    if let items = json[SerializationKeys.addressComponents].array { addressComponents = items.map { AddressComponents(json: $0) } }
    website = json[SerializationKeys.website].string
    placeId = json[SerializationKeys.placeId].string
    formattedAddress = json[SerializationKeys.formattedAddress].string
    rating = json[SerializationKeys.rating].float
    scope = json[SerializationKeys.scope].string
    if let items = json[SerializationKeys.photos].array { photos = items.map { Photos(json: $0) } }
    if let items = json[SerializationKeys.reviews].array { reviews = items.map { Reviews(json: $0) } }
    if let items = json[SerializationKeys.types].array { types = items.map { $0.stringValue } }
    geometry = Geometry(json: json[SerializationKeys.geometry])
    vicinity = json[SerializationKeys.vicinity].string
    id = json[SerializationKeys.id].string
    formattedPhoneNumber = json[SerializationKeys.formattedPhoneNumber].string
    internationalPhoneNumber = json[SerializationKeys.internationalPhoneNumber].string
    utcOffset = json[SerializationKeys.utcOffset].int
    openingHours = OpeningHours(json: json[SerializationKeys.openingHours])
    url = json[SerializationKeys.url].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = reference { dictionary[SerializationKeys.reference] = value }
    if let value = icon { dictionary[SerializationKeys.icon] = value }
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = adrAddress { dictionary[SerializationKeys.adrAddress] = value }
    if let value = addressComponents { dictionary[SerializationKeys.addressComponents] = value.map { $0.dictionaryRepresentation() } }
    if let value = website { dictionary[SerializationKeys.website] = value }
    if let value = placeId { dictionary[SerializationKeys.placeId] = value }
    if let value = formattedAddress { dictionary[SerializationKeys.formattedAddress] = value }
    if let value = rating { dictionary[SerializationKeys.rating] = value }
    if let value = scope { dictionary[SerializationKeys.scope] = value }
    if let value = photos { dictionary[SerializationKeys.photos] = value.map { $0.dictionaryRepresentation() } }
    if let value = reviews { dictionary[SerializationKeys.reviews] = value.map { $0.dictionaryRepresentation() } }
    if let value = types { dictionary[SerializationKeys.types] = value }
    if let value = geometry { dictionary[SerializationKeys.geometry] = value.dictionaryRepresentation() }
    if let value = vicinity { dictionary[SerializationKeys.vicinity] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = formattedPhoneNumber { dictionary[SerializationKeys.formattedPhoneNumber] = value }
    if let value = internationalPhoneNumber { dictionary[SerializationKeys.internationalPhoneNumber] = value }
    if let value = utcOffset { dictionary[SerializationKeys.utcOffset] = value }
    if let value = openingHours { dictionary[SerializationKeys.openingHours] = value.dictionaryRepresentation() }
    if let value = url { dictionary[SerializationKeys.url] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.reference = aDecoder.decodeObject(forKey: SerializationKeys.reference) as? String
    self.icon = aDecoder.decodeObject(forKey: SerializationKeys.icon) as? String
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.adrAddress = aDecoder.decodeObject(forKey: SerializationKeys.adrAddress) as? String
    self.addressComponents = aDecoder.decodeObject(forKey: SerializationKeys.addressComponents) as? [AddressComponents]
    self.website = aDecoder.decodeObject(forKey: SerializationKeys.website) as? String
    self.placeId = aDecoder.decodeObject(forKey: SerializationKeys.placeId) as? String
    self.formattedAddress = aDecoder.decodeObject(forKey: SerializationKeys.formattedAddress) as? String
    self.rating = aDecoder.decodeObject(forKey: SerializationKeys.rating) as? Float
    self.scope = aDecoder.decodeObject(forKey: SerializationKeys.scope) as? String
    self.photos = aDecoder.decodeObject(forKey: SerializationKeys.photos) as? [Photos]
    self.reviews = aDecoder.decodeObject(forKey: SerializationKeys.reviews) as? [Reviews]
    self.types = aDecoder.decodeObject(forKey: SerializationKeys.types) as? [String]
    self.geometry = aDecoder.decodeObject(forKey: SerializationKeys.geometry) as? Geometry
    self.vicinity = aDecoder.decodeObject(forKey: SerializationKeys.vicinity) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? String
    self.formattedPhoneNumber = aDecoder.decodeObject(forKey: SerializationKeys.formattedPhoneNumber) as? String
    self.internationalPhoneNumber = aDecoder.decodeObject(forKey: SerializationKeys.internationalPhoneNumber) as? String
    self.utcOffset = aDecoder.decodeObject(forKey: SerializationKeys.utcOffset) as? Int
    self.openingHours = aDecoder.decodeObject(forKey: SerializationKeys.openingHours) as? OpeningHours
    self.url = aDecoder.decodeObject(forKey: SerializationKeys.url) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(reference, forKey: SerializationKeys.reference)
    aCoder.encode(icon, forKey: SerializationKeys.icon)
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(adrAddress, forKey: SerializationKeys.adrAddress)
    aCoder.encode(addressComponents, forKey: SerializationKeys.addressComponents)
    aCoder.encode(website, forKey: SerializationKeys.website)
    aCoder.encode(placeId, forKey: SerializationKeys.placeId)
    aCoder.encode(formattedAddress, forKey: SerializationKeys.formattedAddress)
    aCoder.encode(rating, forKey: SerializationKeys.rating)
    aCoder.encode(scope, forKey: SerializationKeys.scope)
    aCoder.encode(photos, forKey: SerializationKeys.photos)
    aCoder.encode(reviews, forKey: SerializationKeys.reviews)
    aCoder.encode(types, forKey: SerializationKeys.types)
    aCoder.encode(geometry, forKey: SerializationKeys.geometry)
    aCoder.encode(vicinity, forKey: SerializationKeys.vicinity)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(formattedPhoneNumber, forKey: SerializationKeys.formattedPhoneNumber)
    aCoder.encode(internationalPhoneNumber, forKey: SerializationKeys.internationalPhoneNumber)
    aCoder.encode(utcOffset, forKey: SerializationKeys.utcOffset)
    aCoder.encode(openingHours, forKey: SerializationKeys.openingHours)
    aCoder.encode(url, forKey: SerializationKeys.url)
  }

}
