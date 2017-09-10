//
//  AddressComponents.swift
//
//  Created by SimpuMind on 9/9/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class AddressComponents: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let types = "types"
    static let shortName = "short_name"
    static let longName = "long_name"
  }

  // MARK: Properties
  public var types: [String]?
  public var shortName: String?
  public var longName: String?

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
    if let items = json[SerializationKeys.types].array { types = items.map { $0.stringValue } }
    shortName = json[SerializationKeys.shortName].string
    longName = json[SerializationKeys.longName].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = types { dictionary[SerializationKeys.types] = value }
    if let value = shortName { dictionary[SerializationKeys.shortName] = value }
    if let value = longName { dictionary[SerializationKeys.longName] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.types = aDecoder.decodeObject(forKey: SerializationKeys.types) as? [String]
    self.shortName = aDecoder.decodeObject(forKey: SerializationKeys.shortName) as? String
    self.longName = aDecoder.decodeObject(forKey: SerializationKeys.longName) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(types, forKey: SerializationKeys.types)
    aCoder.encode(shortName, forKey: SerializationKeys.shortName)
    aCoder.encode(longName, forKey: SerializationKeys.longName)
  }

}
