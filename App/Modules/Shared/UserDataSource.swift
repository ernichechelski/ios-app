//
//  userDataSource.swift
//  App
//
//  Created by Ernest Chechelski on 06/06/2022.
//

import Combine

final class UserDataSource {

    private var cancellables = Set<AnyCancellable>()

    private let userService: UserService

    init(userService: UserService) {
        self.userService = userService
    }

    func login(username: String, password: String) -> FormState<Void> {
        userService
            .login(username: username, password: password)
            .sink(cancellables: &cancellables)
    }

    func isLoggedIn(_ result: @escaping (Result<Bool, Error>) -> Void = { _ in }) -> FormState<Bool> {
        userService
            .isLoggedIn()
            .sink(cancellables: &cancellables, result: result)
    }
}
