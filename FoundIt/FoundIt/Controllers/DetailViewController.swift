//
//  DetailViewController.swift
//  FoundIt
//
//  Created by Alexander Ilacqua on 11/30/23.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    //MARK: - Properties (View)
    private let nameLabel = UILabel()
    private let itemImageView = UIImageView()
    private let locationImageView = UIImageView()
    private let locationLabel = UILabel()
    private let locDescLabel = UILabel()
    private let timeImageView = UIImageView()
    private let contactImageView = UIImageView()
    private let timeLabel = UILabel()
    private let contactLabel = UILabel()
    private let actionButton = UIButton()
    private let animationButton = UIButton()
    
    //MARK: - Properties (Data)
    private var imageUrl: String = ""
    private var desc: String = ""
    private var locDesc: String = ""
    private var time: String = ""
    private var status: String = ""
    private var contact: String = ""
    private var buildingName: String = ""
    
    
    //MARK: - viewDidLoad and init
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.status == "found" {
            view.backgroundColor = UIColor.found.fullLightGreen
        } else {
            view.backgroundColor = UIColor.found.fullLightRed
        }
        setupNameLabel()
        setupItemImageView()
        setupLocationImageView()
        setupLocationLabel()
        setupLocationDescLabel()
        setupTimeImageView()
        setupContactImageView()
        setupTimeLabel()
        setupContactLabel()
        setupActionButton()
    }
    
    init(item: Item) {
        self.imageUrl = item.imageUrl
        self.desc = item.desc
        self.locDesc = item.locDesc
        self.time = item.time
        self.status = item.status
        self.contact = item.contact
        self.buildingName = item.buildingName
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup Views
    private func setupNameLabel() {
        nameLabel.text = self.desc
        nameLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold).rounded
        nameLabel.textColor = UIColor.black
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 16),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupItemImageView() {
        itemImageView.contentMode = .scaleAspectFill
        itemImageView.sd_setImage(with: URL(string: self.imageUrl))
        
        
        view.addSubview(itemImageView)
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        itemImageView.layer.cornerRadius = 8
        itemImageView.layer.masksToBounds = true
                        
        NSLayoutConstraint.activate([
            itemImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            itemImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            itemImageView.heightAnchor.constraint(equalToConstant: 360),
            itemImageView.widthAnchor.constraint(equalToConstant: 345)
        ])
    }
    
    private func setupLocationImageView() {
        locationImageView.image = UIImage(named: "location")
        locationImageView.contentMode = .scaleAspectFit
        
        view.addSubview(locationImageView)
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        locationImageView.layer.masksToBounds = true
                        
        NSLayoutConstraint.activate([
            locationImageView.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: 18),
            locationImageView.leadingAnchor.constraint(equalTo: itemImageView.leadingAnchor),
            locationImageView.heightAnchor.constraint(equalToConstant: 28),
            locationImageView.widthAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    private func setupLocationLabel() {
        locationLabel.text = self.buildingName
        locationLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        locationLabel.textColor = UIColor.black
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(locationLabel)
        
        NSLayoutConstraint.activate([
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 6),
        ])
    }
    
    private func setupLocationDescLabel() {
        locDescLabel.text = self.locDesc
        locDescLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        locDescLabel.textColor = UIColor.found.black
        locDescLabel.translatesAutoresizingMaskIntoConstraints = false
        locDescLabel.numberOfLines = 4
        
        view.addSubview(locDescLabel)
        
        NSLayoutConstraint.activate([
            locDescLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor,constant: 2),
            locDescLabel.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor),
            locDescLabel.widthAnchor.constraint(equalToConstant: 320)
        ])
    }
    
    private func setupTimeLabel() {
        timeLabel.text = "\(self.status.capitalized): \(self.time)"
        timeLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        timeLabel.textColor = UIColor.found.black
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(timeLabel)
        
        NSLayoutConstraint.activate([
            timeLabel.centerYAnchor.constraint(equalTo: timeImageView.centerYAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: timeImageView.trailingAnchor, constant: 6),
        ])
    }
    
    private func setupTimeImageView() {
        timeImageView.image = UIImage(named: "time")
        timeImageView.contentMode = .scaleAspectFit
        
        view.addSubview(timeImageView)
        timeImageView.translatesAutoresizingMaskIntoConstraints = false
        timeImageView.layer.masksToBounds = true
                        
        NSLayoutConstraint.activate([
            timeImageView.topAnchor.constraint(equalTo: locationImageView.bottomAnchor, constant: 96),
            timeImageView.leadingAnchor.constraint(equalTo: itemImageView.leadingAnchor),
            timeImageView.heightAnchor.constraint(equalToConstant: 28),
            timeImageView.widthAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    private func setupContactImageView() {
        contactImageView.image = UIImage(named: "contact")
        contactImageView.contentMode = .scaleAspectFit
        
        view.addSubview(contactImageView)
        contactImageView.translatesAutoresizingMaskIntoConstraints = false
        contactImageView.layer.masksToBounds = true
                        
        NSLayoutConstraint.activate([
            contactImageView.topAnchor.constraint(equalTo: timeImageView.bottomAnchor, constant: 18),
            contactImageView.leadingAnchor.constraint(equalTo: itemImageView.leadingAnchor),
            contactImageView.heightAnchor.constraint(equalToConstant: 28),
            contactImageView.widthAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    private func setupContactLabel() {
        contactLabel.text = "\(self.status.capitalized) by: \(self.contact)"
        contactLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        contactLabel.textColor = UIColor.found.black
        contactLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(contactLabel)
        
        NSLayoutConstraint.activate([
            contactLabel.centerYAnchor.constraint(equalTo: contactImageView.centerYAnchor),
            contactLabel.leadingAnchor.constraint(equalTo: contactImageView.trailingAnchor, constant: 6),
        ])
    }
    
    private func setupActionButton() {
        actionButton.setTitle("Copy Contact Info to Clipboard", for: .normal)
        actionButton.setTitleColor(UIColor.found.white, for: .normal)
        actionButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        actionButton.backgroundColor = UIColor.found.green
        actionButton.layer.cornerRadius = 18
        
        view.addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.addTarget(self, action: #selector(copyContact), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionButton.topAnchor.constraint(equalTo: contactImageView.bottomAnchor, constant: 30),
            actionButton.heightAnchor.constraint(equalToConstant: 50),
            actionButton.widthAnchor.constraint(equalToConstant: 320)
        ])
    }
    
    @objc private func copyContact() {
        UIPasteboard.general.string = self.contact
        
        animationButton.setTitle("Copied!", for: .normal)
        animationButton.setTitleColor(UIColor.found.white, for: .normal)
        animationButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        animationButton.backgroundColor = UIColor.found.green
        animationButton.layer.cornerRadius = 18
        
        view.addSubview(animationButton)
        animationButton.translatesAutoresizingMaskIntoConstraints = false
        animationButton.layer.masksToBounds = true
                        
        NSLayoutConstraint.activate([
            animationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            animationButton.heightAnchor.constraint(equalToConstant: 36),
            animationButton.widthAnchor.constraint(equalToConstant: 100)
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
