//
//  AddSourceTableViewController.swift
//  Headlines
//
//  Created by Mohammad Azam on 11/22/17.
//  Copyright © 2017 Mohammad Azam. All rights reserved.
//

import Foundation
import UIKit

class AddSourceTableViewController : UITableViewController {
    
    private var addSourceViewModel :AddSourceViewModel!
    
    @IBOutlet weak var titleTextField :UITextField!
    @IBOutlet weak var descriptionTextView :BindingTextView!
    @IBOutlet weak var remainingCharactersCountLabel :UILabel!
    
    var addSourceClosure :(SourceViewModel,UIViewController) -> () = { _,_ in }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addSourceViewModel = AddSourceViewModel()

        self.descriptionTextView.bind { count,limit in
         
            self.remainingCharactersCountLabel.text = "\(self.addSourceViewModel.remainingNumberOfAllowedCharacters(numberOfCharactersEntered: count, limit:limit))"
        }.limit(to: Maximum.allowedCharactersForDescription)
    }
    
    @IBAction func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save() {
        
        let sourceViewModel = SourceViewModel(name: self.titleTextField.text!, description: self.descriptionTextView.text)
        
     //   DispatchQueue.main.async {
            self.addSourceClosure(sourceViewModel,self)
     //   }
    }
    
}
