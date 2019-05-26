//
//  AppsSearchController.swift
//  AppStoreJSONApiS
//
//  Created by Armin Spahic on 06/04/2019.
//  Copyright © 2019 Armin Spahic. All rights reserved.
// "https://itunes.apple.com/search?term=instagram&entity=software"

import UIKit

class AppsSearchController: BaseListController, UISearchBarDelegate {
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    let cellId = "cellId"
    fileprivate var appResults = [Result]()
    
    fileprivate let enterSearchTextLabel: UILabel = {
       let label = UILabel()
        label.text = "Please enter search term above..."
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupSearchBar()
    }
    
    fileprivate func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    var timer: Timer?
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            Service.shared.fetchApps(searchString: searchText) { (searchResult, err) in
                if let err = err {
                    self.handleError(err: err.localizedDescription)
                    return
                }
                
                guard let results = searchResult?.results else {return}
                self.appResults = results
                //results.forEach({print($0.trackName)})
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            }
        })
    }
    
    fileprivate func handleError(err: String) {
        
        let alert = UIAlertController(title: "", message: err, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .destructive, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    fileprivate func setupViews() {
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.addSubview(enterSearchTextLabel)
        enterSearchTextLabel.fillSuperview(padding: UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0))
        enterSearchTextLabel.centerXInSuperview()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        enterSearchTextLabel.isHidden = appResults.count != 0
        return appResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultCell
        cell.result = appResults[indexPath.item]
        //cell.imageCollectionView.reloadData()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 350)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let app = appResults[indexPath.item]
        
        guard let trackId = app.trackId else {return}
        let appDetailsController = AppDetailsController(appId: String(trackId))
        appDetailsController.navigationItem.title = app.primaryGenreName
        
        navigationController?.pushViewController(appDetailsController, animated: true)
    }
    
}
