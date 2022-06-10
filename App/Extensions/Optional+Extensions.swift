//
//  Optional+Extensions.swift
//  App
//
//  Created by Ernest Chechelski on 06/06/2022.
//

import Foundation

extension Optional {
    /// Throws error if no data required
    func throwing(error: Error = AppError.development) throws -> Wrapped {
        if let wrapped = self {
            return wrapped
        } else {
            throw error
        }
    }
}
