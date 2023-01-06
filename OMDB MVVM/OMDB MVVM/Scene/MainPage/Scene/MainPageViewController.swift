//
//  MainPageV.swift
//  OMDB MVVM
//
//  Created by Arda Çimen on 11.12.2022.
//

import UIKit
import Kingfisher
import CoreData

class MainPageViewController: UIViewController{
    
      var filter = 0
      @IBOutlet weak var segmentedCotrols: UISegmentedControl!
      var selectedName = ""
      let fonts = UserDefaults.standard
      let darkMode = UserDefaults.standard
      let mainPageViewModel = MainPageViewModel()
      @IBOutlet weak var collectionView: UICollectionView!
      let searchController = UISearchController(searchResultsController: nil)
    
    
      override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
        configureView()
        collectionView.delegate = self
        collectionView.dataSource = self
        
          
          mainPageViewModel.getMoviesData(completion: { isFetched in
              DispatchQueue.main.async {  [self] in
                  self.collectionView.reloadData()
              }
          })
      
        segmentedCotrols.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
      }
    
    override func viewWillAppear(_ animated: Bool) {
        configureView()
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
     
       
        
        if sender.selectedSegmentIndex == 0
        {
            filter = 2
            self.collectionView.reloadData()
        }else if sender.selectedSegmentIndex == 1
        {
            filter = 1
            self.collectionView.reloadData()
        }else if sender.selectedSegmentIndex == 2
        {
            filter = 4
            self.collectionView.reloadData()
        }else
        {
            filter = 3
            self.collectionView.reloadData()
        }
    }

   
    private func configureView(){
    
        if UserDefaults.standard.bool(forKey: "darkMode") == true
        {
            overrideUserInterfaceStyle = .dark
            navigationItem.rightBarButtonItem?.tintColor = .white
            navigationItem.leftBarButtonItem?.tintColor = .white
        }else{
            overrideUserInterfaceStyle = .light
            navigationItem.rightBarButtonItem?.tintColor = .black
            navigationItem.leftBarButtonItem?.tintColor = .black
        }
    }
    
    private func configureSearchBar()
    {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController
        definesPresentationContext = true
        let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField
        textfield!.backgroundColor = UIColor.white
        textfield!.attributedPlaceholder = NSAttributedString(string: textfield!.placeholder ?? "Search", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        textfield!.textColor = UIColor.black
        let leftView = textfield!.leftView as? UIImageView
        leftView!.image = leftView!.image?.withRenderingMode(.alwaysTemplate)
        leftView!.tintColor = UIColor.black
            
        
       
    }
    
}



extension MainPageViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? DetailViewController
        {
            destinationVC.title = selectedName
            destinationVC.TakenName = selectedName
        }
    }
}


extension MainPageViewController : UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedName = mainPageViewModel.selectedNameChooser(indexForName: indexPath.row)
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
}

extension MainPageViewController : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainPageViewModel.arrayCount()
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        if mainPageViewModel.isSearching == false{
         
            switch  filter {
          
            case 1: // if filter == 1 it means voteLH
                mainPageViewModel.voteLH()
                cell.name.text =  mainPageViewModel.result[indexPath.row].title
                cell.imageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w1280" +  mainPageViewModel.result[indexPath.row].poster_path! ))
               
            case 2:
                mainPageViewModel.voteHL()
                cell.name.text =  mainPageViewModel.result[indexPath.row].title
                cell.imageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w1280" +  mainPageViewModel.result[indexPath.row].poster_path! ))
                
            case 3:
                mainPageViewModel.voteLH()
                cell.name.text =  mainPageViewModel.result[indexPath.row].title
                cell.imageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w1280" +  mainPageViewModel.result[indexPath.row].poster_path! ))
            case 4:
                mainPageViewModel.popularityHL()
                cell.name.text =  mainPageViewModel.result[indexPath.row].title
                cell.imageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w1280" +  mainPageViewModel.result[indexPath.row].poster_path! ))
            default:
                cell.name.text =  mainPageViewModel.result[indexPath.row].title
                cell.imageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w1280" +  mainPageViewModel.result[indexPath.row].poster_path!))
            }
            
        
        }else{
   
            cell.name.text =  mainPageViewModel.resultAfterSearch[indexPath.row].title
            cell.imageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w1280" +  mainPageViewModel.resultAfterSearch[indexPath.row].poster_path! ))
        
        }
        cell.imageView.layer.cornerRadius = 20
        return cell
        
    }
    
    
    
}

extension MainPageViewController: UISearchResultsUpdating
{
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text!
        mainPageViewModel.updateSearchResult(text: text)
        collectionView.reloadData()
    }
}

extension MainPageViewController : UISearchBarDelegate
{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        mainPageViewModel.searchBarCancelButtonClicked()
        collectionView.reloadData()
    }
}

