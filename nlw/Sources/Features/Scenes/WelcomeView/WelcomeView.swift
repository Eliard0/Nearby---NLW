//
//  WelcomeVIew.swift
//  nlw
//
//  Created by Eliardo Venancio on 12/12/24.
//

import Foundation
import UIKit

class WelcomeView: UIView {
    var didTapButton: (() -> Void?)?
    
    private let logoImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "logo"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Bem vindo ao NEARBY"
        label.textColor = .black
        label.font = Typography.titleXL
        label.numberOfLines = 0

        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tenha cupns de vantagens para usar em seus estabelecimentos favoritos"
        label.numberOfLines = 0
        label.font = Typography.textMD
        label.textColor = .black
        
        return label
    }()
    
    private let subTextForTips: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Veja como funciona"
        label.numberOfLines = 0
        label.font = Typography.textMD
        label.textColor = .black
        
        return label
    }()
    
    private let TipsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 16
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let startButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Começar", for: .normal)
        button.backgroundColor = Colors.greenBase
        button.setTitleColor(Colors.gray100, for: .normal)
        button.titleLabel?.font = Typography.action
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        setupTips()
        addSubview(logoImageView)
        addSubview(welcomeLabel)
        addSubview(descriptionLabel)
        addSubview(subTextForTips)
        addSubview(TipsStackView)
        addSubview(startButton)
        
        setConstrants()
    }
    
    private func setConstrants(){
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            logoImageView.heightAnchor.constraint(equalToConstant: 48),
            logoImageView.widthAnchor.constraint(equalToConstant: 48),
            
            welcomeLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 24),
            welcomeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            
            descriptionLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),

            subTextForTips.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 50),
            subTextForTips.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            subTextForTips.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            TipsStackView.topAnchor.constraint(equalTo: subTextForTips.bottomAnchor, constant: 24),
            TipsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            TipsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            startButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40),
            startButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            startButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            startButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    private func setupTips(){
        guard let icon1 = UIImage(named: "mapIcon") else { return }
        
        let tip1 = TipsView(icon: icon1, title: "Encontre Estabeleciomentos", description: "Veja locais pertos de voce que sao NEARBY")
        
        let tip2 = TipsView(icon: UIImage(named: "qrcode") ?? UIImage(), title: "Ative o cupom com QR Code", description: "Escanei o código no estabeleciomento para usar o beneficio")
        
        let tip3 = TipsView(icon: UIImage(named: "ticket") ?? UIImage(), title: "Garanta vantagens perto de voce", description: "Ative cupom onde estiver, em diferentes tipos de estabeleciomentos")
        
        TipsStackView.addArrangedSubview(tip1)
        TipsStackView.addArrangedSubview(tip2)
        TipsStackView.addArrangedSubview(tip3)
    }
    
    @objc private func didTap(){
        didTapButton?()
    }
}
