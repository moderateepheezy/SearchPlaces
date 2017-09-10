//
//  ApiClient.swift
//  SearchPlaces
//
//  Created by SimpuMind on 9/2/17.
//  Copyright © 2017 SimpuMind. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

let API_KEY = "AIzaSyCU8MV1042-x-kgKULluKkA33Hy67O6VaU"


public class ApiService {
    
    static let sharedInstance = ApiService()
    
    func fetchNearByPlace(longitude: String, latitude: String, completion: @escaping (Places?, _ error: String?) -> ()){
        
        let urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(latitude),\(longitude)&radius=500&key=\(API_KEY)"
        
        Alamofire.request(urlString).responseJSON { response in
            
            switch response.result {
            case .success:
                
                if let data = response.data {
                    let json = JSON(data: data)
                    let places = Places(json: json)
                    
                    completion(places, nil)
                }
                
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    func fetchPlaceDetails(placeId: String, completion: @escaping (Result?, _ error: String?) -> ()){
        let detailsUrlString = "https://maps.googleapis.com/maps/api/place/details/json?placeid=\(placeId)&key=\(API_KEY)"
        
        Alamofire.request(detailsUrlString).responseJSON { (response) in
            switch response.result {
            case .success:
                
                if let data = response.data {
                    let json = JSON(data: data)
                    let places = PlaceDetails(json: json)
                    let result = places.result
                    
                    completion(result, nil)
                }
                
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    func fetchAutoCompleteData(input: String, completion: @escaping ([Predictions]?, _ error: String?) -> ()){
        let urlString = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=\(input)&types=geocode&key=\(API_KEY)"
        Alamofire.request(urlString).responseJSON { (response) in
            switch response.result {
            case .success:
                
                if let data = response.data {
                    let json = JSON(data: data)
                    let complete = Complete(json: json)
                    let predictions = complete.predictions
                    
                    completion(predictions, nil)
                }
                
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
}
