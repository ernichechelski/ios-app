//
//  ScreenIdentifierEnvironmentKey.swift
//  App
//
//  Created by Ernest Chechelski on 06/06/2022.
//

import SwiftUI

struct ScreenIdentifierEnvironmentKey: EnvironmentKey {
    static let defaultValue = UUID(uuidString: "00000000-0000-0000-0000-000000000000")!
}
