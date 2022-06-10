//
//  AppManager.swift
//  App
//
//  Created by Ernest Chechelski on 07/06/2022.
//

import SwiftUI
import Swinject

final class AppManager: ObservableObject {

    @Published var navigator = Navigator() {
        EmptyView()
    }

    private let appContainer = with(Container()) {
        AppContainer.build(in: $0)
    }

    private var appRepository: AppRepository!

    private var appCoordinator: AppCoordinator!

    init() {
        do {
            appRepository = try AppRepository(
                container: appContainer
            )

            appCoordinator = try AppCoordinator(
               navigator: navigator,
               container: appContainer,
               appRepository: appRepository
            )

            appCoordinator.begin()
        } catch {
            fatalAppError(error)
        }
    }
}
