//
//  RegistrationCoordinator.swift
//  App
//
//  Created by Ernest Chechelski on 10/06/2022.
//

import Foundation

import Swinject

final class RegistrationCoordinator: BaseCoordinator {

    private let screenFactory: RegistrationScreenFactory

    override init(navigator: Navigator, container: Container, appRepository: AppRepository) throws {
        self.screenFactory = try container
            .resolveThrowing(RegistrationScreenFactory.self)
        try super.init(navigator: navigator, container: container, appRepository: appRepository)
    }

    override func begin() {
        navigator.set {
            screenFactory.makeRoot { _ in }
        }
    }
}
