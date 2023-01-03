//
//  CoreDataDetailsViewController.swift
//  OMDB MVVM
//
//  Created by Arda Çimen on 24.12.2022.
//

import UIKit
import Kingfisher
import CoreData

class CoreDataDetailsViewController: UIViewController {

   
    
    @IBOutlet weak var addComment: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var overWiev: UITextView!
    @IBOutlet weak var voteDesc: UILabel!
    @IBOutlet weak var popularitDesc: UILabel!
    @IBOutlet weak var vote: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    
    var takenName = String()
    var takenVote = Float()
    var takenImage = String()
    var takenOverwiev = String()
    var takenPopularity = Float()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure(){
        self.overWiev.text = self.takenOverwiev
        self.popularitDesc.text = "Popluarity in Users "
        self.voteDesc.text = "Users Vote for Film "
        self.vote.text = String(self.takenVote)
        self.popularityLabel.text = String(format: "%.1f", self.takenPopularity)
        self.imageView.kf.setImage(with: URL(string: takenImage))
        self.vote.layer.masksToBounds = true
        self.vote.layer.cornerRadius = CGRectGetWidth(self.vote.frame)/2
        self.vote.layer.borderWidth = 1
        self.vote.layer.borderColor = UIColor.black.cgColor
        self.vote.textColor = .black
        self.popularityLabel.textColor = .black
        self.popularityLabel.layer.masksToBounds = true
        self.popularityLabel.layer.cornerRadius = CGRectGetWidth(self.popularityLabel.frame)/2
        self.popularityLabel.layer.borderWidth = 1
        self.popularityLabel.layer.borderColor = UIColor.black.cgColor
        
        if UserDefaults.standard.integer(forKey: "font") == 15
        {
            self.vote.font = UIFont.systemFont(ofSize: 15.0)
            self.popularityLabel.font  = UIFont.systemFont(ofSize: 15.0)
            self.voteDesc.font  = UIFont.systemFont(ofSize: 15.0)
            self.popularitDesc.font =  UIFont.systemFont(ofSize: 15.0)
        }
        else if UserDefaults.standard.integer(forKey: "font") == 17 {
            self.vote.font = UIFont.systemFont(ofSize: 17.0)
            self.popularityLabel.font  = UIFont.systemFont(ofSize: 17.0)
            self.voteDesc.font  = UIFont.systemFont(ofSize: 17.0)
            self.popularitDesc.font =  UIFont.systemFont(ofSize: 17.0)
        }
        else{
            self.vote.font = UIFont.systemFont(ofSize: 19.0)
            self.popularityLabel.font  = UIFont.systemFont(ofSize: 19.0)
            self.voteDesc.font  = UIFont.systemFont(ofSize: 19.0)
            self.popularitDesc.font =  UIFont.systemFont(ofSize: 19.0)
        }
        
        
        if UserDefaults.standard.bool(forKey: "darkMode") == true
        {
            overrideUserInterfaceStyle = .dark
        }else{
            overrideUserInterfaceStyle  = .light
        }
        
      
        
        if takenVote > 0 && takenVote < 2.5
        {
            self.vote.backgroundColor = .red
        }
        else if takenVote >= 2.5 && takenVote < 7.5
        {
            self.vote.backgroundColor = .yellow
        }
        else
        {
            self.vote.backgroundColor = .green
        }
        
        
        if takenPopularity > 0 && takenPopularity < 2.5
        {
            self.popularityLabel.backgroundColor = .red
        }
        else if takenPopularity >= 2.5 && takenPopularity < 7.5
        {
            self.popularityLabel.backgroundColor = .yellow
        }
        else
        {
            self.popularityLabel.backgroundColor = .green
        }
        
    }
    
    @IBAction func addCommentClicked(_ sender: Any) {
        performSegue(withIdentifier: "toMyComment", sender: nil)
    }
    
}





extension CoreDataDetailsViewController{
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? MyCommentViewController
        {
            destinationVC.title = takenName
            destinationVC.takenName = takenName
        }
    }
    
    
}
