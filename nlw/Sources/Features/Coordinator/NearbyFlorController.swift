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
        let startViewController = SplashViewController(contentView: contentView)
        self.navigationController = UINavigationController(rootViewController: startViewController)
        
        return navigationController
    }
}
