//
//  DetailViewModel.swift
//  OMDB MVVM
//
//  Created by Arda Çimen on 15.12.2022.
//

import Foundation
import UIKit
import CoreData


protocol IDetailViewModel:AnyObject
{
    func deleteData(nameForDelete : String)
}
class DetailViewModel : IDetailViewModel
{

}
extension DetailViewModel
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
