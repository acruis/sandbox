//
//  AppDelegate.swift
//  UIViewEncapsulatedLayoutConstraints
//
//  Created by Nguyen Quoc Dat on 20/6/18.
//  Copyright © 2018 Nguyen Quoc Dat. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .white
        self.window?.makeKeyAndVisible()
        
        let rootViewController = ViewController(nibName: nil, bundle: nil)
        self.window?.rootViewController = rootViewController
        
        return true
    }

}
