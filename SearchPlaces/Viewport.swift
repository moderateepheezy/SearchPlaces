//
//  Viewport.swift
//
//  Created by SimpuMind on 9/9/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Viewport: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let northeast = "northeast"
    static let southwest = "southwest"
  }

  // MARK: Properties
  public var northeast: Northeast?
  public var southwest: Southwest?

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
    northeast = Northeast(json: json[SerializationKeys.northeast])
    southwest = Southwest(json: json[SerializationKeys.southwest])
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = northeast { dictionary[SerializationKeys.northeast] = value.dictionaryRepresentation() }
    if let value = southwest { dictionary[SerializationKeys.southwest] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.northeast = aDecoder.decodeObject(forKey: SerializationKeys.northeast) as? Northeast
    self.southwest = aDecoder.decodeObject(forKey: SerializationKeys.southwest) as? Southwest
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(northeast, forKey: SerializationKeys.northeast)
    aCoder.encode(southwest, forKey: SerializationKeys.southwest)
  }

}
