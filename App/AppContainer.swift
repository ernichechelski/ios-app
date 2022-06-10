//
//  AppContainer.swift
//  App
//
//  Created by Ernest Chechelski on 07/06/2022.
//

import Foundation
import Swinject

protocol ContainerBuilder {
    static func build(in container: Container)
}

// App dependency management. It is possible to define child containers in same way.
enum AppContainer: ContainerBuilder {
    static func build(in container: Container) {
        // MARK: - Base components of the app
        CommonContainer.build(in: container)
        #if DEBUG
        PreviewServicesContainer.build(in: container)
        #else
        RealServicesContainer.build(in: container)
        #endif
    }
}
