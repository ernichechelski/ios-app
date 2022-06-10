//
//  IdentifableScreen.swift
//  App
//
//  Created by Ernest Chechelski on 06/06/2022.
//

import SwiftUI

protocol IdentifableScreen  {
    var uuid: UUID { get }

    var contents: AnyView { get }
}
