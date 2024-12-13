//
//  SplashViewController.swift
//  nlw
//
//  Created by Eliardo Venancio on 10/12/24.
//

import Foundation
import UIKit

class SplashViewController: UIViewController{
    let contentView: SplashView
    weak var delegate: SplashFlowDelegate?
    
    init(contentView: SplashView, delegate: SplashFlowDelegate){
        self.contentView = contentView
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        decideFlow()
    }
    
    func setUp() {
        self.view.addSubview(contentView)
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = Colors.greenLight
        
        setConstraints()
    }
    
    func setConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func decideFlow(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){ [weak self] in
            self?.delegate?.decideNavigationFlow()
        }
    }
}
