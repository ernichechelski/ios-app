//
//  RootScreenView.swift
//  App
//
//  Created by Ernest Chechelski on 06/06/2022.
//

import SwiftUI

struct RootScreenView: View {

    @StateObject var viewModel: RootScreenViewModel

    var body: some View {
        Text("Hello, Root Screen!")
    }
}

struct RootScreenView_Previews: PreviewProvider {
    static var previews: some View {
        RootScreenView(viewModel: RootScreenViewModel())
    }
}
