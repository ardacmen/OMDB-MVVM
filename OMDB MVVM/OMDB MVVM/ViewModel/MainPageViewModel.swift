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
            
        })
        
        let turkish = UIAlertAction(title: "Turkish", style: .default, handler: { (fonksiyon:UIAlertAction) -> Void in
            self.defaults.set("TR",forKey: "language")
           
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
            return result.count
        }
        else{
            return 1
        }
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        print(filter)
        
        if isSearching == false{
            let x:Int! = userFilter.value(forKey: "filter")! as! Int
            switch  x {
            case 0: // if fiter == 0 it means none
                
                cell.name.text = result[indexPath.row].title
                cell.imageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w1280" + result[indexPath.row].poster_path ))
                
            case 1: // if filter == 1 it means voteLH
              
              
                var n = result.count
                   while (n > 0) {
                       var lastModifiedIndex = 0
                       for currentIndex in 1..<n {
                           if result[currentIndex - 1].vote_average < result[currentIndex].vote_average {
                               let temp = result[currentIndex - 1]
                               result[currentIndex - 1] = result[currentIndex]
                               result[currentIndex] = temp
                               lastModifiedIndex = currentIndex
                           }
                       }
                       n = lastModifiedIndex
                   }
                cell.name.text = result[indexPath.row].title
                cell.imageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w1280" + result[indexPath.row].poster_path ))
               
            case 2:
                
                
                var n = result.count
                   while (n > 0) {
                       var lastModifiedIndex = 0
                       for currentIndex in 1..<n {
                           if result[currentIndex - 1].vote_average > result[currentIndex].vote_average {
                               let temp = result[currentIndex - 1]
                               result[currentIndex - 1] = result[currentIndex]
                               result[currentIndex] = temp
                               lastModifiedIndex = currentIndex
                           }
                       }
                       n = lastModifiedIndex
                   }
                cell.name.text = result[indexPath.row].title
                cell.imageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w1280" + result[indexPath.row].poster_path ))
                
                
            case 3:
                
                
                var n = result.count
                   while (n > 0) {
                       var lastModifiedIndex = 0
                       for currentIndex in 1..<n {
                           if result[currentIndex - 1].popularity < result[currentIndex].popularity {
                               let temp = result[currentIndex - 1]
                               result[currentIndex - 1] = result[currentIndex]
                               result[currentIndex] = temp
                               lastModifiedIndex = currentIndex
                           }
                       }

                       n = lastModifiedIndex
                   }
                cell.name.text = result[indexPath.row].title
                cell.imageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w1280" + result[indexPath.row].poster_path ))
                
                
            case 4:
                
                
                var n = result.count
                   while (n > 0) {
                       var lastModifiedIndex = 0
                       for currentIndex in 1..<n {
                           if result[currentIndex - 1].popularity > result[currentIndex].popularity {
                               let temp = result[currentIndex - 1]
                               result[currentIndex - 1] = result[currentIndex]
                               result[currentIndex] = temp
                               lastModifiedIndex = currentIndex
                           }
                       }
                       n = lastModifiedIndex
                   }
                cell.name.text = result[indexPath.row].title
                cell.imageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w1280" + result[indexPath.row].poster_path ))
                
                
            default:
                break
            }
            
        
        }else{
          
            let text = searchController.searchBar.text
            
            for i in 0...result.count-1
            {
                if(result[i].title.lowercased()).contains(text!.lowercased())
                {
                    cell.name.text = result[i].title
                    cell.imageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w1280" + result[i].poster_path ))
                }
            }
          
        }
        
        return cell
        
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




