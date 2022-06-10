//
//  Result+SwiftUI.swift
//  App
//
//  Created by Ernest Chechelski on 06/06/2022.
//

import SwiftUI

extension Result where Success: View {
    /// Returns contents if there is no error. Returns error if is thrown.
    @ViewBuilder var contents: some View {
        switch self {
        case let .success(view):
            view
        case let .failure(error):
            Text(error.localizedDescription)
                .foregroundColor(Color.red)
        }
    }
}

extension Result: View where Success: View {
    public var body: some View {
        contents
    }
}
