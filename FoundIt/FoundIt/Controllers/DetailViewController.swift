//
//  DetailViewController.swift
//  FoundIt
//
//  Created by Alexander Ilacqua on 11/30/23.
//

import UIKit

class DetailViewController: UIViewController {
    //MARK: - Properties (View)
    
    //MARK: - Properties (Data)
    private var itemName: String = ""
    private var itemImage: String = ""
    private var itemLocation: String = ""
    private var advancedLocation: String = ""
    
    
    //MARK: - viewDidLoad and init
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Items Details"
        view.backgroundColor = UIColor.found.white
    }
    
    init(name: String, image: String, loc: String, advLoc: String, contact: String, status: Bool) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup Views
    
    
    
}
