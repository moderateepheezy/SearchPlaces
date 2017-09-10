//
//  Geometry.swift
//
//  Created by SimpuMind on 9/9/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Geometry: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let viewport = "viewport"
    static let location = "location"
  }

  // MARK: Properties
  public var viewport: Viewport?
  public var location: Location?

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
    viewport = Viewport(json: json[SerializationKeys.viewport])
    location = Location(json: json[SerializationKeys.location])
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = viewport { dictionary[SerializationKeys.viewport] = value.dictionaryRepresentation() }
    if let value = location { dictionary[SerializationKeys.location] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.viewport = aDecoder.decodeObject(forKey: SerializationKeys.viewport) as? Viewport
    self.location = aDecoder.decodeObject(forKey: SerializationKeys.location) as? Location
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(viewport, forKey: SerializationKeys.viewport)
    aCoder.encode(location, forKey: SerializationKeys.location)
  }

}
