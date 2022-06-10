//
//  RootScreenFactory.swift
//  App
//
//  Created by Ernest Chechelski on 10/06/2022.
//

import SwiftUI
import Swinject

enum RootScreenFactoryEvents {
    enum RootEvent {
        case onSettingsSelected
        case onLogout
    }
}

protocol RootScreenFactory {
    func makeRoot(onEvent: ((RootScreenFactoryEvents.RootEvent) -> Void)?) -> IdentifableScreen
}

final class DefaultRootScreenFactory: RootScreenFactory {

    var container: Container

    init(container: Container) {
        self.container = container
    }

    func makeRoot(onEvent: ((RootScreenFactoryEvents.RootEvent) -> Void)?) -> IdentifableScreen {
        RootScreenView(viewModel: RootScreenViewModel(onEvent: onEvent)).asIdentifableScreen()
    }
}

