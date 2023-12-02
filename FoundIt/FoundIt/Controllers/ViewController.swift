//
//  ViewController.swift
//  FoundIt
//
//  Created by Alexander Ilacqua on 11/29/23.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - Properties (View)
    private var collectionView: UICollectionView!
    private let addButton = UIButton()
    private let allButton = UIButton()
    private let foundButton = UIButton()
    private let lostButton = UIButton()
    private let bottomLabel = UILabel()
    private let searchController = UISearchController(searchResultsController: nil)
    private let refreshControl = UIRefreshControl()
    
    
    //MARK: - Properties (Data)
    private var items: [Item] = []
    private var filteredItems: [Item] = []
    
    
    //MARK: - viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "FoundIt!"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = UIColor.found.white
        
        setupSearchController()
        setupBottomLabel()
        setupCollectionView()
        setupAllButton()
        setupFoundButton()
        setupLostButton()
        setupAddButton()
        fetchItems()
    }
    //MARK: - Networking
    @objc private func fetchItems() {
        NetworkManager.shared.fetchItems { [weak self] items in
            guard let self = self else { return }
            self.items = items
            self.filteredItems = items
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    //MARK: - Set Up Views
    
    private func setupSearchController() {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search items by name"
        
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.found.white
        collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: ItemCollectionViewCell.reuse)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        
        refreshControl.addTarget(self, action: #selector(fetchItems), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomLabel.topAnchor)
        ])
    }
    
    private func setupBottomLabel() {
        bottomLabel.backgroundColor = UIColor.found.white
        view.addSubview(bottomLabel)
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomLabel.heightAnchor.constraint(equalToConstant: 75),
            bottomLabel.widthAnchor.constraint(equalToConstant: view.frame.width)
        ])
    }
    
    private func setupAllButton() {
        allButton.setTitle("All", for: .normal)
        allButton.setTitleColor(UIColor.found.white, for: .normal)
        allButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        allButton.backgroundColor = UIColor.found.ruby
        allButton.layer.cornerRadius = 18
        
        view.addSubview(allButton)
        allButton.translatesAutoresizingMaskIntoConstraints = false
        allButton.addTarget(self, action: #selector(setAll), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            allButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 24),
            allButton.topAnchor.constraint(equalTo: bottomLabel.topAnchor, constant: 12),
            allButton.heightAnchor.constraint(equalToConstant: 35),
            allButton.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func setupFoundButton() {
        foundButton.setTitle("Found", for: .normal)
        foundButton.setTitleColor(UIColor.found.black, for: .normal)
        foundButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        foundButton.backgroundColor = UIColor.found.offWhite
        foundButton.layer.cornerRadius = 18
        foundButton.addTarget(self, action: #selector(setFound), for: .touchUpInside)
        
        view.addSubview(foundButton)
        foundButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            foundButton.leadingAnchor.constraint(equalTo: allButton.trailingAnchor,constant: 8),
            foundButton.topAnchor.constraint(equalTo: bottomLabel.topAnchor, constant: 12),
            foundButton.heightAnchor.constraint(equalToConstant: 35),
            foundButton.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func setupLostButton() {
        lostButton.setTitle("Lost", for: .normal)
        lostButton.setTitleColor(UIColor.found.black, for: .normal)
        lostButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        lostButton.backgroundColor = UIColor.found.offWhite
        lostButton.layer.cornerRadius = 18
        
        view.addSubview(lostButton)
        lostButton.translatesAutoresizingMaskIntoConstraints = false
        lostButton.addTarget(self, action: #selector(setLost), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            lostButton.leadingAnchor.constraint(equalTo: foundButton.trailingAnchor,constant: 8),
            lostButton.topAnchor.constraint(equalTo: bottomLabel.topAnchor, constant: 12),
            lostButton.heightAnchor.constraint(equalToConstant: 35),
            lostButton.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func setupAddButton() {
        addButton.setTitle("+", for: .normal)
        addButton.setTitleColor(UIColor.found.white, for: .normal)
        addButton.titleLabel?.font = .systemFont(ofSize: 30, weight: .semibold)
        addButton.backgroundColor = UIColor.found.green
        addButton.layer.cornerRadius = 18
        
        view.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.addTarget(self, action: #selector(pushAddVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            addButton.leadingAnchor.constraint(equalTo: lostButton.trailingAnchor,constant: 8),
            addButton.topAnchor.constraint(equalTo: bottomLabel.topAnchor, constant: 12),
            addButton.heightAnchor.constraint(equalToConstant: 35),
            addButton.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    //MARK: - Button Helpers
    @objc private func setAll() {
        allButton.setTitleColor(UIColor.found.white, for: .normal)
        allButton.backgroundColor = UIColor.found.ruby
        foundButton.setTitleColor(UIColor.found.black, for: .normal)
        foundButton.backgroundColor = UIColor.found.offWhite
        lostButton.setTitleColor(UIColor.found.black, for: .normal)
        lostButton.backgroundColor = UIColor.found.offWhite
        
        self.filteredItems = self.items
        self.collectionView.reloadData()
    }
    @objc private func setFound() {
        allButton.setTitleColor(UIColor.found.black, for: .normal)
        allButton.backgroundColor = UIColor.found.offWhite
        foundButton.setTitleColor(UIColor.found.white, for: .normal)
        foundButton.backgroundColor = UIColor.found.ruby
        lostButton.setTitleColor(UIColor.found.black, for: .normal)
        lostButton.backgroundColor = UIColor.found.offWhite
        
        self.filteredItems = items.filter { $0.status == "found"}
        self.collectionView.reloadData()
    }
    @objc private func setLost() {
        allButton.setTitleColor(UIColor.found.black, for: .normal)
        allButton.backgroundColor = UIColor.found.offWhite
        foundButton.setTitleColor(UIColor.found.black, for: .normal)
        foundButton.backgroundColor = UIColor.found.offWhite
        lostButton.setTitleColor(UIColor.found.white, for: .normal)
        lostButton.backgroundColor = UIColor.found.ruby
        
        self.filteredItems = items.filter { $0.status == "lost"}
        self.collectionView.reloadData()
    }
    @objc private func pushAddVC() {
        let addVC = ItemAdditionVC()
        navigationController?.pushViewController(addVC, animated: true)
    }
}

// MARK: - UICollectionViewDelegate

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = self.filteredItems[indexPath.row]
        let detailVC = DetailViewController(item: item)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.reuse, for: indexPath) as? ItemCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(item: self.filteredItems[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.width - 30
        return CGSize(width: size, height: 222)
    }
}

//MARK: - Search Functionality
extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text! == "" {
            self.filteredItems = self.items
        }
        else {
            self.filteredItems.removeAll()
            for item in self.items {
                if (item.desc.lowercased().contains(searchController.searchBar.text!.lowercased())) {
                    self.filteredItems.append(item)
                }
            }
        }
        self.collectionView.reloadData()
    }
}

