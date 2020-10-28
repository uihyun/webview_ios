//
//  AppDelegate.swift
//  FA Viewer
//
//  Created by Eunmo Yang on 5/19/18.
//  Copyright © 2018 Eunmo Yang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        var statusBarUIView: UIView? {
            if #available(iOS 13.0, *) {
                let tag = 3848245
                let keyWindow = UIApplication.shared.connectedScenes
                    .map({$0 as? UIWindowScene})
                    .compactMap({$0})
                    .first?.windows.first

                if let statusBar = keyWindow?.viewWithTag(tag) {
                    return statusBar
                } else {
                    let height = keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? .zero
                    let statusBarView = UIView(frame: height)
                    statusBarView.tag = tag
                    statusBarView.layer.zPosition = 999999

                    keyWindow?.addSubview(statusBarView)
                    return statusBarView
                }
            } else {
                if responds(to: Selector(("statusBar"))) {
                    return value(forKey: "statusBar") as? UIView
                }
            }
            return nil
          }
        
        // old one
//        if let statusbar = UIApplication.shared.value(forKey: "statusBar") as? UIView {
//            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
//            let blurView = UIVisualEffectView(effect: blurEffect)
//            blurView.frame = statusbar.bounds
//            blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//            statusbar.addSubview(blurView)
//            statusbar.sendSubviewToBack(blurView)
//        }
        
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

