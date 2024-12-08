//
//  AppDelegate.swift
//  RickAndMorty
//
//  Created by Khaled on 05/12/2024.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let navigation = UINavigationController.init()
        navigation.isNavigationBarHidden = true
        appCoordinator = AppCoordinator(navCon: navigation)
        appCoordinator?.start()
        
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        return true
    }


}

