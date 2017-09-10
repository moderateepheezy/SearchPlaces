//
//  NearbyViewModel.swift
//  SearchPlaces
//
//  Created by SimpuMind on 9/3/17.
//  Copyright © 2017 SimpuMind. All rights reserved.
//

import Foundation
import SwiftyJSON

class NearbyViewModel {
    
    //var apiService: ApiService
    
    var results: [Results]?
    
    
    
    func fetchNearbyResults(longitude: String, latitude: String, completion: @escaping () -> ()){
        ApiService.sharedInstance.fetchNearByPlace(longitude: longitude, latitude: latitude) { (places, error) in
            
            if error != nil{ 
                return
            }
            
            guard let results = places?.results else {return}
            self.results = results
            completion()
        }
    }
    
    
    func numberOfItemsInSection(section: Int) -> Int {
        return results?.count ?? 0
    }
    
    func resultForItemAt(indexPath: IndexPath) -> Results{
        
        if  let result = results?[indexPath.item] {
            return result
        }
        
        return Results(json: JSON.null)
    }
}
