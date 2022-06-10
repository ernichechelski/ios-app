//
//  RootCoordinator.swift
//  App
//
//  Created by Ernest Chechelski on 06/06/2022.
//

import Swinject

final class RootCoordinator: BaseCoordinator {

    private let screenFactory: RootScreenFactory

    override init(navigator: Navigator, container: Container, appRepository: AppRepository) throws {
        self.screenFactory = try container
            .resolveThrowing(RootScreenFactory.self)
        try super.init(navigator: navigator, container: container, appRepository: appRepository)
    }

    override func begin() {
        navigator.set {
            screenFactory.makeRoot { event in
                switch event {
                case .onSettingsSelected: break // - TODO: Implement me.
                case .onLogout: break // - TODO: Implement me.
                }
            }
        }
    }
}
