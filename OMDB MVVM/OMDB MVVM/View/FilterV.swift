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
    }
    
    @IBAction func voteHL(_ sender: Any) {
        filterViewModels.voteHL()
    }
    
    @IBAction func popularityLH(_ sender: Any) {
        filterViewModels.popularityLH()
    }
    
    
    @IBAction func popularityHL(_ sender: Any) {
        filterViewModels.popularityHL()
    }

    
}
