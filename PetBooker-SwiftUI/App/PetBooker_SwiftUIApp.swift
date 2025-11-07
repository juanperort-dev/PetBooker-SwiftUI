//
//  PetBooker_SwiftUIApp.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 21/5/25.
//

import SwiftUI

@main
struct PetBooker_SwiftUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var appCoordinator = AppCoordinator()
    
    var body: some Scene {
        WindowGroup {
            switch appCoordinator.appState {
            case .splash:
                SplashView()
            case .unauthenticated:
                AuthFlowView()
                    .environmentObject(appCoordinator.authCoordinator)
            case .authenticated:
                MainFlowView()
                    .environmentObject(appCoordinator.mainCoordinator)
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
}

