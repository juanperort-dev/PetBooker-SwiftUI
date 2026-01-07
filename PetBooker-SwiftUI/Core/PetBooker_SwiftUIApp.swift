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
    @StateObject private var container: DIContainer
    @StateObject private var appCoordinator: AppCoordinator
    
    init() {
        let localContainer = DIContainer()
        _container = StateObject(wrappedValue: localContainer)
        _appCoordinator = StateObject(wrappedValue: localContainer.makeAppCoordinator())
    }
    
    var body: some Scene {
        WindowGroup {
            Group {
                switch appCoordinator.appScreen {
                case .splash:
                    SplashView()
                case .unauthenticated:
                    if let authCoordinator = appCoordinator.authCoordinator {
                        AuthFlowView()
                            .environmentObject(authCoordinator)
                    } else {
                        Color.clear
                    }
                case .authenticated:
                    if let mainCoordinator = appCoordinator.mainCoordinator {
                        MainFlowView()
                            .environmentObject(mainCoordinator)
                    } else {
                        Color.clear
                    }
                }
            }
            .environmentObject(container)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
}

