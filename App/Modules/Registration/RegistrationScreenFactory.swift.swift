//
//  RegistrationScreenFactory.swift.swift
//  App
//
//  Created by Ernest Chechelski on 10/06/2022.
//

import SwiftUI
import Swinject

enum RegistrationScreenFactoryEvents {
    enum RootEvent {
        case onSomething
    }
}

protocol RegistrationScreenFactory {
    func makeRoot(onEvent: ((RegistrationScreenFactoryEvents.RootEvent) -> Void)?) -> IdentifableScreen
}

final class DefaultRegistrationScreenFactory: RegistrationScreenFactory {

    var container: Container

    init(container: Container) {
        self.container = container
    }

    func makeRoot(onEvent: ((RegistrationScreenFactoryEvents.RootEvent) -> Void)?) -> IdentifableScreen {
        TodoView(task: "Registration flow").asIdentifableScreen()
    }
}
