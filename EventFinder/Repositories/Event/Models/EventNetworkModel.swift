//
//  EventNetworkModel.swift
//  EventFinder
//
//  Created by Nethrah Ayyaswami on 06/28/2021on 9/19/19.
//  
//

import Foundation

struct EventNetworkModel: Decodable {
    
    let events: [Event]
    struct EventList: Decodable{
        let events: [Event]
        let meta: Meta
    }
    
    
    struct Event: Decodable {
        
        let id: Int
        let title: String
        let dateTimeLocal: String
        let performers: [Performer]
        let venue: Venue
       // let meta: Meta
        
        enum CodingKeys: String, CodingKey {
            case id
            case title
            case dateTimeLocal = "datetime_local"
            case performers
            case venue
           // case meta
        }
        
        struct Performer: Decodable {
            
            let image: String?
        }
        
        struct Venue: Decodable {
            
            let city: String
            let state: String?
        }
        
        
    }
    struct Meta: Codable{
        let page: Int
        let perPage: Int
    }
    
}

extension Event {
    
    init(networkEvent: EventNetworkModel.Event) {
        id = networkEvent.id
        title = networkEvent.title
        date = DateFormatter.eventOriginationFormatter.date(from: networkEvent.dateTimeLocal)
        city = networkEvent.venue.city
        state = networkEvent.venue.state
        let imageUrls = networkEvent.performers.compactMap {
            return $0.image
        }
        imageURL = imageUrls.first
       
    }
    
  
}

