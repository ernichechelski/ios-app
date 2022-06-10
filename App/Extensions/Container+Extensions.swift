//
//  Container+Extensions.swift
//  App
//
//  Created by Ernest Chechelski on 10/06/2022.
//

import Swinject

extension Container {

    /// Tries to resolve dependency. Throws error over wise.
    func resolveThrowing<Service>(_ serviceType: Service.Type) throws -> Service {
        try resolve(serviceType)
        .throwing(error: AppError.dependencyInjection(type: serviceType))
    }
}
