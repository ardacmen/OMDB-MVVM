//
//  FavouritesDetailViewModel.swift
//  OMDB MVVM
//
//  Created by Arda Çimen on 3.01.2023.
//

import Foundation
import UIKit


final class FavouritesDetailViewModel
{
    
    func returnVoteColor(vote : Float) -> UIColor
    {
        if vote > 0 && vote < 2.5
        {
            return .red
        }
        else if vote >= 2.5 && vote < 7.5
        {
            return .yellow
        }
        else
        {
           return .green
        }
    }
    
    func returnPopularityColor(popularity : Float) -> UIColor
    {
        if popularity > 0 && popularity < 2.5
        {
            return .red
        }
        else if popularity >= 2.5 && popularity < 9.5
        {
            return .yellow
        }
        else
        {
           return .green
        }
    }
    
    func fontSizeReturner() -> Int
    {
        return UserDefaults.standard.integer(forKey: "font")
    }
    
    
}
