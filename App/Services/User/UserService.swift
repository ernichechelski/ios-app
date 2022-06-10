//
//  UserService.swift
//  App
//
//  Created by Ernest Chechelski on 06/06/2022.
//

import Combine

protocol UserService {
    func login(username: String, password: String) -> AnyPublisher<Void, Error>
    func isLoggedIn() -> AnyPublisher<Bool, Error>
}
