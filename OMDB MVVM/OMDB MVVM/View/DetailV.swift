//
//  DetailV.swift
//  OMDB MVVM
//
//  Created by Arda Çimen on 15.12.2022.
//

import UIKit
import Kingfisher

class DetailV: UIViewController {

   
    
    @IBOutlet weak var filmTitle: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var vote: UILabel!
    @IBOutlet weak var text: UITextView!
    @IBOutlet weak var popularity: UILabel!
    var TakenName = String()
    let mainPageV = MainPageV()
    let service = WebService()
    var result = [Result]()
    override func viewDidLoad() {
        super.viewDidLoad()
        service.getCharacters(completion: { data in
            DispatchQueue.main.async { [self] in
                self.result = data!
                if self.mainPageV.isSearching == false
                {
                    for i in 0...self.result.count-1
                    {
                        if self.result[i].title == self.TakenName
                        {
                            
                            self.filmTitle.text = self.result[i].title
                            
                            self.image.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w1280" + self.result[i].poster_path ))
                            
                            self.vote.text = "User's Vote = " + String(self.result[i].vote_average)
                            
                            self.text.text = self.result[i].overview
                            
                            self.popularity.text = "Popularity in Users " + String(format: "%.1f", self.result[i].popularity * 2 / 1000)
                        }
                    }
              
                }
               
                
            }
        })
                                            
       
    }
    

    

}
/*
 self.filmTitle.text = self.result[self.TakenIndex].title
 
 self.image.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w1280" + self.result[self.TakenIndex].poster_path ))
 
 self.vote.text = "User's Vote = " + String(self.result[self.TakenIndex].vote_average)
 
 self.text.text = self.result[self.TakenIndex].overview
 
 self.popularity.text = "" + String(self.result[self.TakenIndex].popularity)
 */
