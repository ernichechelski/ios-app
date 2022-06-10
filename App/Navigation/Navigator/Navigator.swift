//
//  Navigator.swift
//  App
//
//  Created by Ernest Chechelski on 06/06/2022.
//

import SwiftUI

final class Navigator: ObservableObject {
    var navigationController: UINavigationController

    init(
        navigationController: UINavigationController = UINavigationController(),
        @StackBuilder builder: () -> [IdentifableScreen] = { [] }
    ) {
        self.navigationController = navigationController
        self.set(animated: false, builder: builder)
    }

    func push<T: View>(view: T, uuid: UUID = UUID(), animated: Bool = true) {
        let vc = view.environmentObject(self).environmentScreenIdentifier(uuid).hosted(uuid: uuid)
        navigationController.pushViewController(vc, animated: animated)
    }

    func present<T: View>(view: T, uuid: UUID = UUID(), animated: Bool = true) {
        let vc = NavigatorWrapper { view.environmentScreenIdentifier(uuid) }.hosted(uuid: uuid)
        UIApplication.rootViewController?.present(vc, animated: animated)
    }

    struct NavigatorView<T: View>: IdentifableScreen {
        var contents: AnyView {
            AnyView(getView())
        }

        let view: T
        var uuid: UUID = UUID()

        init(uuid: UUID = UUID(), _ builder: () -> T) {
            self.uuid = uuid
            self.view = builder()
        }

        func getView() -> some View {
            view
        }
    }

    @Published var topScreen: IdentifableScreen?

    private var topScreenFromNavigation: IdentifableScreen? {
        navigationController.topViewController as? IdentifableScreen
    }

    var screens: [IdentifableScreen] {
        navigationController.viewControllers.compactMap {
            $0 as? IdentifableScreen
        }
    }

    func push(animated: Bool = true, @StackBuilder builder: () -> [IdentifableScreen]) {
        with(navigationController.setViewControllers(navigationController.viewControllers +  IdentifableScreenGroup { builder() }.screens.map { view in
            view.contents.environmentObject(self).hosted(uuid: view.uuid)
        }, animated: animated)) { _ in
            self.commit()
        }
    }

    func present(animated: Bool = true, presentationStyle: UIModalPresentationStyle = .automatic, @StackBuilder builder: () -> [IdentifableScreen]) -> Navigator {
        let navigator = Navigator(builder: builder)
        let vc = NavigatorContainer().environmentObject(navigator).hosted
        vc.modalPresentationStyle = presentationStyle
        navigationController.present(vc, animated: animated)
        return navigator
    }

    func dismiss(animated: Bool = true) {
        self.navigationController.dismiss(animated: animated)
    }

    func set(animated: Bool = true, @StackBuilder builder: () -> [IdentifableScreen]) {
        with(navigationController.setViewControllers(IdentifableScreenGroup { builder() }.screens.map { view in
            view.contents.environmentObject(self).hosted(uuid: view.uuid)
        }, animated: animated)) { _ in
            self.commit()
        }
    }

    func push(group: IdentifableScreenGroup, animated: Bool = true) {
        with(navigationController.setViewControllers(navigationController.viewControllers + group.screens.map { view in
            view.contents.environmentObject(self).hosted(uuid: view.uuid)
        }, animated: animated)) { _ in
            self.commit()
        }
    }

    @discardableResult func pop(animated: Bool = true) -> IdentifableScreen? {
        with(navigationController.popViewController(animated: animated).flatMap {
            $0 as? IdentifableScreen
        }) { _ in
            self.commit()
        }
    }

    @discardableResult func popToRoot(animated: Bool = true) -> IdentifableScreen? {
        with(navigationController.popToRootViewController(animated: animated).flatMap {
            $0 as? IdentifableScreen
        }) { _ in
            self.commit()
        }
    }

    @discardableResult func pop(to: UUID, animated: Bool = true) -> [IdentifableScreen] {
        guard let match = navigationController.viewControllers.first (where: { viewController in
            (viewController as? IdentifableScreen)?.uuid == to
        }) else {
            return []
        }

        return with(navigationController.popToViewController(match, animated: animated)
            .flatMap {
                $0.compactMap {
                    $0 as? IdentifableScreen
                }
            } ?? []
        ) { _ in
            self.commit()
        }
    }

    private func commit() {
        topScreen = topScreenFromNavigation
        objectWillChange.send()
    }
}
