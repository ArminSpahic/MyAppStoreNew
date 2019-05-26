//
//  MusicCollectionViewController.swift
//  AppStoreJSONApiS
//
//  Created by Armin Spahic on 15/05/2019.
//  Copyright © 2019 Armin Spahic. All rights reserved.
//

import UIKit

class MusicCollectionViewController: BaseListController, UISearchBarDelegate {
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    let cellId = "cellId"
    let footerId = "footerId"
    
    var results = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViewAndSearchBar()
    }
    
    fileprivate func setupCollectionViewAndSearchBar() {
        collectionView.backgroundColor = .white
        collectionView.register(MusicCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(MusicLoadingFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerId)
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    var timer: Timer?
    var searchText = ""
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.searchText = searchText
            Service.shared.fetchMusicContent(searchTerm: searchText, offset: 0, completion: { (musicResult, err) in
                self.isFinished = false
                musicResult?.results.forEach({self.results.append($0)})
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            })
        })
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    var isPaginating = false
    var isFinished = true
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MusicCell
        cell.result = results[indexPath.item]
        
        if (indexPath.item == results.count - 1 && !isPaginating) {
            isPaginating = true
            Service.shared.fetchMusicContent(searchTerm: searchText, offset: results.count) {[weak self] (musicResult, err) in
                sleep(1)
                musicResult?.results.forEach({self?.results.append($0)})
                
                if musicResult?.results.count == 0 {
                    self?.isFinished = true
                }
                
                DispatchQueue.main.async { [weak self] in
                    
                    self?.collectionView.reloadData()
                    self?.isPaginating = false
                }
            }
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 120)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerId, for: indexPath)
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let height: CGFloat = isFinished ? 0 : 120
        return .init(width: view.frame.width, height: height)
    }
    
}
