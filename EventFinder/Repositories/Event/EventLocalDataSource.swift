//
//  EventLocalDataSource.swift
//  EventFinder
//
//  Created by Nethrah Ayyaswami on 06/28/2021on 9/19/19.
//  
//

import Foundation

class EventLocalDataSource: EventDataSource {
    
    var favoriteCache: Cache<Event>
    
    private let cacheName = "eventsCache"
    private let favoritesSet = "favoritesSet"
    
    init() {
        favoriteCache = Cache(cacheName: cacheName)
        
        #if DEBUG
        if ProcessInfo.processInfo.arguments.contains("UI-Testing") {
            favoriteCache = Cache(cacheName: "testEventsCache")
            favoriteCache.removeCache()
        }
        #endif
    }
    
    func queryEvents(query: String, completion: EventDataSourceCompletion?) {
        completion?(.success([Event]()))
    }
    
    func addFavoriteEvent(event: Event) {
        var existingFavorites = favoriteCache.object(key: favoritesSet) ?? Set<Event>()
        existingFavorites.insert(event)
        favoriteCache.setObject(object: existingFavorites, key: favoritesSet)
    }
    
    func removeFavoriteEvent(event: Event) {
        var existingFavorites = favoriteCache.object(key: favoritesSet) ?? Set<Event>()
        existingFavorites.remove(event)
        favoriteCache.setObject(object: existingFavorites, key: favoritesSet)
    }
    
    func eventIsFavorite(event: Event) -> Bool {
        let existingFavorites = favoriteCache.object(key: favoritesSet)
        return existingFavorites?.contains(event) ?? false
    }
}
