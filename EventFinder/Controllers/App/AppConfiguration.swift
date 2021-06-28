//
//  AppConfiguration.swift
//  EventFinder
//
//  Created by Nethrah Ayyaswami on 06/28/2021
//

import Foundation

class AppConfiguration {
    
    var networkManager: NetworkManager
    var eventRepository: EventRepository
    
    init() {
        networkManager = NetworkManager()
        eventRepository = EventRepository(networkManager: networkManager)
    }
}
