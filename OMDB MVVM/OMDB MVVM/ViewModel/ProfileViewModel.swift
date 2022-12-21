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

protocol IProfileViewModel:AnyObject
{
    func languageSelector() -> UIAlertController
    func saveData(name : String, overwiev : String, popularity: Float, vote : Float , image : String)
}

class ProfileViewModel:IProfileViewModel
{
    let defaults = UserDefaults.standard
}
extension ProfileViewModel
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

extension ProfileViewModel
{
    func saveData( name: String, overwiev: String, popularity: Float, vote: Float, image: String) {
       
        let profilV = ProfileV()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let wishList = NSEntityDescription.insertNewObject(forEntityName: "WishList", into: context)
        profilV.getDataForCheckArray()
        //Attributes
        
       
        
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


