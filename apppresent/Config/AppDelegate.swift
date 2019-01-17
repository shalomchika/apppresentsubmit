//
//  AppDelegate.swift
//  apppresent
//
//  Created by Macbook Pro on 21/12/2018.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        setupApp()
        return true
    }

    func setupApp() {
        window = UIWindow(frame: UIScreen.main.bounds)
        if Setting.didLogin {
            window!.rootViewController = AppTabViewController.create()
        } else {
            window!.rootViewController = UINavigationController(rootViewController: LoginViewController.create())
        }
        window!.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
    }

    @objc private func hideKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
}

