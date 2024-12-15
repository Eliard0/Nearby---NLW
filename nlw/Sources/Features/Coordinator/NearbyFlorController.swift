//
//  NearbyFlorController.swift
//  nlw
//
//  Created by Eliardo Venancio on 10/12/24.
//

import Foundation
import UIKit

class NearbyFlorController {
    
    private var navigationController: UINavigationController?
    
    public init() {}
    
    func start() -> UINavigationController? {
        let contentView = SplashView()
//        let startViewController = SplashViewController(contentView: contentView, delegate: self)
        let startViewController = HomeViewController()
        self.navigationController = UINavigationController(rootViewController: startViewController)
        
        return navigationController
    }
}

extension NearbyFlorController: SplashFlowDelegate {
    func decideNavigationFlow() {
        let contentView = WelcomeView()
        let welcomeViewController = WelcomeViewController(contentView: contentView)
        navigationController?.pushViewController(welcomeViewController, animated: true)
    }
}
