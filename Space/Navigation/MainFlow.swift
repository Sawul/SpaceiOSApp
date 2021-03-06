//
//  MainRouter.swift
//  Space
//
//  Created by Mateusz Sawa on 14/12/2020.
//

import Foundation
import Swinject
import Domain

enum MainStep {
    case start
    case launch(with: Launch)
}

protocol MainFlowable: Dismissable {
    var rootViewController: UINavigationController { get }
    func navigate(to step: MainStep)
}

class MainFlow: BaseFlow, MainFlowable {
    func navigate(to step: MainStep) {
        switch step {
        case .start:
            start()
        case let .launch(launch):
            showLaunch(launch)
        }
    }
    
    private func showLaunch(_ launch: Launch) {
        guard let viewController = resolver.resolve(LaunchController.self, argument: launch) else { return }
        rootViewController.pushViewController(viewController, animated: true)
    }
    
    private func start() {
        guard let viewController = resolver.resolve(LaunchesController.self) else { return }
        rootViewController.pushViewController(viewController, animated: true)
    }
}
