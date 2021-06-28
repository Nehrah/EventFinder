//
//  AppDelegate.swift
//  EventFinder
//
// Created by Nethrah Ayyaswami on 06/28/2021

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var appCoordinator: AppCoordinator!
    private var appConfiguration: AppConfiguration!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        appConfiguration = AppConfiguration()
        appCoordinator = AppCoordinator(window: window!, appConfiguration: appConfiguration)
        appCoordinator.start()
        
        return true
    }
}

