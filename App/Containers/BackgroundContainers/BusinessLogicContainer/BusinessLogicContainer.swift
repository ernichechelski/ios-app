//
//  BusinessLogicContainer.swift
//  App
//
//  Created by Ernest Chechelski on 10/06/2022.
//

import Foundation

enum BusinessLogicContainer: ContainerBuilder {
    static func build(in container: Container) {
        container.register(UserDataSource.self) { resolver in
            UserDataSource(
                userService: resolver.resolve(UserService.self)!
            )
        }
    }
}
