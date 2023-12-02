//
//  ItemCollectionViewCell.swift
//  FoundIt
//
//  Created by Alexander Ilacqua on 11/29/23.
//

import Foundation
import UIKit
import SDWebImage

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
    private let actionButton = UIButton()
    private let animationButton = UIButton()
    
    //MARK: - Properties (Data)
    private var itemText: String = ""
    private var status: String = ""
    private var itemImage: String = ""
    private var location: String = ""
    private var locationId: Int = 0
    private var contact: String = ""
    private var time: String = ""
    private let formatter = DateFormatter()
    static let reuse = "ItemCollectionViewCellReuse"
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.white
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 16
        
        formatter.setLocalizedDateFormatFromTemplate("MMM d, h:mm a")
        
        setupItemLabel()
        setupStatusImageView()
        setupItemImageView()
        setupLocationImageView()
        setupTimeImageView()
        setupContactImageView()
        setupLocationLabel()
        setupContactLabel()
        setupTimeLabel()
        setupActionButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure
    func configure(item: Item) {
        self.itemText = item.desc
        self.status = item.status
        self.itemImage = "add"
        self.location = item.buildingName
        self.contact = item.contact
        self.time = item.time
        
        self.itemLabel.text = self.itemText
        print(item.imageUrl)
        self.itemImageView.sd_setImage(with: URL(string: item.imageUrl))
        self.locationLabel.text = self.location
        self.contactLabel.text = self.contact

        self.timeLabel.text = self.time
        
        if self.status == "found" { //FOUND
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
            statusImageView.leadingAnchor.constraint(equalTo: itemLabel.trailingAnchor, constant: 14),
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
            locationImageView.topAnchor.constraint(equalTo: itemLabel.bottomAnchor, constant: 14),
            locationImageView.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 12),
            locationImageView.heightAnchor.constraint(equalToConstant: 22),
            locationImageView.widthAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    private func setupTimeImageView() {
        timeImageView.image = UIImage(named: "time")
        timeImageView.contentMode = .scaleAspectFit
        
        contentView.addSubview(timeImageView)
        timeImageView.translatesAutoresizingMaskIntoConstraints = false
        timeImageView.layer.masksToBounds = true
                        
        NSLayoutConstraint.activate([
            timeImageView.topAnchor.constraint(equalTo: locationImageView.bottomAnchor, constant: 15),
            timeImageView.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 12),
            timeImageView.heightAnchor.constraint(equalToConstant: 22),
            timeImageView.widthAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    private func setupContactImageView() {
        contactImageView.image = UIImage(named: "contact")
        contactImageView.contentMode = .scaleAspectFit
        
        contentView.addSubview(contactImageView)
        contactImageView.translatesAutoresizingMaskIntoConstraints = false
        contactImageView.layer.masksToBounds = true
                        
        NSLayoutConstraint.activate([
            contactImageView.topAnchor.constraint(equalTo: timeImageView.bottomAnchor, constant: 15),
            contactImageView.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 12),
            contactImageView.heightAnchor.constraint(equalToConstant: 22),
            contactImageView.widthAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    private func setupLocationLabel() {
        locationLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        locationLabel.textColor = UIColor.black
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(locationLabel)
        
        NSLayoutConstraint.activate([
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 6),
        ])
    }
    
    private func setupContactLabel() {
        contactLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        contactLabel.textColor = UIColor.black
        contactLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(contactLabel)
        
        NSLayoutConstraint.activate([
            contactLabel.centerYAnchor.constraint(equalTo: contactImageView.centerYAnchor),
            contactLabel.leadingAnchor.constraint(equalTo: contactImageView.trailingAnchor, constant: 6),
        ])
    }
    
    private func setupTimeLabel() {
        timeLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        timeLabel.textColor = UIColor.black
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(timeLabel)
        
        NSLayoutConstraint.activate([
            timeLabel.centerYAnchor.constraint(equalTo: timeImageView.centerYAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: timeImageView.trailingAnchor, constant: 6),
        ])
    }
    
    private func setupActionButton() {
        actionButton.setTitle("Copy Contact", for: .normal)
        actionButton.setTitleColor(UIColor.found.white, for: .normal)
        actionButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        actionButton.backgroundColor = UIColor.found.green
        actionButton.layer.cornerRadius = 18
        
        contentView.addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.addTarget(self, action: #selector(copyContact), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 12),
            actionButton.topAnchor.constraint(equalTo: contactImageView.bottomAnchor, constant: 15),
            actionButton.heightAnchor.constraint(equalToConstant: 35),
            actionButton.widthAnchor.constraint(equalToConstant: 194)
        ])
    }
    
    //MARK: - Button Helpers
    @objc private func copyContact() {
        UIPasteboard.general.string = self.contact
        
        animationButton.setTitle("Copied!", for: .normal)
        animationButton.setTitleColor(UIColor.found.white, for: .normal)
        animationButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        animationButton.backgroundColor = UIColor.found.green
        animationButton.layer.cornerRadius = 14
        
        contentView.addSubview(animationButton)
        animationButton.translatesAutoresizingMaskIntoConstraints = false
        animationButton.layer.masksToBounds = true
                        
        NSLayoutConstraint.activate([
            animationButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            animationButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            animationButton.heightAnchor.constraint(equalToConstant: 28),
            animationButton.widthAnchor.constraint(equalToConstant: 90)
        ])
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.2, options: .allowUserInteraction, animations: {
            self.animationButton.transform = CGAffineTransform(scaleX: 1.6, y: 1.6)
            self.animationButton.alpha = 1.0
                }) { finished in
                    self.animationButton.alpha = 0.0
                    self.animationButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                }
    }
    
}




