//
//  FilterViewModel.swift
//  OMDB MVVM
//
//  Created by Arda Çimen on 15.12.2022.
//

import Foundation

protocol IFilterViewModel : AnyObject
{
    
    func voteLH()
    func voteHL()
    func popularityLH()
    func popularityHL()
    
}

class FilterViewModel : IFilterViewModel
{
    let mainPageVs = MainPageV()
}

extension FilterViewModel
{
    // if fiter == 0 it means none
    // if filter == 1 it means filter voteLH
    // if filter == 2 it means filter voteHL
    // if ilter == 3 it means filter popularityLH
    // if filter == 4 it means filter  popularityHL
    func voteLH() {
        mainPageVs.userFilter.set(1, forKey: "filter")
    }
    
    func voteHL() {
        mainPageVs.userFilter.set(2, forKey: "filter")
    }
    
    func popularityLH() {
        mainPageVs.userFilter.set(3, forKey: "filter")
    }
    
    func popularityHL() {
        mainPageVs.userFilter.set(4, forKey: "filter")
    }
    
}

