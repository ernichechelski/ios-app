//
//  IdentifableScreenGroup.swift
//  App
//
//  Created by Ernest Chechelski on 06/06/2022.
//

import Foundation

struct IdentifableScreenGroup: IdentifableScreensConvertable {
    var screens: [IdentifableScreen]

    init(@StackBuilder builder: () -> [IdentifableScreen]) {
        self.screens = builder()
    }
}
