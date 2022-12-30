//
//  MainPageV.swift
//  OMDB MVVM
//
//  Created by Arda Çimen on 11.12.2022.
//

import UIKit
import Kingfisher
import CoreData

class MainPageV: UIViewController{
    
    
      @IBOutlet weak var segmentedCotrols: UISegmentedControl!
      var selectedName = ""
      let userFilter = UserDefaults.standard
      var isSearching = false
      let mainPageViewModel = MainPageViewModel()
      let service = WebService()
      var result = [Result]()
      var resultAfterSearch = [Result]()
    
    
      @IBOutlet weak var collectionView: UICollectionView!
      let searchController = UISearchController(searchResultsController: nil)
    
    
     func deleteAllData(_ entity:String) {
        
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  deleteAllData("WishList")
       
        userFilter.set(0, forKey: "filter")
        configureSearchBar()
        configureView()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        service.getCharacters(completion: {  data in
              DispatchQueue.main.async {  [self] in
                  print(data!)
                  self.result = data!
                  self.collectionView.reloadData()
              }
          })
        segmentedCotrols.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
      }
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
     
       
        
        if sender.selectedSegmentIndex == 0
        {
            userFilter.set(2, forKey: "filter")
            self.makeAlert(titleInput: "Selected!", messageInput: "Vote -> Highest to Lowest")
            self.collectionView.reloadData()
        }else if sender.selectedSegmentIndex == 1
        {
            userFilter.set(1, forKey: "filter")
            self.makeAlert(titleInput: "Selected!", messageInput: "Vote -> Lowest to Highest")
            self.collectionView.reloadData()
        }else if sender.selectedSegmentIndex == 2
        {
            userFilter.set(4, forKey: "filter")
            self.makeAlert(titleInput: "Selected!", messageInput: "popularity -> Highest to Lowest")
            self.collectionView.reloadData()
        }else
        {
            userFilter.set(3, forKey: "filter")
            self.makeAlert(titleInput: "Selected!", messageInput: "popularity -> Lowest to Highest")
            self.collectionView.reloadData()
            
     
        }
        
        
    }

   
    private func configureView(){
        self.navigationItem.rightBarButtonItem?.tintColor = .black
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        if #available(iOS 14.0, *) {
              overrideUserInterfaceStyle = .light
          }
        
    }
    
    private func configureSearchBar()
    {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController
        definesPresentationContext = true
      
                    // TEXT FİELD VİEW
        
        if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {

            textfield.backgroundColor = UIColor.white
            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "Search", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])

            textfield.textColor = UIColor.black

            if let leftView = textfield.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = UIColor.black
            }
        }
       
    }
    
}



extension MainPageV{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? DetailV
        {
            destinationVC.title = selectedName
            destinationVC.TakenName = selectedName
        }
    }
}


extension MainPageV : UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isSearching == false
        {
            
            selectedName = result[indexPath.row].title!
        }
        else
        {
            selectedName = resultAfterSearch[indexPath.row].title!
        }
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
}

extension MainPageV : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearching == false
        {
            return result.count
        }
        else
        {
            return resultAfterSearch.count
        }
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        if isSearching == false{
            let x:Int! = userFilter.value(forKey: "filter")! as? Int
            switch  x {
            case 0: // if fiter == 0 it means none
                
                cell.name.text = result[indexPath.row].title
              
               cell.imageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w1280" + result[indexPath.row].poster_path!))
                
               
            case 1: // if filter == 1 it means voteLH
              
              
                var n = result.count
                   while (n > 0) {
                       var lastModifiedIndex = 0
                       for currentIndex in 1..<n {
                           if result[currentIndex - 1].vote_average! > result[currentIndex].vote_average! {
                               let temp = result[currentIndex - 1]
                               result[currentIndex - 1] = result[currentIndex]
                               result[currentIndex] = temp
                               lastModifiedIndex = currentIndex
                           }
                       }
                       n = lastModifiedIndex
                   }
                cell.name.text = result[indexPath.row].title
                cell.imageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w1280" + result[indexPath.row].poster_path! ))
               
            case 2:
                
                
                var n = result.count
                   while (n > 0) {
                       var lastModifiedIndex = 0
                       for currentIndex in 1..<n {
                           if result[currentIndex - 1].vote_average! < result[currentIndex].vote_average! {
                               let temp = result[currentIndex - 1]
                               result[currentIndex - 1] = result[currentIndex]
                               result[currentIndex] = temp
                               lastModifiedIndex = currentIndex
                           }
                       }
                       n = lastModifiedIndex
                   }
                cell.name.text = result[indexPath.row].title
                cell.imageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w1280" + result[indexPath.row].poster_path! ))
                
                
            case 3:
                
                
                var n = result.count
                   while (n > 0) {
                       var lastModifiedIndex = 0
                       for currentIndex in 1..<n {
                           if result[currentIndex - 1].popularity! > result[currentIndex].popularity! {
                               let temp = result[currentIndex - 1]
                               result[currentIndex - 1] = result[currentIndex]
                               result[currentIndex] = temp
                               lastModifiedIndex = currentIndex
                           }
                       }

                       n = lastModifiedIndex
                   }
                cell.name.text = result[indexPath.row].title
                cell.imageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w1280" + result[indexPath.row].poster_path! ))
                
                
            case 4:
                
                
                var n = result.count
                   while (n > 0) {
                       var lastModifiedIndex = 0
                       for currentIndex in 1..<n {
                           if result[currentIndex - 1].popularity! < result[currentIndex].popularity! {
                               let temp = result[currentIndex - 1]
                               result[currentIndex - 1] = result[currentIndex]
                               result[currentIndex] = temp
                               lastModifiedIndex = currentIndex
                           }
                       }
                       n = lastModifiedIndex
                   }
                cell.name.text = result[indexPath.row].title
                cell.imageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w1280" + result[indexPath.row].poster_path! ))
                
                
            default:
                break
            }
            
        
        }else{
   
            cell.name.text = resultAfterSearch[indexPath.row].title
            cell.imageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w1280" + resultAfterSearch[indexPath.row].poster_path! ))
        
        }
        cell.imageView.layer.cornerRadius = 20
        return cell
        
    }
    
    
    
}

extension MainPageV: UISearchResultsUpdating
{
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text!
        if !text.isEmpty
        {
            isSearching = true
            resultAfterSearch.removeAll(keepingCapacity: false)
            for movie in result
            {
                if movie.title!.lowercased().contains(text.lowercased())
                {
                    resultAfterSearch.append(movie)
                }
            }
            
        }else
        {
            isSearching = false
            resultAfterSearch.removeAll(keepingCapacity: false)
            resultAfterSearch = result
        }
        collectionView.reloadData()
    }
}

extension MainPageV : UISearchBarDelegate
{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        resultAfterSearch.removeAll(keepingCapacity: false)
        collectionView.reloadData()
    }
}

