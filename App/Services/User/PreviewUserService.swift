//
//  PreviewUserService.swift
//  App
//
//  Created by Ernest Chechelski on 10/06/2022.
//

import Combine
import Foundation

final class PreviewUserService: UserService {
    func login(username: String, password: String) -> AnyPublisher<Void, Error> {
        AnyPublisher<Void, Error>.stub(value: ())
    }

    func isLoggedIn() -> AnyPublisher<Bool, Error> {
        Fail(error: AppError.development)
            .delay(for: 3, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
//        AnyPublisher<Bool, Error>.stub(value: true)
//            .delay(for: 3, scheduler: RunLoop.main)
//            .eraseToAnyPublisher()
    }
}
