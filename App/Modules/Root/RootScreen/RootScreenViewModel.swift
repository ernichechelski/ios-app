//
//  RootScreenViewModel.swift
//  App
//
//  Created by Ernest Chechelski on 10/06/2022.
//

import Foundation

final class RootScreenViewModel: ObservableObject {
    var onEvent: ((RootScreenFactoryEvents.RootEvent) -> Void)?

    init(onEvent: ((RootScreenFactoryEvents.RootEvent) -> Void)? = nil) {
        self.onEvent = onEvent
    }
}
