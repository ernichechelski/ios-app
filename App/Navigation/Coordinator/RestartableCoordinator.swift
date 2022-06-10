//
//  RestartableCoordinator.swift
//  App
//
//  Created by Ernest Chechelski on 06/06/2022.
//

import SwiftUI

/// Coordinator which can be restarted even in various previous state of navigation controller.
protocol RestartableCoordinator: Coordinator {
    var previousView: IdentifableScreen? { get set }
    var firstView: IdentifableScreen { get }

    /// Called when the coordinator is finished by popViewController.
    func onCoordinatorClosed()
}

extension RestartableCoordinator {

    var screensiInFlowCount: Int {
        navigator.screens.count - (previousView.flatMap { previousView in
            navigator.screens.firstIndex { screen in
                screen.uuid == previousView.uuid
            }
        } ?? 0)
    }

    /// Restarts the coordinator, by presenting the first one.
    func restart() {
        if
            let previousView = previousView,
            let viewControllersCount = navigator.screens.firstIndex(where: { screen in screen.uuid == previousView.uuid })
        {
            //
            /*
             If already some navigation stack is build just insert seamlessly connection screen.
             Based on following approach.

             ```
             var initial = [1, 2, 3, 4, 9] // any previous stack

             initial += [10] // presenting any screen.

             let result = (initial.firstIndex(of: 9).flatMap { index in
                 initial.prefix(index + 1)
             } ?? []) + [13, 14, 15] // replacing [10] screen with [13, 14, 15]

             print(result) /// prints "[1, 2, 3, 4, 9, 13, 14, 15]"
             ```
             */
            navigator.set {
                firstView
            }
            navigator.set {
                Array(navigator.screens.prefix(viewControllersCount + 1)) + [
                    firstView
                ]
            }
        } else {
            // If navigation stack is empty just present correct screen.
            navigator.set {
                firstView
            }
        }
    }

    /// Checks if the coordinator has sufficient screens to pop. Closes over wise.
    func popViewController(animated: Bool = true) {
        if screensiInFlowCount - 1 > 0 {
            navigator.pop(animated: animated)
        } else {
            closeFlow()
        }
    }

    func closeFlow() {
        onCoordinatorClosed()
        coordinateToParent()
    }
}

