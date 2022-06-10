//
//  TodoView.swift
//  App
//
//  Created by Ernest Chechelski on 10/06/2022.
//

import SwiftUI

/// Use this view to indicate need of implementation.
/// If will you include some task description would be awesome (/◕ヮ◕)/
struct TodoView: View {

    var task: String = "Implement me"

    var body: some View {
        Text("TODO \(task)")
    }
}
