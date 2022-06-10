//
//  BaseCoordinator.swift
//  App
//
//  Created by Ernest Chechelski on 06/06/2022.
//

import Foundation
import Swinject

class BaseCoordinator: NSObject, Coordinator {

    weak var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    var navigator: Navigator
    var container: Container
    var appRepository: AppRepository

    init(
        navigator: Navigator,
        container: Container,
        appRepository: AppRepository
    ) throws {
        self.navigator = navigator
        self.container = container
        self.appRepository = appRepository
    }

    func begin() {}
}
