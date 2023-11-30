//
//  ItemAdditionVC.swift
//  FoundIt
//
//  Created by Rohan Sedhain on 11/30/23.
//

import Foundation
import UIKit

class ItemAdditionVC : UIViewController {
    
    //MARK: Properties (view)
    private let itemImage = UIImageView()
    private let timeField = UITextField()
    private let contactField = UITextField()
    private let locationField = UITextField()
    private let itemDescription = UITextField()
    private let timeIcon = UIImageView()
    private let locationIcon = UIImageView()
    private let contactIcon = UIImageView()
    
    //MARK: Properties (data)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = UIColor.found.offWhite
        setupItemDescription()
        setupItemImage()
        setupLocationImageView()
        setupTimeImageView()
        setupContactImageView()
    }
    
    private func setupItemDescription() {
        itemDescription.placeholder = "Item Description"
        itemDescription.textColor = UIColor.found.black
        itemDescription.translatesAutoresizingMaskIntoConstraints = false
        itemDescription.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        view.addSubview(itemDescription)
        
        NSLayoutConstraint.activate([
            itemDescription.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            itemDescription.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            itemDescription.widthAnchor.constraint(equalToConstant: 288)
        ])
        
    }
    private func setupItemImage() {
        itemImage.layer.cornerRadius = 8
        itemImage.clipsToBounds = true
        itemImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(itemImage)
                        
        NSLayoutConstraint.activate([
            itemImage.topAnchor.constraint(equalTo: itemDescription.bottomAnchor, constant: 8),
            itemImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            itemImage.heightAnchor.constraint(equalToConstant: 167),
            itemImage.widthAnchor.constraint(equalToConstant: 125)
        ])
    }
    
    private func setupLocationImageView() {
        locationIcon.image = UIImage(named: "location")
        locationIcon.contentMode = .scaleAspectFit
        locationIcon.translatesAutoresizingMaskIntoConstraints = false
        locationIcon.layer.masksToBounds = true
        
        view.addSubview(locationIcon)
            
        NSLayoutConstraint.activate([
            locationIcon.topAnchor.constraint(equalTo: itemDescription.bottomAnchor, constant: 12),
            locationIcon.leadingAnchor.constraint(equalTo: itemImage.trailingAnchor, constant: 12),
            locationIcon.heightAnchor.constraint(equalToConstant: 20),
            locationIcon.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func setupTimeImageView() {
        timeIcon.image = UIImage(named: "time")
        timeIcon.contentMode = .scaleAspectFit
        timeIcon.translatesAutoresizingMaskIntoConstraints = false
        timeIcon.layer.masksToBounds = true
        
        view.addSubview(timeIcon)
                               
        NSLayoutConstraint.activate([
            timeIcon.topAnchor.constraint(equalTo: itemDescription.bottomAnchor, constant: 8),
            timeIcon.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            timeIcon.heightAnchor.constraint(equalToConstant: 167),
            timeIcon.widthAnchor.constraint(equalToConstant: 167)
        ])
    }
    
    private func setupContactImageView() {
        contactIcon.image = UIImage(named: "contact")
        contactIcon.contentMode = .scaleAspectFit
        
       
        contactIcon.translatesAutoresizingMaskIntoConstraints = false
        contactIcon.layer.masksToBounds = true
        view.addSubview(contactIcon)
                        
        NSLayoutConstraint.activate([
            contactIcon.topAnchor.constraint(equalTo: itemDescription.bottomAnchor, constant: 8),
            contactIcon.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            contactIcon.heightAnchor.constraint(equalToConstant: 167),
            contactIcon.widthAnchor.constraint(equalToConstant: 167)
        ])
    }
    
    
    
    
    
    
    
}
