//
//  Open.swift
//
//  Created by SimpuMind on 9/9/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Open: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let time = "time"
    static let day = "day"
  }

  // MARK: Properties
  public var time: String?
  public var day: Int?

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
    time = json[SerializationKeys.time].string
    day = json[SerializationKeys.day].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = time { dictionary[SerializationKeys.time] = value }
    if let value = day { dictionary[SerializationKeys.day] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.time = aDecoder.decodeObject(forKey: SerializationKeys.time) as? String
    self.day = aDecoder.decodeObject(forKey: SerializationKeys.day) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(time, forKey: SerializationKeys.time)
    aCoder.encode(day, forKey: SerializationKeys.day)
  }

}
