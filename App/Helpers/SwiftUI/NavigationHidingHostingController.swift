//
//  NavigationHidingHostingController.swift
//  App
//
//  Created by Ernest Chechelski on 06/06/2022.
//

import SwiftUI

final class NavigationHidingHostingController<Content>: UIHostingController<AnyView> where Content: View {
    init(rootView: Content) {
        super.init(rootView: AnyView(rootView.navigationBarHidden(true)))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    @available(*, unavailable)
    @objc dynamic required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
