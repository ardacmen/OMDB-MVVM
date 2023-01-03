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
    
    var favouritesViewModel = FavouritesViewModel()
    @IBOutlet weak var tableView: UITableView!
    
    var selectedName = String()
    var selectedImage = String()
    var selectedOverwiev = String()
    var selectedVote = Float()
    var selectedPopularity = Float()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        configure()
        favouritesViewModel.removeAll()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
    }
    
    private func configure()
    {
        
        if UserDefaults.standard.bool(forKey: "darkMode") == true
        {
            overrideUserInterfaceStyle = .dark
        }else{
            overrideUserInterfaceStyle  = .light
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
            
            favouritesViewModel.deleteData(indexForDelete: indexPath.row)
            let myCommentViewController = MyCommentViewController()
            myCommentViewController.checkAndDelete(checkName: favouritesViewModel.name[indexPath.row])
            self.tableView.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedName = favouritesViewModel.name[indexPath.row]
        selectedVote = favouritesViewModel.vote[indexPath.row]
        selectedImage = favouritesViewModel.images[indexPath.row]
        selectedOverwiev = favouritesViewModel.overwiev[indexPath.row]
        selectedPopularity = favouritesViewModel.popularity[indexPath.row]
        performSegue(withIdentifier: "toCoreDataDetails", sender: nil)
    }
    
}



extension FavouritesViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouritesViewModel.name.count
   
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.name.text = favouritesViewModel.name[indexPath.row]
       cell.imageV.kf.setImage(with: URL(string: favouritesViewModel.images[indexPath.row]))
        return cell
       
    }
    
}

extension FavouritesViewController
{
    func getData(){
        favouritesViewModel.getData(completion: { isFetched in
            DispatchQueue.main.async {  [self] in
                self.tableView.reloadData()
            }
        })
    }
}
