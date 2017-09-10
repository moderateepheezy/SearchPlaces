//
//  Complete.swift
//
//  Created by SimpuMind on 9/10/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Complete: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let debugLog = "debug_log"
    static let status = "status"
    static let predictions = "predictions"
  }

  // MARK: Properties
  public var debugLog: DebugLog?
  public var status: String?
  public var predictions: [Predictions]?

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
    debugLog = DebugLog(json: json[SerializationKeys.debugLog])
    status = json[SerializationKeys.status].string
    if let items = json[SerializationKeys.predictions].array { predictions = items.map { Predictions(json: $0) } }
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = debugLog { dictionary[SerializationKeys.debugLog] = value.dictionaryRepresentation() }
    if let value = status { dictionary[SerializationKeys.status] = value }
    if let value = predictions { dictionary[SerializationKeys.predictions] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.debugLog = aDecoder.decodeObject(forKey: SerializationKeys.debugLog) as? DebugLog
    self.status = aDecoder.decodeObject(forKey: SerializationKeys.status) as? String
    self.predictions = aDecoder.decodeObject(forKey: SerializationKeys.predictions) as? [Predictions]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(debugLog, forKey: SerializationKeys.debugLog)
    aCoder.encode(status, forKey: SerializationKeys.status)
    aCoder.encode(predictions, forKey: SerializationKeys.predictions)
  }

}
