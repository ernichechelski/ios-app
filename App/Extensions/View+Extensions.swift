//
//  View+Extensions.swift
//  App
//
//  Created by Ernest Chechelski on 06/06/2022.
//

import SwiftUI

extension View {
    func environmentScreenIdentifier(_ screenIdentifier: UUID) -> some View {
        environment(\.screenIdentifier, screenIdentifier)
    }
}

extension View {
    func hosted(uuid: UUID = UUID()) -> UIViewController {
        UUIDHostingViewController(view: self, uuid: uuid)
    }

    @discardableResult func uuid(reader: @escaping (UUID) -> Void) -> some View {
        UUIDGetter { uuid -> Self in
            reader(uuid)
            return self
        }
    }
}


/// Modifier for getting frame of given view.
/// Use `.read` method in View extension if possible.
struct FrameGeometryReader: ViewModifier {
    @Binding var frame: CGRect

    func body(content: Content) -> some View {
        GeometryReader { geometry -> Color in
            DispatchQueue.main.async {
                self.frame = geometry.frame(in: .global)
            }
            return Color.clear
        }
    }
}

extension View {
    // MARK: UIKit related.

    var hosted: UIViewController {
        let viewController = UIHostingController(rootView: self)
        return viewController
    }

    var hostedWithHiddenNavigation: UIViewController {
        NavigationHidingHostingController(rootView: self)
    }

    // MARK: - Defining layout.

    func fillWidth(alignment: Alignment = .top) -> some View {
        frame(maxWidth: .infinity, alignment: alignment)
    }

    func fill(alignment: Alignment = .top) -> some View {
        frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
    }

    func fillHeight(alignment: Alignment = .center) -> some View {
        frame(maxHeight: .infinity, alignment: alignment)
    }

    func fillScreen() -> some View {
        frame(width: UIScreen.width, height: UIScreen.height)
    }

    func fillScreenWidth() -> some View {
        frame(width: UIScreen.width)
    }

    func fillScreenHeight() -> some View {
        frame(height: UIScreen.height)
    }

    func fillAtLeastScreenHeight() -> some View {
        frame(minHeight: UIScreen.height)
    }

    /// Converts the instance of Self view to `AnyView`
    func asAnyView() -> AnyView {
        AnyView(self)
    }

    /// Converts the instance of Self view to `AnyView`
    func asIdentifableScreen(uuid: UUID = UUID()) -> IdentifableScreen {
        Navigator.NavigatorView(uuid: uuid) {
            self
        }
    }

    /// Get frame of a given view.
    func read(frame: Binding<CGRect>) -> some View {
        overlay(Color.clear.modifier(FrameGeometryReader(frame: frame)))
    }
}

extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

extension View {
    /// Shows the progress HUD when the form is in loading state.
    func progressHUD(_ isShowing: Binding<Bool>) -> some View {
        ProgressContainerView(
            isShowing: isShowing
        ) {
            self
        }
    }
}
