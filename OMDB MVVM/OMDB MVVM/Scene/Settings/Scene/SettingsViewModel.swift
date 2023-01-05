//
//  MainPageViewModel.swift
//  OMDB MVVM
//
//  Created by Arda Çimen on 11.12.2022.
//


import Foundation
import CoreData
import UIKit


final class  SettingsViewModel
{
    let mainPageViewController = MainPageViewController()
    var nameArray = [String]()
    var nameArrayEmoji = [String]()
    
    
    func addValuesForArrays()
    {
        nameArray.append("Language")
        nameArray.append("Font Size Selector")
        nameArray.append("Delete All Data")
        
        nameArrayEmoji.append("book.fill")
        nameArrayEmoji.append("trash.fill")
        nameArrayEmoji.append("textformat.size")
        
    }
    
    func darkModeSwitchChecker(darkModeSwitch : UISwitch)
    {
        if darkModeSwitch.isOn == true
        {
            UserDefaults.standard.set(true, forKey: "darkMode")
        }
        else
        {
            UserDefaults.standard.set(false, forKey: "darkMode")
        }
    }
    
    func deleteAllData()   {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WishList")
        fetchRequest.returnsObjectsAsFaults = false

        do {
            let arrUsrObj = try managedContext.fetch(fetchRequest)
            for usrObj in arrUsrObj as! [NSManagedObject] {
                managedContext.delete(usrObj)
            }
           try managedContext.save()
            } catch let error as NSError {
            print(error)
          }
    }
    
    
    
    func smallFont() {
        UserDefaults.standard.set(15,forKey: "font")
    }
    
    func medFont() {
        UserDefaults.standard.set(17,forKey: "font")
    }
    
    func largeFont() {
        UserDefaults.standard.set(19,forKey: "font")
    }
}







