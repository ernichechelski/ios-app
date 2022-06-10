//
//  AppError.swift
//  App
//
//  Created by Ernest Chechelski on 06/06/2022.
//

import Foundation

enum AppError: LocalizedError {
    case development
    case dependencyInjection(type: Any.Type)
    case arc

    var errorDescription: String? {
        switch self {
        case .arc: return "Memory allocation error"
        case .development: return "Development error"
        case let .dependencyInjection(type): return "App could not load required component \(type)"
        }
    }

    var recoverySuggestion: String? {
        "Contact support"
    }
}
