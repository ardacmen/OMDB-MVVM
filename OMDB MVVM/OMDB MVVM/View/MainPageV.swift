//
//  MainPageV.swift
//  OMDB MVVM
//
//  Created by Arda Çimen on 11.12.2022.
//

import UIKit
import Kingfisher

class MainPageV: UIViewController{
    
      var filter: Int = 0
      let userFilter = UserDefaults.standard
      var isSearching = false
      let mainPageViewModel = MainPageViewModel()
      let service = WebService()
      var result = [Result]()
      var searchedResult = [Result]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
   let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        userFilter.set(0, forKey: "filter")
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        collectionView.delegate = self
        collectionView.dataSource = self
          service.getCharacters(completion: { data in
              DispatchQueue.main.async {
                  self.result = data!
                  self.collectionView.reloadData()
              }
          })
      }
    override func viewWillAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }
   
    
   
    
    
    
  
    
}



