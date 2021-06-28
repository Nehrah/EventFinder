//
//  EventDataSource.swift
//  EventFinder
//
//  Created by Nethrah Ayyaswami on 06/28/2021on 9/19/19.
//  
//

import Foundation

typealias EventDataSourceCompletion = (Result<[Event], Error>) -> Void

protocol EventDataSource {
    
    func queryEvents(query: String, completion: EventDataSourceCompletion?)
    
    func addFavoriteEvent(event: Event)
    func removeFavoriteEvent(event: Event)
    func eventIsFavorite(event: Event) -> Bool
}
