//
//  CatsSearchViewController.swift
//  Cats
//
//  Created by Ali Aljoubory on 25/12/2020.
//

import UIKit

class CatsSearchViewController: CatsDataLoadingViewController {
    
    enum Section { case main }
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Cats>!
    
    var cats: [Cats] = []
    var filteredCats: [Cats] = []
    
    var isSearching = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureSearchViewController()
        configureCollectionView()
        configureDataSource()
        
        getCats()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureSearchViewController() {
        let searchViewController = UISearchController()
        
        searchViewController.searchResultsUpdater = self
        searchViewController.searchBar.placeholder = "Search for a Cat"
        searchViewController.obscuresBackgroundDuringPresentation = false
        
        navigationItem.searchController = searchViewController
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CatCell.self, forCellWithReuseIdentifier: CatCell.reuseID)
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Cats>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, cat) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatCell.reuseID, for: indexPath) as! CatCell
            cell.set(cat: cat)
            return cell
        })
    }
    
    func getCats() {
        showLoadingView()
        
        cats.removeAll()
        filteredCats.removeAll()
        
        NetworkManager.shared.getCats() { [weak self] result in
            guard let self = self else { return }
            
            self.dismissLoadingView()
            
            switch result {
            
            case .success(let cats):
                self.cats.append(contentsOf: cats)
                self.updateData(on: cats)
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self.presentAlert(title: "Failed to get Cats", message: error.rawValue, actionTitle: "OK", actionStyle: .default)
                }
            }
        }
    }
    
    func updateData(on cats: [Cats]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Cats>()
        
        snapshot.appendSections([.main])
        snapshot.appendItems(cats)
        
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
}

extension CatsSearchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredCats : cats
        let cat = activeArray[indexPath.item]
        
        let destinationVc = self.getViewController(storyboard: "Main", identifier: "catDetailVc") as! CatDetailViewController
        destinationVc.imageUrl = cat.image?.url
        destinationVc.name = cat.name
        destinationVc.temperament = cat.temperament
        destinationVc.energyLevel = String(cat.energyLevel ?? 0)
        destinationVc.wikipediaURL = cat.wikipediaUrl
        
        let navigationController = UINavigationController(rootViewController: destinationVc)
        present(navigationController, animated: true)
    }
}

extension CatsSearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            updateData(on: cats)
            filteredCats.removeAll()
            isSearching = false
            return
        }
        
        isSearching = true
        filteredCats.removeAll()
        filteredCats = self.cats.filter({ ($0.name?.lowercased().contains(filter.lowercased()) ?? false) })
        updateData(on: filteredCats)
    }
}
