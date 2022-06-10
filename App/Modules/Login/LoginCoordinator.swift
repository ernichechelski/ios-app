//
//  LoginCoordinator.swift
//  App
//
//  Created by Ernest Chechelski on 06/06/2022.
//

import Swinject

final class LoginCoordinator: BaseCoordinator {

    override func begin() {
        navigator.set {
            LoginScreenView()
                .onAppear { [weak self] in
                    self?.goToRoot()
                }
        }
    }

    func goToRoot() {
        beginChild {
            try RootCoordinator(
                navigator: navigator,
                container: container,
                appRepository: appRepository
            )
        }
    }
}
