//
//  ProgressContainerView.swift
//  App
//
//  Created by Ernest Chechelski on 06/06/2022.
//

import SwiftUI

struct ProgressContainerView<Content>: View where Content: View {

    @Binding var isShowing: Bool

    let presenting: () -> Content

    var body: some View {
        ZStack(alignment: .center) {
            presenting()
                .blur(radius: self.isShowing ? 1 : 0)
            ProgressView()
                .opacity(isShowing ? 1 : 0)
        }
    }
}
