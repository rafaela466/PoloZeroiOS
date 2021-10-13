//
//  Polo_Zero_2_0App.swift
//  Polo Zero 2.0
//
//  Created by Rafaela Santos on 03/02/2021.
//

import SwiftUI
import Firebase

import UserNotifications

@main
struct Polo_Zero_2_0App: App {
   @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(Shop())
            
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
           
            FirebaseApp.configure()
            return true
        }
}
