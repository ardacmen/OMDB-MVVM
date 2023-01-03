//
//  SettingsViewController.swift
//  OMDB MVVM
//
//  Created by Arda Çimen on 1.01.2023.
//

import UIKit

class SettingsViewController: UIViewController {

    
    let settingsViewModel = SettingsViewModel()
    
    @IBOutlet weak var darkModeSwitch: UISwitch!
  
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
        if UserDefaults.standard.bool(forKey: "darkMode") == true {
            darkModeSwitch.isOn = true
        }
        else
        {
            darkModeSwitch.isOn = false
        }
    }
     
    @IBAction func darkModeSwitchChanged(_ sender: Any) {
        settingsViewModel.darkModeSwitchChecker(darkModeSwitch: self.darkModeSwitch)
        self.configure()
    }

    private func configure()
    {
        if UserDefaults.standard.bool(forKey: "darkMode") == false
        {
            overrideUserInterfaceStyle = .light
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        }else{
            overrideUserInterfaceStyle = .dark
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
    }
}




/*
 let alert = UIAlertController(title: "Select Font Size", message: "Please Select an Option", preferredStyle: .actionSheet)
    
    alert.addAction(UIAlertAction(title: "Small (15px)", style: .default , handler:{ (UIAlertAction)in
        settingsViewModel.smallFont()
        self.configure()
    }))
    
    alert.addAction(UIAlertAction(title: "Medium (17px)", style: .default , handler:{ (UIAlertAction)in
        settingsViewModel.medFont()
        self.configure()
    }))

    alert.addAction(UIAlertAction(title: "Large (19px)", style: .default , handler:{ (UIAlertAction)in
        settingsViewModel.largeFont()
        self.configure()
    }))
   alert.addAction(UIAlertAction(title: "Cancel", style: .cancel , handler:{ (UIAlertAction)in
           
   }))
    
   present(alert, animated: true, completion: {})
 */
