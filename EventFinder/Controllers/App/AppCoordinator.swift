//
//  AppCoordinator.swift
//  EventFinder
//
//  Created by Nethrah Ayyaswami on 06/28/2021

import UIKit

class AppCoordinator: Coordinator {
    
    private let window: UIWindow
    private let appConfiguration: AppConfiguration
    
    private let eventSearchCoordinator: EventSearchCoordinator
    
    init(window: UIWindow, appConfiguration: AppConfiguration) {
        self.window = window
        self.appConfiguration = appConfiguration
        self.eventSearchCoordinator = EventSearchCoordinator(window: window, appConfiguration: appConfiguration)
    }
    
    func start() {
        eventSearchCoordinator.start()
    }
}
