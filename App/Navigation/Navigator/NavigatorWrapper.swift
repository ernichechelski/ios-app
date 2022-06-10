//
//  NavigatorWrapper.swift
//  App
//
//  Created by Ernest Chechelski on 06/06/2022.
//

import SwiftUI

struct NavigatorWrapper: View {

    @StackBuilder var builder: () -> [IdentifableScreen]

    var body: some View {
        NavigatorStrongContainer(
            navigator: Navigator(builder: builder)
        )
    }
}
