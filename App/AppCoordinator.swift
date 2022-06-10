//
//  AppCoordinator.swift
//  App
//
//  Created by Ernest Chechelski on 06/06/2022.
//

import Foundation
import Swinject

final class AppCoordinator: BaseCoordinator {

    private let userDataSource: UserDataSource

    override init(
        navigator: Navigator,
        container: Container,
        appRepository: AppRepository
    ) throws {
        self.userDataSource = appRepository.userDataSource
        try super.init(navigator: navigator, container: container, appRepository: appRepository)
    }

    override func begin() {
        navigator.set(animated: false) {
            FormStateContainerView(
                formState: self.userDataSource.isLoggedIn { [weak self] result in
                    switch result {
                    case let .success(isLoggedIn):
                        if isLoggedIn {
                            self?.goToRoot()
                        } else {
                            self?.goToLogin()
                        }
                    case .failure:
                        self?.goToAppLocked()
                    }
                }
            )
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

    func goToLogin() {
        beginChild {
            try LoginCoordinator(
                navigator: navigator,
                container: container,
                appRepository: appRepository
            )
        }
    }

    func goToAppLocked() {
        beginChild {
            try AppFrozenCoordinator(
                navigator: navigator,
                container: container,
                appRepository: appRepository
            )
        }
    }
}
