//
//  ItemCollectionViewCell.swift
//  FoundIt
//
//  Created by Alexander Ilacqua on 11/29/23.
//

import Foundation
import UIKit
class ItemCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties (View)
    private let itemLabel = UILabel()
    private let timeLabel = UILabel()
    private let locationLabel = UILabel()
    private let contactLabel = UILabel()
    private let statusImageView = UIImageView()
    private let timeImageView = UIImageView()
    private let locationImageView = UIImageView()
    private let contactImageView = UIImageView()
    private let itemImageView = UIImageView()
    
    //MARK: - Properties (Data)
    private var itemText: String = ""
    private var status: Bool = false
    private var itemImage: String = ""
    static let reuse = "ItemCollectionViewCellReuse"
    
    
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.white
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 16
        
        setupItemLabel()
        setupStatusImageView()
        setupItemImageView()
        setupLocationImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure
    func configure(item: Item) {
        self.itemText = item.desc
        self.status = item.status
        self.itemImage = item.image
        
        self.itemLabel.text = self.itemText
        self.itemImageView.image = UIImage(named: self.itemImage)
        
        if self.status == true { //FOUND
            self.statusImageView.image = UIImage(named: "found")
            contentView.backgroundColor = UIColor.found.lightGreen
            
        } else { //LOST
            self.statusImageView.image = UIImage(named: "lost")
            contentView.backgroundColor = UIColor.found.lightRed
        }
        
    }
    
    //MARK: - Set Up Views
    private func setupItemLabel() {
        itemLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        itemLabel.textColor = UIColor.black
        itemLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(itemLabel)
        
        NSLayoutConstraint.activate([
            itemLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            itemLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            itemLabel.widthAnchor.constraint(equalToConstant: 288)
        ])
    }
    
    private func setupStatusImageView() {
        statusImageView.contentMode = .scaleAspectFit

        contentView.addSubview(statusImageView)
        statusImageView.translatesAutoresizingMaskIntoConstraints = false
        statusImageView.layer.masksToBounds = true
                        
        NSLayoutConstraint.activate([
            statusImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            statusImageView.leadingAnchor.constraint(equalTo: itemLabel.trailingAnchor, constant: 4),
            statusImageView.heightAnchor.constraint(equalToConstant: 24),
            statusImageView.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func setupItemImageView() {
        itemImageView.contentMode = .scaleAspectFill
        
        contentView.addSubview(itemImageView)
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        itemImageView.layer.masksToBounds = true
        itemImageView.layer.cornerRadius = 8
                        
        NSLayoutConstraint.activate([
            itemImageView.topAnchor.constraint(equalTo: itemLabel.bottomAnchor, constant: 8),
            itemImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            itemImageView.heightAnchor.constraint(equalToConstant: 167),
            itemImageView.widthAnchor.constraint(equalToConstant: 125)
        ])
    }
    
    private func setupLocationImageView() {
        locationImageView.image = UIImage(named: "location")
        locationImageView.contentMode = .scaleAspectFit
        
        contentView.addSubview(locationImageView)
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        locationImageView.layer.masksToBounds = true
                        
        NSLayoutConstraint.activate([
            locationImageView.topAnchor.constraint(equalTo: itemLabel.bottomAnchor, constant: 12),
            locationImageView.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 12),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            locationImageView.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func setupTimeImageView() {
        locationImageView.image = UIImage(named: "time")
        locationImageView.contentMode = .scaleAspectFit
        
        contentView.addSubview(locationImageView)
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        locationImageView.layer.masksToBounds = true
                        
        NSLayoutConstraint.activate([
            locationImageView.topAnchor.constraint(equalTo: itemLabel.bottomAnchor, constant: 8),
            locationImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            locationImageView.heightAnchor.constraint(equalToConstant: 167),
            locationImageView.widthAnchor.constraint(equalToConstant: 167)
        ])
    }
    
    private func setupContactImageView() {
        locationImageView.image = UIImage(named: "contact")
        locationImageView.contentMode = .scaleAspectFit
        
        contentView.addSubview(locationImageView)
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        locationImageView.layer.masksToBounds = true
                        
        NSLayoutConstraint.activate([
            locationImageView.topAnchor.constraint(equalTo: itemLabel.bottomAnchor, constant: 8),
            locationImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            locationImageView.heightAnchor.constraint(equalToConstant: 167),
            locationImageView.widthAnchor.constraint(equalToConstant: 167)
        ])
    }
    
}




