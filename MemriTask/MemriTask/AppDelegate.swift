//
//  AppDelegate.swift
//  MemriTask
//
//  Created by ashokdy on 14/09/2021.
//

import UIKit
import Networking

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Setup base URL for Networking library
        APIServiceConfig.shared.setup(
            apiData: APIData(
                baseURL: "https://gist.githubusercontent.com/"
            )
        )
        return true
    }
}
