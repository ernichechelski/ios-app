//
//  AppFrozenScreenFactory.swift
//  App
//
//  Created by Ernest Chechelski on 10/06/2022.
//

import SwiftUI
import Swinject
import App_Design_System

enum AppFrozenScreenFactoryEvents {
    enum RootEvent {
        case onAppUnlocked
        case onDetailsTapped
    }
}

protocol AppFrozenScreenFactory {
    func makeRoot(onEvent: ((AppFrozenScreenFactoryEvents.RootEvent) -> Void)?) -> IdentifableScreen
}

final class DefaultAppFrozenScreenFactory: AppFrozenScreenFactory {

    var container: Container

    init(container: Container) {
        self.container = container
    }

    func makeRoot(onEvent: ((AppFrozenScreenFactoryEvents.RootEvent) -> Void)?) -> IdentifableScreen {
        VStack {
            Button {
                onEvent?(.onAppUnlocked)
            } label: {
                Text("Unlock the app")
            }
            .buttonStyle(PrimaryButton())
            Button {
                onEvent?(.onDetailsTapped)
            } label: {
                Text("Why the app is locked?")
            }
        }.asIdentifableScreen()
    }
}

