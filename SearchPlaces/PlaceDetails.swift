//
//  PlaceDetails.swift
//
//  Created by SimpuMind on 9/9/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class PlaceDetails: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let htmlAttributions = "html_attributions"
    static let result = "result"
    static let status = "status"
  }

  // MARK: Properties
  public var htmlAttributions: [Any]?
  public var result: Result?
  public var status: String?

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
    if let items = json[SerializationKeys.htmlAttributions].array { htmlAttributions = items.map { $0.object} }
    result = Result(json: json[SerializationKeys.result])
    status = json[SerializationKeys.status].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = htmlAttributions { dictionary[SerializationKeys.htmlAttributions] = value }
    if let value = result { dictionary[SerializationKeys.result] = value.dictionaryRepresentation() }
    if let value = status { dictionary[SerializationKeys.status] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.htmlAttributions = aDecoder.decodeObject(forKey: SerializationKeys.htmlAttributions) as? [Any]
    self.result = aDecoder.decodeObject(forKey: SerializationKeys.result) as? Result
    self.status = aDecoder.decodeObject(forKey: SerializationKeys.status) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(htmlAttributions, forKey: SerializationKeys.htmlAttributions)
    aCoder.encode(result, forKey: SerializationKeys.result)
    aCoder.encode(status, forKey: SerializationKeys.status)
  }

}
