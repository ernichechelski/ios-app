//
//  ScreensContainer.swift
//  App
//
//  Created by Ernest Chechelski on 07/06/2022.
//

import Swinject


enum ScreensContainer: ContainerBuilder {
    static func build(in container: Container) {
        container.register(RootScreenFactory.self) { _ in
            DefaultRootScreenFactory(container: container)
        }
        
        container.register(AppFrozenScreenFactory.self) { _ in
            DefaultAppFrozenScreenFactory(container: container)
        }
    }
}


