//
//  LocationTableViewCell.swift
//  FoundIt
//
//  Created by Rohan Sedhain on 12/1/23.
//

import Foundation
import UIKit

class LocationTableViewCell: UITableViewCell {
    private let padding: CGFloat = 16
    let locationLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(locationLabel)
        contentView.backgroundColor = UIColor.found.offWhite
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 16
        setupLocationLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLocationLabel() {
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            locationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            locationLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            locationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
    }
}
