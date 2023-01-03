//
//  MyCommentViewController.swift
//  OMDB MVVM
//
//  Created by Arda Çimen on 30.12.2022.
//

import UIKit
import CoreData

class MyCommentViewController: UIViewController {

    
    var name = [String]()
    var comment = [String]()
    var vote = [String]()
    
    @IBOutlet weak var myCommentTextField: UITextView!
    @IBOutlet weak var yourCommentLabel: UILabel!
    @IBOutlet weak var yourVoteLabel: UILabel!
    @IBOutlet weak var yourVoteTextField: UITextField!
    
    var takenName = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        getData()
        var searcher = 0
        var indexCount = Int()
        if name.count > 0
        {
            for i in 0...name.count-1
            {
             if name[i] == takenName
             {
                 searcher = 1
                 indexCount = i
             }
            }
        }
        
        if searcher == 1
        {
            myCommentTextField.text = comment[indexCount]
            yourVoteTextField.text = vote[indexCount]
        }
        
    }
    
   
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        let floatedVoteText = Float(yourVoteTextField.text!)!
        if yourVoteTextField.text == ""
        {
            self.makeAlert(titleInput: "Vote Can't be Empty", messageInput: "Please Entry Vote")
        }else
        {
            if floatedVoteText <= 10 && floatedVoteText > 0
            {
              saveData()
            }
            else
            {
                self.makeAlert(titleInput: "Wrong Argument", messageInput: "Please re-entry between 0-10")
            }
        }
    }
    

}






extension MyCommentViewController
{
    @objc func tap(sender: UITapGestureRecognizer){
        view.endEditing(true)
    }
}

extension MyCommentViewController
{
    func configure()
    {
        let mainPageV = MainPageViewController()
       
        if mainPageV.fonts.integer(forKey: "font") == 15
        {
            self.yourVoteLabel.font = UIFont.systemFont(ofSize: 15.0)
            self.yourCommentLabel.font = UIFont.systemFont(ofSize: 15.0)
        }
        else if mainPageV.fonts.integer(forKey: "font") == 17
        {
            self.yourVoteLabel.font = UIFont.systemFont(ofSize: 17.0)
            self.yourCommentLabel.font = UIFont.systemFont(ofSize: 17.0)
        }
        else
        {
            self.yourVoteLabel.font = UIFont.systemFont(ofSize: 19.0)
            self.yourCommentLabel.font = UIFont.systemFont(ofSize: 19.0)
        }
        
        navigationController?.navigationItem.title = takenName
        if mainPageV.darkMode.bool(forKey: "darkMode") == false
        {
            overrideUserInterfaceStyle = .light
            myCommentTextField.layer.borderWidth = 1
            myCommentTextField.layer.borderColor = CGColor(red: 0, green: 0 , blue: 0, alpha: 1)
        }
        else
        {
            overrideUserInterfaceStyle = .dark
            myCommentTextField.layer.borderWidth = 1
            myCommentTextField.layer.borderColor = CGColor(red: 255, green: 255 , blue: 255, alpha: 1)
        }
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
    }
}





extension MyCommentViewController
{
    func deleteIndex()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WishList")
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                
                for result in results as! [NSManagedObject] {
                    
                    if let names = result.value(forKey: "commentName") as? String {
                            if names == takenName  {
                                context.delete(result)
                                do {
                                    try context.save()
                                } catch {
                                    print("Delete Error")
                                }
                                
                                break
                            }
                        
                      
                    }
                }
            }
        } catch {
            print("error")
        }
    }
    
    
    func getData()
    {
        self.name.removeAll(keepingCapacity: false)
        self.vote.removeAll(keepingCapacity: false)
        self.comment.removeAll(keepingCapacity: false)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WishList")
        
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    
                    if let name = result.value(forKey: "commentName") as? String {
                        self.name.append(name)
                    }
                    
                    if let comment = result.value(forKey: "commentText") as? String{
                        self.comment.append(comment)
                    }
                    
                    if let vote = result.value(forKey: "commentVote") as? String {
                        self.vote.append(vote)
                    }
                       
                }
            }
            
            
        } catch {
            print("error")
        }
    }
    
    func saveData()
    {
        deleteIndex()
        getData()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let Comment = NSEntityDescription.insertNewObject(forEntityName: "WishList", into: context)

        Comment.setValue(takenName, forKey: "commentName")
        Comment.setValue(myCommentTextField.text!, forKey: "commentText")
        Comment.setValue(yourVoteTextField.text!, forKey: "commentVote")
                do {
                    try context.save()
                    print("success")
                } catch {
                    print("error")
                }
    }
    
    func checkAndDelete(checkName : String)
    {
       getData()
        var searcher = 0
        if name.count > 0
        {
            for i in 0...name.count-1
            {
                if name[i] == checkName
                {
                    searcher = 1
                }
            }
        }
        if searcher == 1
        {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WishList")
            
            do {
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    
                    for result in results as! [NSManagedObject] {
                        
                        if let names = result.value(forKey: "commentName") as? String {
                            
                            if names == checkName {
                                context.delete(result)
                                do {
                                    try context.save()
                                } catch {
                                    print("Delete Error")
                                }
                                
                                break
                                
                            }
                        }
                    }
                }
            } catch {
                print("error")
            }
        }
        
    }
    
    
}
