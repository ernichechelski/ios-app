//
//  CommonContainer.swift
//  App
//
//  Created by Ernest Chechelski on 07/06/2022.
//

import Swinject

enum CommonContainer: ContainerBuilder {
    static func build(in container: Container) {
        BusinessLogicContainer.build(in: container)
        ScreensContainer.build(in: container)
    }
}
