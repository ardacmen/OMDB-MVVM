//
//  SettingsViewController.swift
//  OMDB MVVM
//
//  Created by Arda Çimen on 1.01.2023.
//

import UIKit

class SettingsViewController: UIViewController {

    
    
    @IBOutlet weak var darkModeSwitch: UISwitch!
    @IBOutlet weak var resetAllData: UILabel!
    @IBOutlet weak var selectFontSizeLabel: UILabel!
    @IBOutlet weak var sendFeedBackLabel: UILabel!
    @IBOutlet weak var darkModeLabel: UILabel!
    
    
    let mainPageV = MainPageViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
        if mainPageV.darkMode.bool(forKey: "darkMode") == true{
            darkModeSwitch.isOn = true
        }
        else
        {
            darkModeSwitch.isOn = false
        }
        
        let reset = UITapGestureRecognizer(target: self, action: #selector(resetAllDataa))
        resetAllData.addGestureRecognizer(reset)
        
        let fontSize = UITapGestureRecognizer(target: self, action: #selector(fontSize))
        selectFontSizeLabel.addGestureRecognizer(fontSize)
        
        let sendFeedBack = UITapGestureRecognizer(target: self, action: #selector(sendFeedBack))
        sendFeedBackLabel.addGestureRecognizer(sendFeedBack)
        
    }
    
    @IBAction func darkModeSwitchChanged(_ sender: Any) {
        if darkModeSwitch.isOn == true
        {
            mainPageV.darkMode.set(true, forKey: "darkMode")
            self.configure()
        }
        else
        {
            mainPageV.darkMode.set(false, forKey: "darkMode")
            self.configure()
        }
    }
    
    @objc func sendFeedBack()
    {
        let url = URL(string: "http://www.hypersuperprojects.com/contact/")!
        UIApplication.shared.open(url)
    }
                                        
    @objc func resetAllDataa()
    {
        let settingsViewModel = SettingsViewModel()
        if settingsViewModel.deleteAllData() == true
        {
            self.makeAlert(titleInput: "Success!", messageInput: "All Datas Are Deleted")
        }
        else
        {
            self.makeAlert(titleInput: "Error!", messageInput: "All Datas Can't Deleted")
        }
    }
    
    @objc func fontSize()
    {
        let settingsViewModel = SettingsViewModel()
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
    }
    
    private func configure()
    {
        
        if mainPageV.fonts.integer(forKey: "font") == 15
        {
            self.resetAllData.font = UIFont.systemFont(ofSize: 15.0)
            self.selectFontSizeLabel.font = UIFont.systemFont(ofSize: 15.0)
            self.sendFeedBackLabel.font = UIFont.systemFont(ofSize: 15.0)
            self.darkModeLabel.font = UIFont.systemFont(ofSize: 15.0)
        }
        else if mainPageV.fonts.integer(forKey: "font") == 17
        {
            self.resetAllData.font = UIFont.systemFont(ofSize: 17.0)
            self.selectFontSizeLabel.font = UIFont.systemFont(ofSize: 17.0)
            self.sendFeedBackLabel.font = UIFont.systemFont(ofSize: 17.0)
            self.darkModeLabel.font = UIFont.systemFont(ofSize: 17.0)
        }
        else
        {
            self.resetAllData.font = UIFont.systemFont(ofSize: 19.0)
            self.selectFontSizeLabel.font = UIFont.systemFont(ofSize: 19.0)
            self.sendFeedBackLabel.font = UIFont.systemFont(ofSize: 19.0)
            self.darkModeLabel.font = UIFont.systemFont(ofSize: 19.0)
        }
        
        if mainPageV.darkMode.bool(forKey: "darkMode") == false
        {
            overrideUserInterfaceStyle = .light
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        }else{
            overrideUserInterfaceStyle = .dark
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        
        self.darkModeLabel.layer.cornerRadius = 10
        self.sendFeedBackLabel.layer.cornerRadius = 10
        self.selectFontSizeLabel.layer.cornerRadius = 10
        self.resetAllData.layer.cornerRadius = 10
      
       
        self.darkModeLabel.backgroundColor = UIColor.systemGray6
        self.sendFeedBackLabel.backgroundColor = UIColor.systemGray6
        self.selectFontSizeLabel.backgroundColor = UIColor.systemGray6
        self.resetAllData.backgroundColor = UIColor.systemGray6
        
        
        self.resetAllData.addLeading(image: UIImage(systemName: "trash.slash") ?? UIImage(), text: " Reset all Data? ")
        self.darkModeLabel.addLeading(image: UIImage(systemName: "eye") ?? UIImage(), text: " Dark Mode? ")
        self.sendFeedBackLabel.addLeading(image: UIImage(systemName: "pencil.circle") ?? UIImage(), text: " Send Feedback ")
        self.selectFontSizeLabel.addLeading(image: UIImage(systemName: "textformat.size.larger") ?? UIImage(), text: " Select Font Size")
        
        
    }
}



