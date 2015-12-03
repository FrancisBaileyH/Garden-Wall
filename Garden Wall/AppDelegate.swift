//
//  AppDelegate.swift
//  Garden Wall
//
//  Created by Francis Bailey on 2015-11-25.
//  Copyright © 2015 Francis Bailey. All rights reserved.
//

import UIKit
import GBVersionTracking


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        GBVersionTracking.track()
        initializeSharedDirectoryFiles()
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    
    /*
    * Initialize shared directory files if they do not exist yet
    * This includes a whitelist file & a blockerList file
    *
    * @TODO
    * Add lock to ensure writing/reading of files occurs synchronously
    */
    func initializeSharedDirectoryFiles() {
        
        let fileManager     = NSFileManager.defaultManager()
        let groupURL        = ContentBlockerFileManager.sharedInstance.getSharedDirectoryURL()
        let whitelistURL    = NSURL(string: "whitelist.json", relativeToURL: groupURL)
        let blockerListURL  = NSURL(string: "blockerList.json", relativeToURL: groupURL)
        let blockerListPath = NSBundle.mainBundle().pathForResource("blockerList", ofType: "json")
        
        do {

            if GBVersionTracking.isFirstLaunchEver() {
                fileManager.createFileAtPath((whitelistURL?.path)!, contents: nil, attributes: nil)
            }
            if GBVersionTracking.isFirstLaunchForBuild() {
                try fileManager.copyItemAtPath(blockerListPath!, toPath: blockerListURL!.path!)
            }
        }
        catch {
            
        }
    }


}

