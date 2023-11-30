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
    private let statusImage = UIImageView()
    private let timeImage = UIImageView()
    private let locationImage = UIImageView()
    private let contactImage = UIImageView()
    private let itemImage = UIImageView()
    
    //MARK: - Properties (Data)
    private var itemText: String = ""
    
    

    //MARK: - Properties (Data)
    static let reuse = "ItemCollectionViewCellReuse"
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.white
        contentView.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure
    func configure(item: Item) {
        
    }
    
    //MARK: - Set Up Views
    private func setupItemLabel() {
        itemLabel.text = self.itemText
        itemLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        itemLabel.textColor = UIColor.gray
        itemLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(itemLabel)
        
        NSLayoutConstraint.activate([
            itemLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            itemLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            itemLabel.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    private func setupStatusImage() {
        
    }
    
}




