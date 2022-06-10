//
//  FormStateContainerView.swift
//  App
//
//  Created by Ernest Chechelski on 06/06/2022.
//

import SwiftUI

struct FormStateContainerView<T>: View {

    @StateObject var formState: FormState<T>

    var body: some View {
        VStack {
            if formState.showLoading {
               ProgressView("Loading...")
                   .progressViewStyle(CircularProgressViewStyle(tint: .purple))
            } else if formState.showSuccess {
               Text("Success")
            } else {
                Text("Idle")
            }
        }
    }
}
