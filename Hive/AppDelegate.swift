//
//  AppDelegate.swift
//  Hive
//
//  Created by  Danielle Lancashireon 28/04/2015.
//  Copyright (c) 2015 Rocket Apps. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        return true
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        let accessToken = url.descriptiong.componentsSeparatedByString("=")[1]
        println("Access Token: \(accessToken)")
        
        return true
    }
}

