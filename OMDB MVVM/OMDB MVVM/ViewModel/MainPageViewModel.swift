//
//  MainPageViewModel.swift
//  OMDB MVVM
//
//  Created by Arda Çimen on 11.12.2022.
//

import Foundation
import UIKit


protocol IMainPageViewModel:AnyObject {
    func languageSelector() -> UIAlertController
}

class  MainPageViewModel: IMainPageViewModel
{
    let defaults = UserDefaults.standard
}


extension MainPageViewModel
{
    func languageSelector() -> UIAlertController{
        let menu = UIAlertController(title: "Select Language", message: "You Can Choose Your Prefered Language", preferredStyle: .actionSheet)
        
        let english = UIAlertAction(title: "English", style: .default, handler: {
            (fonksiyon:UIAlertAction) -> Void in
            self.defaults.set("EN",forKey: "language")
            print(self.defaults.string(forKey: "language")!)
        })
        
        let turkish = UIAlertAction(title: "Turkish", style: .default, handler: { (fonksiyon:UIAlertAction) -> Void in
            self.defaults.set("TR",forKey: "language")
            print(self.defaults.string(forKey: "language")!)
        })
        
        
        menu.addAction(english)
        menu.addAction(turkish)
        
        return menu
    }
}







extension MainPageV : UICollectionViewDelegate
{
    
}

extension MainPageV : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearching == false{
            print(result.count)
            return result.count
        }
        else{
            return 1
        }
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if isSearching == false{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
            cell.name.text = result[indexPath.row].title
            cell.imageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w1280" + result[indexPath.row].poster_path ))
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
            let text = searchController.searchBar.text
            
            for i in 0...result.count-1
            {
                if(result[i].title.lowercased()).contains(text!.lowercased())
                {
                    cell.name.text = result[i].title
                    cell.imageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w1280" + result[i].poster_path ))
                }
            }
            return cell
        }
    }
    
    
    
}

extension MainPageV: UISearchResultsUpdating
{
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.isActive == true{
            isSearching = true
            collectionView.reloadData()
        }else{
            isSearching = false
            collectionView.reloadData()
        }
    }
}


