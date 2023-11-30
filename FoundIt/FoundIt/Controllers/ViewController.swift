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
    private let refreshControl = UIRefreshControl()
    
    //MARK: - Properties (Data)
    private var items: [Item] = []
    
    
    //MARK: - viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "FoundIt!"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = UIColor.white
    }
    
    //MARK: - Set Up Views
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 0
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: ItemCollectionViewCell.reuse)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.refreshControl = refreshControl
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    


    
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.reuse, for: indexPath) as? ItemCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(item: self.items[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.width / 2
        return CGSize(width: size, height: 216)
    }
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.filterCollectionView {
            let difficulty = self.filterNames[indexPath.row]
            self.difficulty = difficulty
            if difficulty == "All" {
                self.filteredRecipes = self.recipes
            } else {
                self.filteredRecipes = self.recipes.filter { $0.difficulty == difficulty }
            }
            self.filterCollectionView.reloadData()
            self.collectionView.reloadData()
        }
        
    }
}

