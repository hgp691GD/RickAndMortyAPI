//
//  RMLocationHorizontalCell.swift
//  RickAndMorty
//
//  Created by Horacio Parra Rodriguez on 29/06/23.
//

import Foundation
import UIKit

final class RMLocationCellViewModel: RMItemCellViewModel {
    
    private let location: RMLocation
    
    init(location: RMLocation) {
        self.location = location
        super.init(id: location.id)
    }
}

final class RMLocationHorizontalCell: UICollectionViewCell {
    
    private let container = UIView()
    private let nameLabel = UILabel()
    private let locationNameLabel = UILabel()
    private let typeLabel = UILabel()
    private let locationTypeLabel = UILabel()
    private let dimensionLabel = UILabel()
    private let locationDimensionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addContainer()
        addNameLabel()
        addLocationNameLabel()
        addtypeLabel()
        addLocationTypeLabel()
        addDimensionLabel()
        addLocationDimensionLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RMLocationHorizontalCell {
    
    private func addContainer() {
        addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: self.topAnchor, constant: 300),
            container.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -430),
            container.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            container.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40)
        ])
        
        container.layer.borderWidth = 2
        container.layer.cornerRadius = 10
        container.layer.borderColor = CGColor(red: 0, green: 100, blue: 1, alpha: 1)
        container.backgroundColor = .systemBackground
    }
    
    private func addNameLabel() {
        container.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
        ])
        nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        nameLabel.text = NSLocalizedString("Name:", comment: "")
        nameLabel.textColor = .black
    }
    
    private func addLocationNameLabel() {
        container.addSubview(locationNameLabel)
        locationNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationNameLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
            locationNameLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8)
        ])
        
        locationNameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        locationNameLabel.text = NSLocalizedString("Earth", comment: "")
        locationNameLabel.textColor = .black
        locationNameLabel.numberOfLines = 0
    }
    
    private func addtypeLabel() {
        container.addSubview(typeLabel)
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            typeLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10)
        ])
        
        typeLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        typeLabel.text = NSLocalizedString("Type:", comment: "")
        typeLabel.textColor = .black
    }
    
    private func addLocationTypeLabel() {
        container.addSubview(locationTypeLabel)
        locationTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationTypeLabel.topAnchor.constraint(equalTo: locationNameLabel.bottomAnchor, constant: 10),
            locationTypeLabel.leadingAnchor.constraint(equalTo: typeLabel.trailingAnchor, constant: 8)
        ])
        
        locationTypeLabel.font = UIFont.preferredFont(forTextStyle: .body)
        locationTypeLabel.text = NSLocalizedString("Planet", comment: "")
        locationTypeLabel.textColor = .black
        locationNameLabel.numberOfLines = 0
    }
    
    private func addDimensionLabel() {
        container.addSubview(dimensionLabel)
        dimensionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dimensionLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -20),
            dimensionLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10)
        ])
        
        dimensionLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        dimensionLabel.text = NSLocalizedString("Dimension:", comment: "")
        dimensionLabel.textColor = .black
    }
    
    private func addLocationDimensionLabel() {
        container.addSubview(locationDimensionLabel)
        locationDimensionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationDimensionLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -20),
            locationDimensionLabel.leadingAnchor.constraint(equalTo: dimensionLabel.trailingAnchor, constant: 8)
        ])
        
        locationDimensionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        locationDimensionLabel.text = NSLocalizedString("Dimension C-137", comment: "")
        locationDimensionLabel.textColor = .black
        locationDimensionLabel.numberOfLines = 0
    }
    
    
}
#Preview ("RMLocationHorizontalCell") {
    RMLocationHorizontalCell()
}

