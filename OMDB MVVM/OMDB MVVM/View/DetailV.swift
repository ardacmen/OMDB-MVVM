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
    let detailViewModel = DetailViewModel()
    let service = WebService()
    var result = [Result]()
    var imageLink = String()
    var pureVote = Float()
    var purePopularity = Float()
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
                            self.imageLink = "https://image.tmdb.org/t/p/w1280" + self.result[i].poster_path
                            self.image.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w1280" + self.result[i].poster_path ))
                            
                            self.pureVote = Float(self.result[i].vote_average)
                          
                            self.vote.text = "User's Vote = " + String(self.result[i].vote_average)
                            
                            self.text.text = self.result[i].overview
                           
                            self.purePopularity = self.result[i].popularity * 2 / 1000
                            self.popularity.text = "Popularity in Users " + String(format: "%.1f", self.result[i].popularity * 2 / 1000)
                           
                        
                            if self.pureVote <= 2.5 &&  self.pureVote > 0 {
                                self.vote.backgroundColor = .red
                            }else if  self.pureVote > 2.5 &&  self.pureVote <= 7.5 {
                                self.vote.backgroundColor = .yellow
                            }else{
                                self.vote.backgroundColor = .green
                            }
                            
                            if  self.purePopularity <= 2.5 &&   self.purePopularity > 0 {
                                self.popularity.backgroundColor = .red
                            }else if  self.pureVote > 2.5 &&   self.purePopularity <= 8.0 {
                                self.popularity.backgroundColor = .yellow
                            }else{
                                self.popularity.backgroundColor = .green
                            }
                            
                        }
                    }
              
                }
              
                
            }
        })
                                            
       
    }
    

    
    @IBAction func addButtonClicked(_ sender: Any) {
                let profilViewModel = ProfileViewModel()
                profilViewModel.saveData(name: self.filmTitle.text!, overwiev: self.text.text!, popularity: (self.pureVote) , vote: (self.pureVote), image: self.imageLink)
    }
    
}

