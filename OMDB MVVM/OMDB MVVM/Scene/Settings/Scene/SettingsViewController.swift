//
//  SettingsViewController.swift
//  OMDB MVVM
//
//  Created by Arda Çimen on 1.01.2023.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var darkModeEmojiLabel: UILabel!
    

    
    let settingsViewModel = SettingsViewModel()
    
    @IBOutlet weak var settingsTableView: UITableView!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    

    
    
    override func viewDidLoad() {
       
        
        
        super.viewDidLoad()
        configure()
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        settingsViewModel.addValuesForArrays()
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
            darkModeEmojiLabel.addTrailing(image: UIImage(systemName: "eyes.inverse")!, text: "")
        }else{
            darkModeEmojiLabel.addTrailing(image: UIImage(systemName: "eyes")!.withTintColor(.white), text: "")
            overrideUserInterfaceStyle = .dark
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        settingsTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsViewModel.nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SettingsTableViewCell
        
        
        cell.nameLabel.text = settingsViewModel.nameArray[indexPath.row]
        
        if UserDefaults.standard.bool(forKey: "darkMode") == true
        {
            print(UserDefaults.standard.bool(forKey: "darkMode"))
            cell.nameLabelsEmoji.addTrailing(image: UIImage(systemName: settingsViewModel.nameArrayEmoji[indexPath.row])!.withTintColor(.white) , text: "")
        }
        else
        {
            print(UserDefaults.standard.bool(forKey: "darkMode"))
            cell.nameLabelsEmoji.addTrailing(image: UIImage(systemName: settingsViewModel.nameArrayEmoji[indexPath.row])!.withTintColor(.black), text: "")
        }
       
        
        return cell
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
