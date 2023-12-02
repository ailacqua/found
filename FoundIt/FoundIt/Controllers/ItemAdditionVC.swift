//
//  ItemAdditionVC.swift
//  FoundIt
//
//  Created by Rohan Sedhain on 11/30/23.
//

import Foundation
import UIKit

class ItemAdditionVC : UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource  {
    
    //MARK: Properties (view)
    private let itemImage = UIImageView()
    private let timeField = UITextField()
    private let timePicker = UIDatePicker()
    private let contactField = UITextField()
    private let locationField = UITextField()
    private let locationTableView = UITableView()
    private let itemName = UITextField()
    private let itemDescriptionField = UITextField()
    private let timeIcon = UIImageView()
    private let locationIcon = UIImageView()
    private let contactIcon = UIImageView()
    private let descriptionIcon = UIImageView()
    private let postButton = UIButton()
    
    //MARK: Properties (data)
    private var filteredLocations = [String]()
    private var buildingName: String = ""
    private var buildingCode: String = ""
    private var isSearchEmpty: Bool = false
    private var base64encodedImageString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = UIColor.found.offWhite
        setupItemName()
        setupItemImage()
        setupLocationImageView()
        setupTimeImageView()
        setupContactImageView()
        setupDescriptionIcon()
        setupLocationField()
        setupLocationTableView()
        setupTimeField()
        setupContactField()
        setupItemDescriptionField()
        setupPostButton()
        
        
    }
    
    
    private func setupItemName() {
        itemName.placeholder = "Name"
        itemName.textColor = UIColor.found.black
        itemName.translatesAutoresizingMaskIntoConstraints = false
        itemName.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        view.addSubview(itemName)
        
        NSLayoutConstraint.activate([
            itemName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            itemName.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    private func setupItemImage() {
        itemImage.image = UIImage(named: "emptyImage")
        base64encodedImageString = "data:image/jpeg;base64,\(String(describing: itemImage.image?.jpegData(compressionQuality: 0.75)?.base64EncodedString()))"
        itemImage.layer.cornerRadius = 8
        itemImage.clipsToBounds = true
        itemImage.translatesAutoresizingMaskIntoConstraints = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        itemImage.isUserInteractionEnabled = true
        itemImage.addGestureRecognizer(tap)
        view.addSubview(itemImage)
        
        NSLayoutConstraint.activate([
            itemImage.topAnchor.constraint(equalTo: itemName.bottomAnchor, constant: 24),
            itemImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            itemImage.heightAnchor.constraint(equalToConstant: 192),
            itemImage.widthAnchor.constraint(equalToConstant: 322)
        ])
    }
    private func setupLocationImageView() {
        locationIcon.image = UIImage(named: "location")
        locationIcon.contentMode = .scaleAspectFit
        locationIcon.translatesAutoresizingMaskIntoConstraints = false
        locationIcon.layer.masksToBounds = true
        
        view.addSubview(locationIcon)
        
        NSLayoutConstraint.activate([
            locationIcon.topAnchor.constraint(equalTo: itemImage.bottomAnchor, constant: 24),
            locationIcon.leadingAnchor.constraint(equalTo: itemImage.leadingAnchor, constant: -4),
            locationIcon.heightAnchor.constraint(equalToConstant: 25),
            locationIcon.widthAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    private func setupLocationField() {
        locationField.placeholder = "Last Seen Location"
        locationField.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        locationField.translatesAutoresizingMaskIntoConstraints = false
        locationField.addTarget(self, action: #selector(locationFieldDidChange(_:)), for: .editingChanged)
        view.addSubview(locationField)
        NSLayoutConstraint.activate([
            locationField.topAnchor.constraint(equalTo: itemImage.bottomAnchor, constant: 24),
            locationField.leadingAnchor.constraint(equalTo: locationIcon.trailingAnchor, constant: 8),
            locationField.centerYAnchor.constraint(equalTo: locationIcon.centerYAnchor)
            
        ])
        
    }
    
    private func setupLocationTableView() {
        locationTableView.register(LocationTableViewCell.self, forCellReuseIdentifier: "cell")
        locationTableView.delegate = self
        locationTableView.dataSource = self
        locationTableView.isHidden = true
        locationTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(locationTableView)
        
        NSLayoutConstraint.activate([
            locationTableView.topAnchor.constraint(equalTo: locationField.bottomAnchor, constant: 4),
            locationTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            locationTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            locationTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
    
    @objc private func locationFieldDidChange(_ textField: UITextField) {
        if let searchText = textField.text, !searchText.isEmpty {
            filteredLocations = Location.locations.keys.filter({$0.lowercased().contains(searchText.lowercased()) })
            
            if filteredLocations.isEmpty {
                // Hide the table view if no results are found
                locationTableView.isHidden = true
            } else {
                locationTableView.isHidden = false
                view.bringSubviewToFront(locationTableView)
            }
        } else {
            filteredLocations.removeAll()
            locationTableView.isHidden = true
        }
        locationTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchEmpty ? 1 : filteredLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if isSearchEmpty {
            cell.textLabel?.text = "No results found"
        } else {
            cell.textLabel?.text = filteredLocations[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        locationField.text = filteredLocations[indexPath.row]
        locationTableView.isHidden = true
    }
    
    
    
    private func setupTimeImageView() {
        timeIcon.image = UIImage(named: "time")
        timeIcon.contentMode = .scaleAspectFit
        timeIcon.translatesAutoresizingMaskIntoConstraints = false
        timeIcon.layer.masksToBounds = true
        view.addSubview(timeIcon)
        NSLayoutConstraint.activate([
            timeIcon.topAnchor.constraint(equalTo: locationIcon.bottomAnchor, constant: 24),
            timeIcon.leadingAnchor.constraint(equalTo: locationIcon.leadingAnchor),
            timeIcon.widthAnchor.constraint(equalToConstant: 25),
            timeIcon.heightAnchor.constraint(equalToConstant: 25)
        ])
        
    }
    
    private func setupContactImageView() {
        contactIcon.image = UIImage(named: "contact")
        contactIcon.contentMode = .scaleAspectFit
        
        
        contactIcon.translatesAutoresizingMaskIntoConstraints = false
        contactIcon.layer.masksToBounds = true
        view.addSubview(contactIcon)
        NSLayoutConstraint.activate([
            contactIcon.topAnchor.constraint(equalTo: timeIcon.bottomAnchor, constant: 24),
            contactIcon.leadingAnchor.constraint(equalTo: timeIcon.leadingAnchor),
            contactIcon.widthAnchor.constraint(equalToConstant: 25),
            contactIcon.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        
    }
    
    private func setupDescriptionIcon() {
        descriptionIcon.image = UIImage(named: "Description")
        descriptionIcon.contentMode = .scaleAspectFit
        
        descriptionIcon.translatesAutoresizingMaskIntoConstraints = false
        descriptionIcon.layer.masksToBounds = true
        view.addSubview(descriptionIcon)
        NSLayoutConstraint.activate([
            descriptionIcon.topAnchor.constraint(equalTo: contactIcon.bottomAnchor, constant: 24),
            descriptionIcon.leadingAnchor.constraint(equalTo: contactIcon.leadingAnchor),
            descriptionIcon.heightAnchor.constraint(equalToConstant: 25),
            descriptionIcon.widthAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    private func setupTimeField() {
        timeField.placeholder = "Last Seen Time"
        timeField.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        timeField.translatesAutoresizingMaskIntoConstraints = false
        
        timePicker.datePickerMode = .dateAndTime
        timePicker.preferredDatePickerStyle = .wheels
        timePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
        // Set timePicker as inputView for timeField
        timeField.inputView = timePicker
        
        
        view.addSubview(timeField)
        
        NSLayoutConstraint.activate([
            timeField.topAnchor.constraint(equalTo: locationField.bottomAnchor, constant: 24),
            timeField.leadingAnchor.constraint(equalTo: timeIcon.trailingAnchor, constant: 8),
            timeField.centerYAnchor.constraint(equalTo: timeIcon.centerYAnchor)
        ])
    }
    
    @objc private func datePickerValueChanged(_ sender: UIDatePicker) {
        // Format and set the date in timeField
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        timeField.text = formatter.string(from: sender.date)
    }
    
    
    
    private func setupContactField() {
        contactField.placeholder = "Email"
        contactField.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        contactField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contactField)
        NSLayoutConstraint.activate([
            contactField.topAnchor.constraint(equalTo: timeField.bottomAnchor,constant: 24),
            contactField.leadingAnchor.constraint(equalTo: contactIcon.trailingAnchor, constant: 8),
            contactField.centerYAnchor.constraint(equalTo: contactIcon.centerYAnchor)
        ])
        
        
    }
    
    private func setupItemDescriptionField() {
        itemDescriptionField.placeholder = "Detailed Description"
        itemDescriptionField.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        itemDescriptionField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(itemDescriptionField)
        NSLayoutConstraint.activate([
            itemDescriptionField.topAnchor.constraint(equalTo: contactField.bottomAnchor, constant: 24),
            itemDescriptionField.leadingAnchor.constraint(equalTo: descriptionIcon.trailingAnchor, constant: 8),
            itemDescriptionField.centerYAnchor.constraint(equalTo: descriptionIcon.centerYAnchor)
        ])
    }
    
    private func setupPostButton() {
        postButton.setTitle("Post", for: .normal)
        postButton.backgroundColor = UIColor.found.ruby
        postButton.layer.cornerRadius = 8
        postButton.setTitleColor(UIColor.found.black, for: .normal)
        postButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(postButton)
        
        NSLayoutConstraint.activate([
            postButton.topAnchor.constraint(equalTo: itemDescriptionField.bottomAnchor, constant: 36),
            postButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            postButton.widthAnchor.constraint(equalToConstant: 192),
            postButton.heightAnchor.constraint(equalToConstant: 59)
            
        ])
        
        
    }
    
    @objc func imageTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    
}

extension ItemAdditionVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo
                               info: [UIImagePickerController.InfoKey: Any]) {
        itemImage.image = info[.originalImage] as? UIImage
        let imageData = itemImage.image?.jpegData(compressionQuality: 0.75)
        let imageDataEncodedString = imageData?.base64EncodedString()
        let finalString = "data:image/jpeg;base64,\(String(describing: imageDataEncodedString))"
        print(imageDataEncodedString!.count)
        
        
        
        dismiss(animated: true, completion: nil)
    }
}
