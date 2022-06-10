//
//  PreviewServicesContainer.swift
//  App
//
//  Created by Ernest Chechelski on 07/06/2022.
//

import Swinject

enum PreviewServicesContainer: ContainerBuilder {
    static func build(in container: Container) {
        container.register(UserService.self) { _ in
            PreviewUserService()
        }
    }
}
