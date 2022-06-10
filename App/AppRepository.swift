//
//  AppRepository.swift
//  App
//
//  Created by Ernest Chechelski on 06/06/2022.
//

import SwiftUI
import Swinject

final class AppRepository: ObservableObject {

    var userDataSource: UserDataSource

    private var userService: UserService

    init(container: Container) throws {
        userService = try container.resolveThrowing(UserService.self)
        userDataSource = try container.resolveThrowing(UserDataSource.self)
    }
}
