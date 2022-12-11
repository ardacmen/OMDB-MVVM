//
//  MainPageV.swift
//  OMDB MVVM
//
//  Created by Arda Çimen on 11.12.2022.
//

import UIKit
import Kingfisher

class MainPageV: UIViewController{

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

}


extension MainPageV : UICollectionViewDelegate
{
    
}

extension MainPageV : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return result.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.name.text = result[indexPath.row].title
        
        
        cell.imageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w1280" + result[indexPath.row].poster_path ))
        
        return cell
    }
   
    
    
}
