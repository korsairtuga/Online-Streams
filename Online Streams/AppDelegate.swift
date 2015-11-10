//
//  AppDelegate.swift
//  Online Streams
//
//  Created by Joshua Liebowitz on 11/9/15.
//  Copyright © 2015 Joshua Liebowitz. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)

        let splitViewController = UISplitViewController(nibName: nil, bundle: nil)
        let streamViewController = StreamViewController()
        streamViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem()
//        streamViewController.navigationItem.leftItemsSupplementBackButton = true
        splitViewController.viewControllers = [ViewController(style: .Grouped), streamViewController]
        splitViewController.delegate = self

        self.window?.rootViewController = splitViewController
        self.window?.makeKeyAndVisible()
        return true
    }


    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController:UIViewController, ontoPrimaryViewController primaryViewController:UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsDetailController = secondaryAsNavController.topViewController as? StreamViewController else { return false }
        if topAsDetailController.detailItem == nil {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
            return true
        }
        return false
    }

}

