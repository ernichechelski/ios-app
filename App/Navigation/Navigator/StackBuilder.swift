//
//  StackBuilder.swift
//  App
//
//  Created by Ernest Chechelski on 06/06/2022.
//

import SwiftUI

@resultBuilder
struct StackBuilder {
    static func buildBlock() -> [IdentifableScreen] { [] }

    func makeIdentifableScreens(@StackBuilder _ content: () -> [IdentifableScreen]) -> [IdentifableScreen] {
        content()
    }

    static func buildBlock(_ settings: IdentifableScreen...) -> [IdentifableScreen] {
        settings
    }
}

extension StackBuilder {

    static func buildBlock(_ components: [IdentifableScreen]...) -> [IdentifableScreen] {
        components.flatMap { $0 }
    }

    static func buildBlock(_ values: IdentifableScreenConvertible...) -> [IdentifableScreen] {
        values.flatMap { $0.asIdentifableScreen() }
    }

    public static func buildBlock<C0>(_ c0: C0) -> [IdentifableScreen] where C0 : View {
        [
            Navigator.NavigatorView {
                c0
            }
        ]
    }

    public static func buildBlock<C0>(_ c0: C0) -> [IdentifableScreen] where C0 : IdentifableScreen {
        [
            c0
        ]
    }

    public static func buildBlock<C0, C1>(_ c0: C0, _ c1: C1) -> [IdentifableScreen] where C0 : View, C1 : View {
        [
            Navigator.NavigatorView {
                c0
            },
            Navigator.NavigatorView {
                c1
            }
        ]
    }

    public static func buildBlock<C0, C1>(_ c0: C0, _ c1: C1) -> [IdentifableScreen] where C0 : IdentifableScreen, C1 : IdentifableScreen {
        [
            c0,
            c1
        ]
    }

    public static func buildBlock<C0, C1, C2>(_ c0: C0, _ c1: C1, _ c2: C2) -> [IdentifableScreen] where C0 : View, C1 : View, C2 : View {
        [
            Navigator.NavigatorView {
                c0
            },
            Navigator.NavigatorView {
                c1
            },
            Navigator.NavigatorView {
                c2
            }
        ]
    }

    public static func buildBlock<C0, C1, C2, C3>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3) -> [IdentifableScreen] where C0 : View, C1 : View, C2 : View, C3 : View {
        [
            Navigator.NavigatorView {
                c0
            },
            Navigator.NavigatorView {
                c1
            },
            Navigator.NavigatorView {
                c2
            },
            Navigator.NavigatorView {
                c3
            }
        ]
    }

    static func buildBlock(_ components: IdentifableScreenGroup...) -> [IdentifableScreen] {
         return components.flatMap { $0.screens }
     }

     static func buildOptional(_ component: [IdentifableScreenGroup]?) -> [IdentifableScreen] {
         return component?.flatMap { $0.screens } ?? []
     }

     static func buildEither(first component: [IdentifableScreenGroup]) -> [IdentifableScreen] {
         return component.flatMap { $0.screens }
     }

     static func buildEither(second component: [IdentifableScreenGroup]) -> [IdentifableScreen] {
         return component.flatMap { $0.screens }
     }

    static func buildEither(second component: IdentifableScreenGroup) -> [IdentifableScreen] {
        return component.screens
    }
}
