//
//  NavigatorContainer.swift
//  App
//
//  Created by Ernest Chechelski on 06/06/2022.
//

import SwiftUI

struct NavigatorContainer: UIViewRepresentable {

    @EnvironmentObject var navigator: Navigator

    func makeUIView(context: Context) -> UIView {
        navigator.navigationController.view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
