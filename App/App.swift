//
//  AppApp.swift
//  App
//
//  Created by Ernest Chechelski on 06/06/2022.
//

import SwiftUI

@main
struct MainApp: App {

    @StateObject var appManager = AppManager()

    var body: some Scene {
        WindowGroup {
            NavigatorContainer()
                .environmentObject(appManager.navigator)
        }
    }
}
