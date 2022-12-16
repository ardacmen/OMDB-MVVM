//
//  ProfileV.swift
//  OMDB MVVM
//
//  Created by Arda Çimen on 15.12.2022.
//

import UIKit

class ProfileV: UIViewController {

    var profileViewModel = ProfileViewModel()
    @IBAction func languageClicked(_ sender: Any) {
        var menu = profileViewModel.languageSelector()
        present(menu, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    


}
