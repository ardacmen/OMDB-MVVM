//
//  ProfileViewModel.swift
//  OMDB MVVM
//
//  Created by Arda Çimen on 15.12.2022.
//

import Foundation
import UIKit

protocol IProfileViewModel:AnyObject
{
    func languageSelector() -> UIAlertController
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
