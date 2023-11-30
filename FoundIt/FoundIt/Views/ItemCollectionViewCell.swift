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

    //MARK: - Properties (Data)
    static let reuse = "ItemCollectionViewCellReuse"
    private var imageUrl: String = ""
    private var nameText: String = ""
    private var descriptionText: String = ""
    
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
}




