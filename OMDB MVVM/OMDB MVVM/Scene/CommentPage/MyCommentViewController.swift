//
//  MyCommentViewController.swift
//  OMDB MVVM
//
//  Created by Arda Çimen on 30.12.2022.
//

import UIKit
import CoreData

class MyCommentViewController: UIViewController {

    let myCommentViewModel = MyCommentViewModel()
   
    
    @IBOutlet weak var myCommentTextField: UITextView!
    @IBOutlet weak var yourCommentLabel: UILabel!
    @IBOutlet weak var yourVoteLabel: UILabel!
    @IBOutlet weak var yourVoteTextField: UITextField!
    var takenName = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        myCommentViewModel.getData()
       
        let searcher =  myCommentViewModel.checkdataIsAdd(takenName: self.takenName)
        if searcher
        {
            myCommentTextField.text = myCommentViewModel.comment[myCommentViewModel.indexCountForCheckWhenDidLoad]
            yourVoteTextField.text = myCommentViewModel.vote[myCommentViewModel.indexCountForCheckWhenDidLoad]
        }
        
    }
    
   
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        let errorOrSuccess = myCommentViewModel.validateVote(takenName: self.takenName, myCommentTextField: myCommentTextField.text!, yourVoteTextField: yourVoteTextField.text!)
        if errorOrSuccess == false
        {
            self.makeAlert(titleInput: "Error!", messageInput: "Range Error!")
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
        yourVoteTextField.keyboardType = .decimalPad
        navigationController?.navigationItem.title = takenName
        if UserDefaults.standard.bool(forKey: "darkMode") == false
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
        
        myCommentTextField.font =   UIFont(name: myCommentTextField.font!.fontName, size: CGFloat(myCommentViewModel.fontSizeReturner()))
        yourCommentLabel.font =  UIFont(name: yourCommentLabel.font!.fontName, size: CGFloat(myCommentViewModel.fontSizeReturner()))
        yourVoteLabel.font =  UIFont(name: yourVoteLabel.font!.fontName, size: CGFloat(myCommentViewModel.fontSizeReturner()))
        yourVoteTextField.font =  UIFont(name: yourVoteTextField.font!.fontName, size: CGFloat(myCommentViewModel.fontSizeReturner()))
        
        
    }
}



