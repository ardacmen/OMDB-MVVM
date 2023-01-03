//
//  ProfileV.swift
//  OMDB MVVM
//
//  Created by Arda Çimen on 15.12.2022.
//

import UIKit
import CoreData
import Kingfisher

class FavouritesViewController: UIViewController {
    
    var profileViewModel = FavouritesViewModel()
    
    var selectedName = String()
    var name = [String]()
    
    var comment = [String]()
    
    var selectedImage = String()
    var images = [String]()
    
    var selectedOverwiev = String()
    var overwiev = [String]()
    
    var selectedVote = Float()
    var vote = [Float]()
    
    var selectedPopularity = Float()
    var popularity = [Float]()
    
    @IBOutlet weak var tableView: UITableView!
   
    /*
     @IBAction func languageClicked(_ sender: Any) {
        let menu = profileViewModel.languageSelector()
        present(menu, animated: true, completion: nil)
     }
     */
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let mainPageV = MainPageViewController()
        if mainPageV.darkMode.bool(forKey: "darkMode") == false
        {
            overrideUserInterfaceStyle = .light
        }
   
        self.images.removeAll(keepingCapacity: false)
        self.name.removeAll(keepingCapacity: false)
        self.overwiev.removeAll(keepingCapacity: false)
        self.vote.removeAll(keepingCapacity: false)
        self.popularity.removeAll(keepingCapacity: false)
        self.comment.removeAll(keepingCapacity: false)
        
        getData()
        
      
 
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
    }
    private  func deleteAllData(_ entity:String) {
        
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false

        do {
            let arrUsrObj = try managedContext.fetch(fetchRequest)
            for usrObj in arrUsrObj as! [NSManagedObject] {
                managedContext.delete(usrObj)
            }
           try managedContext.save() //don't forget
            } catch let error as NSError {
            print("delete fail--",error)
          }
        

        }
    
}


extension FavouritesViewController
{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? CoreDataDetailsViewController
        {
            destinationVC.title = selectedName
            destinationVC.takenName = selectedName
            destinationVC.takenVote = selectedVote
            destinationVC.takenImage = selectedImage
            destinationVC.takenOverwiev = selectedOverwiev
            destinationVC.takenPopularity = selectedPopularity
        }
    }
}


extension FavouritesViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            profileViewModel.deleteData(nameForDelete: name[indexPath.row])
            let myCommentViewController = MyCommentViewController()
            myCommentViewController.checkAndDelete(checkName: name[indexPath.row])
            name.remove(at: indexPath.row)
            images.remove(at: indexPath.row)
            overwiev.remove(at: indexPath.row)
            vote.remove(at: indexPath.row)
            popularity.remove(at: indexPath.row )
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedName = name[indexPath.row]
        selectedVote = vote[indexPath.row]
        selectedImage = images[indexPath.row]
        selectedOverwiev = overwiev[indexPath.row]
        selectedPopularity = popularity[indexPath.row]
    
        performSegue(withIdentifier: "toCoreDataDetails", sender: nil)
        
    }
    
}



extension FavouritesViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.name.text = name[indexPath.row]
        cell.imageV.kf.setImage(with: URL(string: images[indexPath.row]))
        return cell
    }
    
    
    
    
}

extension FavouritesViewController
{
    func getDataForCheckArray(){
        
        
        
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
                    
                    if let images = result.value(forKey: "image") as? String {
                        self.images.append(images)
                    }
                    
                    if let vote = result.value(forKey: "vote") as? Float {
                        self.vote.append(vote)
                    }
                    
                    if let overwiev = result.value(forKey: "overwiev") as? String {
                        self.overwiev.append(overwiev)
                    }
                    
                  
                    
                    if let popularity = result.value(forKey: "popularity") as? Float {
                        self.popularity.append(popularity)
                    }
                }
            }
        } catch {
            print("error")
        }
    }
    
    func getData(){
        
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
                    
                    if let images = result.value(forKey: "image") as? String {
                        self.images.append(images)
                    }
                    
                    if let vote = result.value(forKey: "vote") as? Float {
                        self.vote.append(vote)
                      
                    }
                    
                    if let overwiev = result.value(forKey: "overwiev") as? String {
                        self.overwiev.append(overwiev)
                    }
                    
                    if let popularity = result.value(forKey: "popularity") as? Float {
                        self.popularity.append(popularity)
                    }
                    
                    if let comment = result.value(forKey: "commentName") as? String{
                        self.comment.append(comment)
                    }
                    
                    
                    
                    self.tableView.reloadData()
                    
                }
            }
            
            
        } catch {
            print("error")
        }
        
    }
    
   
    
}
