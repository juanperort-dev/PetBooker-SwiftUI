//
//  PetBooker_SwiftUIApp.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 21/5/25.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn

@main
struct PetBooker_SwiftUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            SplashView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        return true
    }
}
