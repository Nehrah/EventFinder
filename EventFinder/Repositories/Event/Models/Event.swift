//
//  Event.swift
//  EventFinder
//
//  Created by Nethrah Ayyaswami on 06/28/2021on 9/19/19.
//  
//

import Foundation

struct Event: Codable & Hashable {
    
    let id: Int
    let title: String
    let date: Date?
    let city: String
    let state: String?
    let imageURL: String?
   // let total:Int?
    ///let page:Int?
    
    var formattedCityState: String {
        var cityState = "\(city)"
        if let state = state {
            cityState += ", \(state)"
        }
        return cityState
    }
    
    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
