//
//  Periods.swift
//
//  Created by SimpuMind on 9/9/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Periods: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let open = "open"
    static let close = "close"
  }

  // MARK: Properties
  public var open: Open?
  public var close: Close?

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
    open = Open(json: json[SerializationKeys.open])
    close = Close(json: json[SerializationKeys.close])
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = open { dictionary[SerializationKeys.open] = value.dictionaryRepresentation() }
    if let value = close { dictionary[SerializationKeys.close] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.open = aDecoder.decodeObject(forKey: SerializationKeys.open) as? Open
    self.close = aDecoder.decodeObject(forKey: SerializationKeys.close) as? Close
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(open, forKey: SerializationKeys.open)
    aCoder.encode(close, forKey: SerializationKeys.close)
  }

}
