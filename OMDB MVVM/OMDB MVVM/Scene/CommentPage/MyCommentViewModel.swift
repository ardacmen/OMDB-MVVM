//
//  MainPageViewModel.swift
//  OMDB MVVM
//
//  Created by Arda Çimen on 11.12.2022.


import Foundation
import UIKit
import CoreData

final class  MyCommentViewModel
{
    
    var name = [String]()
    var comment = [String]()
    var vote = [String]()
    var indexCountForCheckWhenDidLoad = Int()
    
    
  
    func validateVote(takenName: String, myCommentTextField: String, yourVoteTextField: String) -> Bool
    {
        if (yourVoteTextField == "")
        {
            print("empty")
        }
        else
        {
           var newText = yourVoteTextField.doubleValue
            
            if newText > 10 && newText < 0
            {
                return false
            }
            else
            {
                saveData(takenName: takenName, myCommentTextField:  myCommentTextField, yourVoteTextField: yourVoteTextField)
                return true
            }
           
        }
        return false
    }
    
    func checkdataIsAdd(takenName : String) -> Bool
    {
        if name.count > 0
        {
            for i in 0...name.count-1
            {
             if name[i] == takenName
             {
                 indexCountForCheckWhenDidLoad = i
                 return true
             }
            }
            return false
        }
        return false
    }
    
    func getData()
    {
        self.name.removeAll(keepingCapacity: false)
        self.vote.removeAll(keepingCapacity: false)
        self.comment.removeAll(keepingCapacity: false)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WishList")
        
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    
                    if let name = result.value(forKey: "commentName") as? String {
                        self.name.append(name)
                    }
                    
                    if let comment = result.value(forKey: "commentText") as? String{
                        self.comment.append(comment)
                    }
                    
                    if let vote = result.value(forKey: "commentVote") as? String {
                        self.vote.append(vote)
                    }
                       
                }
            }
            
            
        } catch {
            print("error")
        }
        print(vote)
        print(name)
    }
    
    func saveData(takenName : String, myCommentTextField : String, yourVoteTextField : String )
    {
        deleteIndex(takenName: takenName)
        getData()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let Comment = NSEntityDescription.insertNewObject(forEntityName: "WishList", into: context)

        Comment.setValue(takenName, forKey: "commentName")
        Comment.setValue(myCommentTextField, forKey: "commentText")
        Comment.setValue(yourVoteTextField, forKey: "commentVote")
                do {
                    try context.save()
                    print("success")
                } catch {
                    print("error")
                }
    }
    
    func deleteIndex(takenName : String)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WishList")
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                
                for result in results as! [NSManagedObject] {
                    
                    if let names = result.value(forKey: "commentName") as? String {
                            if names == takenName  {
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
    
    func fontSizeReturner() -> Int
    {
        return UserDefaults.standard.integer(forKey: "font")
    }
    
    
    func checkAndDelete(checkName : String)
    {
        getData()
        var searcher = 0
        if name.count > 0
        {
            for i in 0...name.count-1
            {
                if name[i] == checkName
                {
                    searcher = 1
                }
            }
        }
        if searcher == 1
        {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WishList")
            
            do {
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    
                    for result in results as! [NSManagedObject] {
                        
                        if let names = result.value(forKey: "commentName") as? String {
                            
                            if names == checkName {
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
    
}






