//
//  ProfileViewModel.swift
//  OMDB MVVM
//
//  Created by Arda Çimen on 15.12.2022.
//

import Foundation
import UIKit
import CoreData
import Kingfisher

protocol IFavouritesViewModel:AnyObject
{
 //   func languageSelector() -> UIAlertController
    func saveData(name : String, overwiev : String, popularity: Float, vote : Float , image : String)
    func deleteData(nameForDelete : String)
}

class FavouritesViewModel:IFavouritesViewModel
{
    let defaults = UserDefaults.standard
}


extension FavouritesViewModel
{
    func saveData( name: String, overwiev: String, popularity: Float, vote: Float, image: String) {
       
        let profilV = FavouritesViewController()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let wishList = NSEntityDescription.insertNewObject(forEntityName: "WishList", into: context)
        profilV.getDataForCheckArray()
 
        if profilV.name.count > 0
        {
            var searcher = 0
            for i in 0...profilV.name.count-1
            {
                if profilV.name[i].contains(name)
                {
                    searcher = 1
                    return
                }
                else
                {
                    searcher = 0
                }
            }
            if searcher == 0
            {
            
                wishList.setValue(name, forKey: "name")
                wishList.setValue(overwiev, forKey: "overwiev")
                wishList.setValue(vote, forKey: "vote")
                wishList.setValue(popularity, forKey: "popularity")
                wishList.setValue(image, forKey: "image")
                
                
                do {
                    try context.save()
                    print("success")
                } catch {
                    print("error")
                }
            }
        }
        else
        {
          
            wishList.setValue(name, forKey: "name")
            wishList.setValue(overwiev, forKey: "overwiev")
            wishList.setValue(vote, forKey: "vote")
            wishList.setValue(popularity, forKey: "popularity")
            wishList.setValue(image, forKey: "image")
            
            
            do {
                try context.save()
                print("success")
            } catch {
                print("error")
            }
        }
    }
}

extension FavouritesViewModel
{
    func deleteData(nameForDelete: String) {
       
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WishList")
        
        
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                
                for result in results as! [NSManagedObject] {
                    
                    if let names = result.value(forKey: "name") as? String {
                        
                        if names == nameForDelete {
                            context.delete(result)
                           
            
                            do {
                                try context.save()
                            } catch {
                                print("Delete Error")
                            }
                            
                            break
                            
                        }
                    }
                }
            }
        } catch {
            print("error")
        }
    }
}

