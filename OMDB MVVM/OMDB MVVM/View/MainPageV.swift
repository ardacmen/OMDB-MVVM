//
//  MainPageV.swift
//  OMDB MVVM
//
//  Created by Arda Çimen on 11.12.2022.
//

import UIKit
import Kingfisher

class MainPageV: UIViewController{

      let mainPageViewModel = MainPageViewModel()
      let service = WebService()
      var result = [Result]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
          service.getCharacters(completion: { data in
              DispatchQueue.main.async {
                  self.result = data!
                  self.collectionView.reloadData()
              }
          })
      }
    
    @IBAction func Filter(_ sender: Any) {
        
    }
    
    
    @IBAction func Language(_ sender: Any) {
        
        let menu =  mainPageViewModel.languageSelector()
        self.present(menu, animated: true, completion: nil)
        
    }
    
}


