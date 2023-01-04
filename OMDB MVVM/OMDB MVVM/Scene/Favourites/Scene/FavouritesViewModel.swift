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


final class FavouritesViewModel
{
    
    var images = [String]()
    var name = [String]()
    var comment = [String]()
    var overwiev = [String]()
    var vote = [Float]()
    var popularity = [Float]()
    
    
    func removeAll()
    {
        self.images.removeAll(keepingCapacity: false)
        self.name.removeAll(keepingCapacity: false)
        self.overwiev.removeAll(keepingCapacity: false)
        self.vote.removeAll(keepingCapacity: false)
        self.popularity.removeAll(keepingCapacity: false)
        self.comment.removeAll(keepingCapacity: false)
    }
    
   
    
    func saveData( name: String, overwiev: String, popularity: Float, vote: Float, image: String) {
       
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let wishList = NSEntityDescription.insertNewObject(forEntityName: "WishList", into: context)
 
        if self.name.count > 0
        {
            var searcher = 0
            for i in 0...self.name.count-1
            {
                if self.name[i].contains(name)
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
                print("success (save)")
            } catch {
                print("error (save)")
            }
        }
    }
    
    func deleteData(indexForDelete : Int) {
       
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WishList")
        
        
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                
                for result in results as! [NSManagedObject] {
                    
                    if let names = result.value(forKey: "name") as? String {
                        
                        if names == name[indexForDelete] {
                            context.delete(result)

                            do {
                                name.remove(at: indexForDelete)
                                images.remove(at: indexForDelete)
                                overwiev.remove(at: indexForDelete)
                                vote.remove(at: indexForDelete)
                                popularity.remove(at: indexForDelete )
                                try context.save()
                                print("success (delete)")
                            } catch {
                                print("Delete Error")
                            }
                            
                            break
                            
                        }
                    }
                }
            }
        } catch {
            print("delete error")
        }
    }
    
    
    func getDataForCheckArray(){
        
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WishList")
        
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    
                    if let name = result.value(forKey: "name") as? String {
                        self.name.append(name)
                    }
                    
                    if let images = result.value(forKey: "image") as? String {
                        self.images.append(images)
                    }
                    
                    if let vote = result.value(forKey: "vote") as? Float {
                        self.vote.append(vote)
                    }
                    
                    if let overwiev = result.value(forKey: "overwiev") as? String {
                        self.overwiev.append(overwiev)
                    }
                    
                    if let popularity = result.value(forKey: "popularity") as? Float {
                        self.popularity.append(popularity)
                    }
                }
            }
        } catch {
            print("error")
        }
    }
    
    func getData(completion: @escaping (Bool) -> Void){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WishList")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                DispatchQueue.main.async {  [self] in
                    for result in results as! [NSManagedObject] {
                        
                        if let name = result.value(forKey: "name") as? String {
                            self.name.append(name)
                        }
                        
                        if let images = result.value(forKey: "image") as? String {
                            self.images.append(images)
                        }
                        
                        if let vote = result.value(forKey: "vote") as? Float {
                            self.vote.append(vote)
                          
                        }
                        
                        if let overwiev = result.value(forKey: "overwiev") as? String {
                            self.overwiev.append(overwiev)
                        }
                        
                        if let popularity = result.value(forKey: "popularity") as? Float {
                            self.popularity.append(popularity)
                        }
                        
                        if let comment = result.value(forKey: "commentName") as? String{
                            self.comment.append(comment)
                        }
                    }
                }
                completion(true)
            }
            completion(false)
        } catch {
            print("error")
        }
        
    }
}




