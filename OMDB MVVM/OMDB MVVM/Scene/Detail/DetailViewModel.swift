//
//  DetailViewModel.swift
//  OMDB MVVM
//
//  Created by Arda Çimen on 15.12.2022.
//

import Foundation
import UIKit
import CoreData


final class DetailViewModel
{
   

    var name = [String]()
    var result = [Result]()
    let service = WebService()
    
    func fontSizeReturner() -> Int
    {
        return UserDefaults.standard.integer(forKey: "font")
    }
    
    func fetchData( completion: @escaping (Bool) -> Void)
    {
        service.getCharacters(completion: { data in
            DispatchQueue.main.async { [self] in
                self.result = data!
                completion(true)
            }
            completion(false)
        })
    }
    
    func getData(){
        self.name.removeAll(keepingCapacity: false)
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

                    
                }
            }
            
            
        } catch {
            print("error")
        }
    }
    
    
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
    
    func isAdded(takenName : String) -> Bool
    {
        getData()
        var searcher = 0
        if self.name.count > 0
        {
            for i in 0...name.count-1
            {
                if takenName == self.name[i]
                {
                    searcher = 1
                }
            }
        }
            
            
        if searcher == 1
        {
            return true
        }
        else
        {
            return false
        }
        
    }
    
    func voteLabelBackGroundColor(vote : Float) -> UIColor
    {
        if vote <= 2.5 &&  vote > 0 {
            return  .red
        }
        else if  vote > 2.5 &&  vote <= 7.5
        {
            return .yellow
        }
        else
        {
            return .green
        }
    }
    
    func popularityLabelBackGroundColor(popularity : Float) -> UIColor
    {
        if  popularity <= 2.5 &&  popularity > 0 {
            return .red
        }else if  popularity > 2.5 &&   popularity <= 8.0 {
            return .yellow
        }else{
            return .green
        }
    }
    
    func returnBlankHeart() -> UIColor
    {
        if UserDefaults.standard.bool(forKey: "darkMode") == false
        {
            return .black
        }
        else
        {
            return .white
        }
    }
    
    func returnFilledHeart() -> UIColor
    {
        if UserDefaults.standard.bool(forKey: "darkMode") == false
        {
            return .black
        }
        else
        {
            return .red
        }
    }
}

