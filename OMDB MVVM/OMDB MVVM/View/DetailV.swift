//
//  DetailV.swift
//  OMDB MVVM
//
//  Created by Arda Çimen on 15.12.2022.
//

import UIKit
import Kingfisher
import CoreData

class DetailV: UIViewController {

   
    
  
    var name = [String]()
    var toggleResult = Int()
  
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    
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
      
        getData()
        if self.name.count > 0
        {
            for i in 0...self.name.count-1
            {
                if TakenName == name[i]
                {
                    self.toggleResult = 1
                    navigationItem.rightBarButtonItem?.title = "♥"
                    navigationItem.rightBarButtonItem?.isEnabled = false
                }
                else
                {
                    self.toggleResult = 0
                    navigationItem.rightBarButtonItem?.title = "♡"
                }
            }
        }else{
            self.toggleResult = 0
            navigationItem.rightBarButtonItem?.title = "♡"
        }
    
    
      
        configureLabel()
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
                            self.image.layer.cornerRadius = 19
                            
                            self.pureVote = Float(self.result[i].vote_average)
                          
                            self.vote.text = "User's Vote = " + String(self.result[i].vote_average)
                            
                            self.text.text = self.result[i].overview
                           
                            self.purePopularity = self.result[i].popularity * 2 / 1000
                            self.popularity.text = "Popularity in Users " + String(format: "%.1f", self.result[i].popularity * 2 / 1000)
                           
                        
                            if self.pureVote <= 2.5 &&  self.pureVote > 0 {
                                self.voteLabel.textColor = .red
                                self.voteLabel.backgroundColor = .red
                            }else if  self.pureVote > 2.5 &&  self.pureVote <= 7.5 {
                                self.voteLabel.textColor = .yellow
                                self.voteLabel.backgroundColor = .yellow
                            }else{
                                self.voteLabel.textColor = .green
                                self.voteLabel.backgroundColor = .green
                            }
                            
                            if  self.purePopularity <= 2.5 &&   self.purePopularity > 0 {
                                self.popularityLabel.textColor = .red
                                self.popularityLabel.backgroundColor = .red
                            }else if  self.pureVote > 2.5 &&   self.purePopularity <= 8.0 {
                                self.popularityLabel.textColor = .yellow
                                self.popularityLabel.backgroundColor = .yellow
                            }else{
                                self.popularityLabel.textColor = .green
                                self.popularityLabel.backgroundColor = .green
                            }
                            
                        }
                    }
              
                }
              
                
            }
        })
                                            
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        if self.name.count > 0
        {
            for i in 0...self.name.count-1
            {
                if TakenName == name[i]
                {
                    self.toggleResult = 1
                    navigationItem.rightBarButtonItem?.title = "♥"
                    navigationItem.rightBarButtonItem?.isEnabled = false
                }
                else
                {
                    self.toggleResult = 0
                    navigationItem.rightBarButtonItem?.title = "♡"
                }
            }
        }
        
    
    }
    
    
    @IBAction func addButtonClicked(_ sender: Any) {
        getData()
   
        if self.name.count > 0
        {
            for i in 0...name.count-1
            {
                if self.TakenName == self.name[i]
                {
                    self.toggleResult = 0
                }
                else
                {
                    self.toggleResult = 1
                    navigationItem.rightBarButtonItem?.title = "♥"
                    navigationItem.rightBarButtonItem?.isEnabled = false
                }
            }
        }
        else
        {
            self.toggleResult = 1
        }
        
        
      
        
        
        
        let profilViewModel = ProfileViewModel()
        profilViewModel.saveData(name: self.filmTitle.text!, overwiev:self.text.text!, popularity: (self.pureVote) , vote: (self.pureVote), image: self.imageLink)
        
      
  
    }
}
    
   

extension DetailV
{
    private func configureLabel()
    {
     
        self.voteLabel.layer.masksToBounds = true
        self.voteLabel.layer.cornerRadius = CGRectGetWidth(self.voteLabel.frame)/2
        self.voteLabel.layer.borderWidth = 1
        self.voteLabel.layer.borderColor = UIColor.black.cgColor
     
       
        self.popularityLabel.layer.masksToBounds = true
        self.popularityLabel.layer.cornerRadius = CGRectGetWidth(self.popularityLabel.frame)/2
        self.popularityLabel.layer.borderWidth = 1
        self.popularityLabel.layer.borderColor = UIColor.black.cgColor
    }
}





extension DetailV
{
    func getData(){
        
        self.name.removeAll(keepingCapacity: false)
        self.name.removeAll(keepingCapacity: false)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WishList")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    
                    if let name = result.value(forKey: "name") as? String {
                        self.name.append(name)
                    }

                    
                }
            }
            
            
        } catch {
            print("error")
        }
        
    }
    
}
