//
//  AppDelegate.swift
//  Reciper Keeper
//
//  Created by Alice Mai Tu on 10/5/18.
//  Copyright © 2018 Alice Mai Tu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func brandPalette(_ color: BrandColor) -> UIColor {
        switch color {
        case .blue:
            return UIColor(red: 203.0/255.0, green: 97.0/255.0, blue: 76.0/255.0, alpha: 1.0)
        case .lightBlue:
            return UIColor(red: 132.0/255.0, green: 188.0/255.0, blue: 218.0/255.0, alpha: 1.0)
        case .yellow:
            return UIColor(red: 236.0/255.0, green: 195.0/255.0, blue: 11.0/255.0, alpha: 1.0)
        case .orange:
            return UIColor(red: 243.0/255.0, green: 119.0/255.0, blue: 72.0/255.0, alpha: 1.0)
        case .pink:
            return UIColor(red: 213.0/255.0, green: 96.0/255.0, blue: 98.0/255.0, alpha: 1.0)
        }
    }
    
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // Navigation bar styling
        UINavigationBar.appearance().barTintColor = brandPalette(.yellow)
        UINavigationBar.appearance().tintColor = UIColor.darkGray
        //UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.darkGray]
        UIApplication.shared.statusBarStyle = .lightContent
        return true
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

