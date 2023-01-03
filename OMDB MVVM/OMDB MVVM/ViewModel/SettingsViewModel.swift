//
//  MainPageViewModel.swift
//  OMDB MVVM
//
//  Created by Arda Çimen on 11.12.2022.
//


import Foundation
import CoreData
import UIKit

protocol ISettingsViewModel:AnyObject {
    func deleteAllData() -> Bool
    func smallFont()
    func medFont()
    func largeFont()
}

class  SettingsViewModel: ISettingsViewModel
{
    let mainPageViewController = MainPageViewController()
}




extension SettingsViewModel
{
    func deleteAllData() -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WishList")
        fetchRequest.returnsObjectsAsFaults = false

        do {
            let arrUsrObj = try managedContext.fetch(fetchRequest)
            for usrObj in arrUsrObj as! [NSManagedObject] {
                managedContext.delete(usrObj)
                return true
            }
           try managedContext.save() //don't forget
            } catch let error as NSError {
            print(error)
            return false
          }
        return true
    }
}





extension SettingsViewModel
{
   
    func smallFont() {
        print("fonts are now 15")
        mainPageViewController.fonts.set(15,forKey: "font")
    }
    
    func medFont() {
        print("fonts are now 17")
        mainPageViewController.fonts.set(17,forKey: "font")
    }
    
    func largeFont() {
        print("fonts are now 19")
        mainPageViewController.fonts.set(19,forKey: "font")
    }
}
