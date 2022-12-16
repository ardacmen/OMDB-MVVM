//
//  FilterV.swift
//  OMDB MVVM
//
//  Created by Arda Çimen on 15.12.2022.
//

import UIKit

class FilterV: UIViewController {

    let filterViewModels = FilterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func voteLH(_ sender: Any) {
        filterViewModels.voteLH()
        self.makeAlert(titleInput: "Selected!", messageInput: "Vote -> Lowest to Highest")
    }
    
    @IBAction func voteHL(_ sender: Any) {
        filterViewModels.voteHL()
        self.makeAlert(titleInput: "Selected!", messageInput: "Vote -> Highest to Lowest")
    }
    
    @IBAction func popularityLH(_ sender: Any) {
        filterViewModels.popularityLH()
        self.makeAlert(titleInput: "Selected!", messageInput: "popularity -> Lowest to Highest")
    }
    
    
    @IBAction func popularityHL(_ sender: Any) {
        filterViewModels.popularityLH()
        self.makeAlert(titleInput: "Selected!", messageInput: "popularity -> Highest to Lowest")
    }

    
}
