//
//  AppDelegate.swift
//  LandmarkRemark
//
//  Created by Parth on 30/11/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        decorateNavigationBarAppearance()
        
        //action based on current user status..
        if Auth.auth().currentUser != nil {
            // user is signed in
            self.redirectToHomeScreen()
        }
        else{
            // user is not signed in
            self.redirectToLandingScreen()
        }
        return true
    }
        
    func redirectToLandingScreen(){
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: LandingScreenVC(nibName: "LandingScreenVC", style: Style.landmarkRemark))
        window?.makeKeyAndVisible()
    }
    
    func redirectToHomeScreen(){
        window = UIWindow(frame: UIScreen.main.bounds)
        let locationProvider = CLLocationManager()
        let locationManager = LocationManager(with: locationProvider)
        locationProvider.delegate = locationManager
        let viewModel = HomeScreenViewModel(locationProvider: locationManager)
        window?.rootViewController = UINavigationController(rootViewController: HomeScreenVC(nibName: "HomeScreenVC", style: Style.landmarkRemark, viewModel: viewModel))
        window?.makeKeyAndVisible()
    }
    
    func decorateNavigationBarAppearance() {
        UINavigationBar.appearance().barTintColor = UIColor.landmarkRemarkTheme
        UINavigationBar.appearance().tintColor = UIColor.black
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

