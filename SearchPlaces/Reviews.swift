//
//  Reviews.swift
//
//  Created by SimpuMind on 9/9/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Reviews: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let profilePhotoUrl = "profile_photo_url"
    static let text = "text"
    static let language = "language"
    static let authorUrl = "author_url"
    static let relativeTimeDescription = "relative_time_description"
    static let rating = "rating"
    static let authorName = "author_name"
    static let time = "time"
  }

  // MARK: Properties
  public var profilePhotoUrl: String?
  public var text: String?
  public var language: String?
  public var authorUrl: String?
  public var relativeTimeDescription: String?
  public var rating: Int?
  public var authorName: String?
  public var time: Int?

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
    profilePhotoUrl = json[SerializationKeys.profilePhotoUrl].string
    text = json[SerializationKeys.text].string
    language = json[SerializationKeys.language].string
    authorUrl = json[SerializationKeys.authorUrl].string
    relativeTimeDescription = json[SerializationKeys.relativeTimeDescription].string
    rating = json[SerializationKeys.rating].int
    authorName = json[SerializationKeys.authorName].string
    time = json[SerializationKeys.time].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = profilePhotoUrl { dictionary[SerializationKeys.profilePhotoUrl] = value }
    if let value = text { dictionary[SerializationKeys.text] = value }
    if let value = language { dictionary[SerializationKeys.language] = value }
    if let value = authorUrl { dictionary[SerializationKeys.authorUrl] = value }
    if let value = relativeTimeDescription { dictionary[SerializationKeys.relativeTimeDescription] = value }
    if let value = rating { dictionary[SerializationKeys.rating] = value }
    if let value = authorName { dictionary[SerializationKeys.authorName] = value }
    if let value = time { dictionary[SerializationKeys.time] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.profilePhotoUrl = aDecoder.decodeObject(forKey: SerializationKeys.profilePhotoUrl) as? String
    self.text = aDecoder.decodeObject(forKey: SerializationKeys.text) as? String
    self.language = aDecoder.decodeObject(forKey: SerializationKeys.language) as? String
    self.authorUrl = aDecoder.decodeObject(forKey: SerializationKeys.authorUrl) as? String
    self.relativeTimeDescription = aDecoder.decodeObject(forKey: SerializationKeys.relativeTimeDescription) as? String
    self.rating = aDecoder.decodeObject(forKey: SerializationKeys.rating) as? Int
    self.authorName = aDecoder.decodeObject(forKey: SerializationKeys.authorName) as? String
    self.time = aDecoder.decodeObject(forKey: SerializationKeys.time) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(profilePhotoUrl, forKey: SerializationKeys.profilePhotoUrl)
    aCoder.encode(text, forKey: SerializationKeys.text)
    aCoder.encode(language, forKey: SerializationKeys.language)
    aCoder.encode(authorUrl, forKey: SerializationKeys.authorUrl)
    aCoder.encode(relativeTimeDescription, forKey: SerializationKeys.relativeTimeDescription)
    aCoder.encode(rating, forKey: SerializationKeys.rating)
    aCoder.encode(authorName, forKey: SerializationKeys.authorName)
    aCoder.encode(time, forKey: SerializationKeys.time)
  }

}
