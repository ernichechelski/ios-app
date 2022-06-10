//
//  NavigationController.swift
//  App
//
//  Created by Ernest Chechelski on 07/06/2022.
//

import UIKit

final class NavigationController: UINavigationController {

    init() {
        super.init(rootViewController: UIViewController())
        delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NavigationController: UINavigationControllerDelegate {

    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return NavigationControllerAnimation(operation: operation)
    }

}

class NavigationControllerAnimation: NSObject, UIViewControllerAnimatedTransitioning {

    let operation: UINavigationController.Operation

    init(operation: UINavigationController.Operation) {
        self.operation = operation

        super.init()
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }

    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else { return }
        let containerView = transitionContext.containerView

        if operation == .push {
            toViewController.view.frame = containerView.bounds.offsetBy(dx: containerView.frame.size.width, dy: 0.0)

            containerView.addSubview(toViewController.view)

            UIView.animate(withDuration: transitionDuration(using: transitionContext),
                           delay: 0,
                           options: [ UIView.AnimationOptions.curveEaseOut ],
                           animations: {
                            toViewController.view.frame = containerView.bounds
                            fromViewController.view.frame = containerView.bounds.offsetBy(dx: -containerView.frame.size.width, dy: 0)
            },
                           completion: { (finished) in
                            transitionContext.completeTransition(true)
            })
        } else if operation == .pop {
            containerView.addSubview(toViewController.view)

            UIView.animate(withDuration: transitionDuration(using: transitionContext),
                           delay: 0,
                           options: [ UIView.AnimationOptions.curveEaseOut ],
                           animations: {
                            fromViewController.view.frame = containerView.bounds.offsetBy(dx: containerView.frame.width, dy: 0)
                            toViewController.view.frame = containerView.bounds
            },
                           completion: { (finished) in
                transitionContext.completeTransition(true)
            })
        }
    }
}
