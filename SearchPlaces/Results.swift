//
//  Results.swift
//
//  Created by SimpuMind on 9/9/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Results: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let reference = "reference"
    static let icon = "icon"
    static let name = "name"
    static let placeId = "place_id"
    static let priceLevel = "price_level"
    static let rating = "rating"
    static let photos = "photos"
    static let scope = "scope"
    static let vicinity = "vicinity"
    static let types = "types"
    static let geometry = "geometry"
    static let id = "id"
    static let openingHours = "opening_hours"
  }

  // MARK: Properties
  public var reference: String?
  public var icon: String?
  public var name: String?
  public var placeId: String?
  public var priceLevel: Int?
  public var rating: Float?
  public var photos: [Photos]?
  public var scope: String?
  public var vicinity: String?
  public var types: [String]?
  public var geometry: Geometry?
  public var id: String?
  public var openingHours: OpeningHours?

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
    placeId = json[SerializationKeys.placeId].string
    priceLevel = json[SerializationKeys.priceLevel].int
    rating = json[SerializationKeys.rating].float
    if let items = json[SerializationKeys.photos].array { photos = items.map { Photos(json: $0) } }
    scope = json[SerializationKeys.scope].string
    vicinity = json[SerializationKeys.vicinity].string
    if let items = json[SerializationKeys.types].array { types = items.map { $0.stringValue } }
    geometry = Geometry(json: json[SerializationKeys.geometry])
    id = json[SerializationKeys.id].string
    openingHours = OpeningHours(json: json[SerializationKeys.openingHours])
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = reference { dictionary[SerializationKeys.reference] = value }
    if let value = icon { dictionary[SerializationKeys.icon] = value }
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = placeId { dictionary[SerializationKeys.placeId] = value }
    if let value = priceLevel { dictionary[SerializationKeys.priceLevel] = value }
    if let value = rating { dictionary[SerializationKeys.rating] = value }
    if let value = photos { dictionary[SerializationKeys.photos] = value.map { $0.dictionaryRepresentation() } }
    if let value = scope { dictionary[SerializationKeys.scope] = value }
    if let value = vicinity { dictionary[SerializationKeys.vicinity] = value }
    if let value = types { dictionary[SerializationKeys.types] = value }
    if let value = geometry { dictionary[SerializationKeys.geometry] = value.dictionaryRepresentation() }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = openingHours { dictionary[SerializationKeys.openingHours] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.reference = aDecoder.decodeObject(forKey: SerializationKeys.reference) as? String
    self.icon = aDecoder.decodeObject(forKey: SerializationKeys.icon) as? String
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.placeId = aDecoder.decodeObject(forKey: SerializationKeys.placeId) as? String
    self.priceLevel = aDecoder.decodeObject(forKey: SerializationKeys.priceLevel) as? Int
    self.rating = aDecoder.decodeObject(forKey: SerializationKeys.rating) as? Float
    self.photos = aDecoder.decodeObject(forKey: SerializationKeys.photos) as? [Photos]
    self.scope = aDecoder.decodeObject(forKey: SerializationKeys.scope) as? String
    self.vicinity = aDecoder.decodeObject(forKey: SerializationKeys.vicinity) as? String
    self.types = aDecoder.decodeObject(forKey: SerializationKeys.types) as? [String]
    self.geometry = aDecoder.decodeObject(forKey: SerializationKeys.geometry) as? Geometry
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? String
    self.openingHours = aDecoder.decodeObject(forKey: SerializationKeys.openingHours) as? OpeningHours
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(reference, forKey: SerializationKeys.reference)
    aCoder.encode(icon, forKey: SerializationKeys.icon)
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(placeId, forKey: SerializationKeys.placeId)
    aCoder.encode(priceLevel, forKey: SerializationKeys.priceLevel)
    aCoder.encode(rating, forKey: SerializationKeys.rating)
    aCoder.encode(photos, forKey: SerializationKeys.photos)
    aCoder.encode(scope, forKey: SerializationKeys.scope)
    aCoder.encode(vicinity, forKey: SerializationKeys.vicinity)
    aCoder.encode(types, forKey: SerializationKeys.types)
    aCoder.encode(geometry, forKey: SerializationKeys.geometry)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(openingHours, forKey: SerializationKeys.openingHours)
  }

}
