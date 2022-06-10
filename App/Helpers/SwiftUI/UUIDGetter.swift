//
//  UUIDGetter.swift
//  App
//
//  Created by Ernest Chechelski on 06/06/2022.
//

import SwiftUI

struct UUIDGetter<Content: View>: View {
    @Environment(\.screenIdentifier) var screenIdentifier: UUID

    var content: (UUID) -> Content

    var body: some View {
        content(screenIdentifier)
    }
}
