//
//  ProfileV.swift
//  OMDB MVVM
//
//  Created by Arda Çimen on 15.12.2022.
//

import UIKit
import CoreData
import Kingfisher

class ProfileV: UIViewController {
    
    var profileViewModel = ProfileViewModel()
    
    var images = [String]()
    var name = [String]()
    var overwiev = [String]()
    var vote = [Float]()
    var popularity = [Float]()
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func languageClicked(_ sender: Any) {
        let menu = profileViewModel.languageSelector()
        present(menu, animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.images.removeAll(keepingCapacity: false)
        self.name.removeAll(keepingCapacity: false)
        self.overwiev.removeAll(keepingCapacity: false)
        self.vote.removeAll(keepingCapacity: false)
        self.popularity.removeAll(keepingCapacity: false)
        getData()
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
    }
    
    
    
    
    
}



extension ProfileV : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == .delete {
               
               let appDelegate = UIApplication.shared.delegate as! AppDelegate
               let context = appDelegate.persistentContainer.viewContext
               
               let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WishList")
               
          
               
               do {
               let results = try context.fetch(fetchRequest)
                   if results.count > 0 {
                       
                       for result in results as! [NSManagedObject] {
                           
                           if let names = result.value(forKey: "name") as? String {
                               
                               if names == name[indexPath.row] {
                                   context.delete(result)
                                   name.remove(at: indexPath.row)
                                   images.remove(at: indexPath.row)
                                   overwiev.remove(at: indexPath.row)
                                   vote.remove(at: indexPath.row)
                                   popularity.remove(at: indexPath.row )
    
                                   self.tableView.reloadData()
                                   
                                   do {
                                       try context.save()
                                       
                                   } catch {
                                       print("error")
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

extension ProfileV : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*
         self.name = Array(Set(self.name))
         self.images = Array(Set(self.images))
         self.popularity = Array(Set(self.popularity))
         self.vote = Array(Set(self.vote))
         self.overwiev = Array(Set(self.overwiev))
         */
           
            return name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.name.text = name[indexPath.row]
        cell.imageV.kf.setImage(with: URL(string: images[indexPath.row]))
        return cell
    }
    
    
    
    
}
extension ProfileV
{
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
                    
                    
                    self.tableView.reloadData()
                    
                }
            }
            
            
        } catch {
            print("error")
        }
        
    }

}
extension ProfileV
{
    func getData2(){
    
     
        
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

}
