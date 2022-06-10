//
//  EnvironmentValues+ScreenIdentifier.swift
//  App
//
//  Created by Ernest Chechelski on 06/06/2022.
//

import SwiftUI

extension EnvironmentValues {
    var screenIdentifier: UUID {
        get { self[ScreenIdentifierEnvironmentKey.self] }
        set { self[ScreenIdentifierEnvironmentKey.self] = newValue }
    }
}
