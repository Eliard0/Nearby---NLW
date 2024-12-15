//
//  HomeView.swift
//  nlw
//
//  Created by Eliardo Venancio on 13/12/24.
//
import Foundation
import UIKit
import MapKit

class HomeView: UIView {
    private var filterButtonAction: ((Category) -> Void)?
    private var categories: [Category] = []
    private var selectedButton: UIButton?
    
    let mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        
        return map
    }()
    
    private let filterScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isUserInteractionEnabled = true
        
        return scrollView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.backgroundColor = Colors.gray100
        
        return view
    }()
    
    private let dragIndecatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 3
        view.backgroundColor = Colors.gray300
        
        return view
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Explore locais perto de voce"
        label.font = Typography.textMD
        label.textColor = Colors.gray600
        
        return label
    }()
    
    private let filterStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 9
        stackView.isUserInteractionEnabled = true
        stackView.distribution = .fill
        
        return stackView
    }()
    
    private let placeTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PlaceTableViewCell.self, forCellReuseIdentifier: PlaceTableViewCell.identifier)
        
        return tableView
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var containerTopConstrant: NSLayoutConstraint!
    
    private func setupUI(){
        addSubview(mapView)
        addSubview(filterScrollView)
        addSubview(containerView)
        
        filterScrollView.addSubview(filterStackView)

        containerView.addSubview(dragIndecatorView)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(placeTableView)
        
        setConstraints()
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: topAnchor),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.65),
            
            filterScrollView.topAnchor.constraint(equalTo: topAnchor, constant: 48),
            filterScrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            filterScrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            filterScrollView.heightAnchor.constraint(equalToConstant: 86),
            
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            filterStackView.topAnchor.constraint(equalTo: filterScrollView.topAnchor),
            filterStackView.leadingAnchor.constraint(equalTo: filterScrollView.leadingAnchor),
            filterStackView.trailingAnchor.constraint(equalTo: filterScrollView.trailingAnchor),
            filterStackView.bottomAnchor.constraint(equalTo: filterScrollView.bottomAnchor),
            filterStackView.heightAnchor.constraint(equalTo: filterScrollView.heightAnchor),
        ])
        
        containerTopConstrant = containerView.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -16)
        containerTopConstrant.isActive = true
        
        NSLayoutConstraint.activate([
            dragIndecatorView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            dragIndecatorView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            dragIndecatorView.widthAnchor.constraint(equalToConstant: 80),
            dragIndecatorView.heightAnchor.constraint(equalToConstant: 4),
            
            descriptionLabel.topAnchor.constraint(equalTo: dragIndecatorView.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            
            placeTableView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            placeTableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            placeTableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            placeTableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
        ])
    }
    
    func configureTableViewDelagate(_ delegate: UITableViewDelegate, dataSource: UITableViewDataSource){
        placeTableView.delegate = delegate
        placeTableView.dataSource = dataSource
    }
    
    func updateFilterButtons(with categories: [Category], action: @escaping (Category) -> Void){
        let categoryIcon: [String: String] = [
            "Alimentação": "fork.knife",
            "Compras": "cart",
            "Hospedagem": "bed.double",
            "Padaria": "cup.and.saucer",
        ]
        
        self.categories = categories
        self.filterButtonAction = action
        
        for (index, category) in categories.enumerated(){
            let iconName = categoryIcon[category.name] ?? "questionMark.circle"
            let button = createFilterButton(title: category.name, iconName: iconName)
            button.tag = index
            button.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
            filterStackView.addArrangedSubview(button)
        }
    }
    
    private func createFilterButton(title: String, iconName: String) -> UIButton {
            let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle(title, for: .normal)
            button.setImage(UIImage(systemName: iconName), for: .normal)
            button.layer.cornerRadius = 8
            button.tintColor = Colors.gray600
            button.layer.borderWidth = 1
            button.layer.borderColor = Colors.gray300.cgColor
            button.backgroundColor = Colors.gray100
            button.setTitleColor(Colors.gray600, for: .normal)
            button.titleLabel?.font = Typography.textSM
            button.titleLabel?.adjustsFontSizeToFitWidth = false
            button.titleLabel?.lineBreakMode = .byClipping
            button.titleLabel?.numberOfLines = 1
            button.heightAnchor.constraint(equalToConstant: 36).isActive = true
            button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
            button.imageView?.contentMode = .scaleAspectFit
            button.imageView?.heightAnchor.constraint(equalToConstant: 16).isActive = true
            button.imageView?.widthAnchor.constraint(equalToConstant: 16).isActive = true
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)

            
            return button
        }
}
