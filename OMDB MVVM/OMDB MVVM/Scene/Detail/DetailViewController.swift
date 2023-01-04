//
//  DetailV.swift
//  OMDB MVVM
//
//  Created by Arda Çimen on 15.12.2022.
//

import UIKit
import Kingfisher
import CoreData

class DetailViewController: UIViewController {


   
  
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var vote: UILabel!
    @IBOutlet weak var text: UITextView!
    @IBOutlet weak var popularity: UILabel!
    
    let detailViewModel = DetailViewModel()
    
    
   
    
    var TakenName = String()
    var imageLink = String()
    var pureVote = Float()
    var purePopularity = Float()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailViewModel.getData()
        let isAdded = detailViewModel.isAdded(takenName: TakenName)
        
        if isAdded == true
        {
            returnFilledHeart()
        }
        else
        {
            returnBlankHeart()
        }
    
        detailViewModel.fetchData(completion: { data in
            DispatchQueue.main.async { [self] in
                configureLabel()
            }
        })
        
    }
      
    

    @IBAction func addButtonClicked(_ sender: Any) {
        let isAdded =  detailViewModel.isAdded(takenName: TakenName)
        
        
        if isAdded == true
        {
            detailViewModel.deleteData(nameForDelete: TakenName)
            returnBlankHeart()
        }
        else
        {
            let favouritesViewModel = FavouritesViewModel()
            favouritesViewModel.saveData(name: TakenName, overwiev:self.text.text!, popularity: (self.purePopularity) , vote: (self.pureVote), image: self.imageLink)
            returnFilledHeart()
        }
    }
}
    



extension DetailViewController
{
    
    private func configureLabel()
    {
        for i in 0...detailViewModel.result.count-1
        {
            if detailViewModel.result[i].title == self.TakenName
            {
                
                pureVote = Float(detailViewModel.result[i].vote_average!)!
                purePopularity = Float(detailViewModel.result[i].popularity!)! * 2 / 1000
                
                self.imageLink = "https://image.tmdb.org/t/p/w1280" + detailViewModel.result[i].poster_path!
                self.image.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w1280" + detailViewModel.result[i].poster_path! ))
                self.image.layer.cornerRadius = 19
                
               
                self.vote.text = "User's Vote  "
                self.voteLabel.text = String(detailViewModel.result[i].vote_average!)
                
                
                self.text.text = detailViewModel.result[i].overview
               
    
                self.popularity.text = "Popularity in Users "
                self.popularityLabel.text = String(format: "%.1f",  (Float(detailViewModel.result[i].popularity!)! * 2 / 1000))
            
                
             
                self.voteLabel.backgroundColor =   detailViewModel.voteLabelBackGroundColor(vote: Float(detailViewModel.result[i].vote_average!)!)
                
                self.popularityLabel.backgroundColor = detailViewModel.popularityLabelBackGroundColor(popularity:  Float(detailViewModel.result[i].popularity!)! * 2 / 1000)
            
            }
        
    }
        
        
        if UserDefaults.standard.bool(forKey: "darkMode") == false
        {
            overrideUserInterfaceStyle = .light
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        }else{
            overrideUserInterfaceStyle = .dark
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        
        
        
        
        self.voteLabel.layer.masksToBounds = true
        self.voteLabel.layer.cornerRadius = CGRectGetWidth(self.voteLabel.frame)/2
        self.voteLabel.layer.borderWidth = 1
        self.voteLabel.layer.borderColor = UIColor.black.cgColor
        self.voteLabel.textColor = .black
        
        
        self.popularityLabel.layer.masksToBounds = true
        self.popularityLabel.layer.cornerRadius = CGRectGetWidth(self.popularityLabel.frame)/2
        self.popularityLabel.layer.borderWidth = 1
        self.popularityLabel.layer.borderColor = UIColor.black.cgColor
        self.popularityLabel.textColor = .black
        
    }
    
    
    func returnBlankHeart(){
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")?.withTintColor(detailViewModel.returnBlankHeart(), renderingMode: .alwaysOriginal)
    }
    func returnFilledHeart(){
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill")?.withTintColor(detailViewModel.returnFilledHeart(), renderingMode: .alwaysOriginal)
    }
    
}
/*
 if mainPageV.fonts.integer(forKey: "font") == 15
 {
     self.text.font = UIFont.systemFont(ofSize: 15.0)
     self.vote.font = UIFont.systemFont(ofSize: 15.0)
     self.popularityLabel.font = UIFont.systemFont(ofSize: 15.0)
     self.popularity.font = UIFont.systemFont(ofSize: 15.0)
     self.voteLabel.font = UIFont.systemFont(ofSize: 15.0)
 }
 else if mainPageV.fonts.integer(forKey: "font") == 17 {
     self.text.font = UIFont.systemFont(ofSize: 17.0)
     self.vote.font =  UIFont.systemFont(ofSize: 17.0)
     self.popularityLabel.font =  UIFont.systemFont(ofSize: 17.0)
     self.popularity.font =  UIFont.systemFont(ofSize: 17.0)
     self.voteLabel.font = UIFont.systemFont(ofSize: 17.0)
 }
 else{
     self.vote.font = UIFont.systemFont(ofSize: 19.0)
     self.text.font = UIFont.systemFont(ofSize: 19.0)
     self.popularityLabel.font = UIFont.systemFont(ofSize: 19.0)
     self.popularity.font = UIFont.systemFont(ofSize: 19.0)
     self.voteLabel.font = UIFont.systemFont(ofSize: 19.0)
 }
 */
