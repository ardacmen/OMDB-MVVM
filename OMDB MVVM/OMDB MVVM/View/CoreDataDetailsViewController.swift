//
//  CoreDataDetailsViewController.swift
//  OMDB MVVM
//
//  Created by Arda Çimen on 24.12.2022.
//

import UIKit
import Kingfisher

class CoreDataDetailsViewController: UIViewController {

    
    
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
        configureLabel()
    }

}

extension CoreDataDetailsViewController
{
    func configure(){
        self.overWiev.text = self.takenOverwiev
        self.popularitDesc.text = "Popluarity in Users "
        self.voteDesc.text = "Users Vote for Film "
        self.vote.text = String(self.takenVote)
        self.popularityLabel.text = String(format: "%.1f", self.takenPopularity)
        self.imageView.kf.setImage(with: URL(string: takenImage ))
    }
}


extension CoreDataDetailsViewController
{
    private func configureLabel()
    {
     
        self.vote.layer.masksToBounds = true
        self.vote.layer.cornerRadius = CGRectGetWidth(self.vote.frame)/2
        self.vote.layer.borderWidth = 1
        self.vote.layer.borderColor = UIColor.black.cgColor
     
       
        self.popularityLabel.layer.masksToBounds = true
        self.popularityLabel.layer.cornerRadius = CGRectGetWidth(self.popularityLabel.frame)/2
        self.popularityLabel.layer.borderWidth = 1
        self.popularityLabel.layer.borderColor = UIColor.black.cgColor
        
        if Float(self.vote.text!)! > 0 && Float(self.vote.text!)! < 2.5
        {
            self.vote.backgroundColor = .red
        }
        else if Float(self.vote.text!)! >= 2.5 && Float(self.vote.text!)! < 7.5
        {
            self.vote.backgroundColor = .yellow
        }
        else
        {
            self.vote.backgroundColor = .green
        }
        
        
        if Float(self.popularityLabel.text!)! > 0 && Float(self.popularityLabel.text!)! < 2.5
        {
            self.popularityLabel.backgroundColor = .red
        }
        else if Float(self.popularityLabel.text!)! >= 2.5 && Float(self.popularityLabel.text!)! < 7.5
        {
            self.popularityLabel.backgroundColor = .yellow
        }
        else
        {
            self.popularityLabel.backgroundColor = .green
        }
    }
}

