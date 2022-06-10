//
//  AppFrozenCoordinator.swift
//  App
//
//  Created by Ernest Chechelski on 10/06/2022.
//

import Swinject

final class AppFrozenCoordinator: BaseCoordinator {

    private let screenFactory: AppFrozenScreenFactory

    override init(navigator: Navigator, container: Container, appRepository: AppRepository) throws {
        self.screenFactory = try container
            .resolveThrowing(AppFrozenScreenFactory.self)
        try super.init(navigator: navigator, container: container, appRepository: appRepository)
    }

    private var innerNavigator: Navigator?

    override func begin() {
        innerNavigator = navigator.present(presentationStyle: .fullScreen) {
            screenFactory.makeRoot { [weak self] event in
                switch event {
                case .onAppUnlocked: self?.navigator.dismiss()
                }
            }
        }
    }
}
