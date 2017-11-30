//
//  SourcesTableViewController.swift
//  Headlines
//
//  Created by Mohammad Azam on 11/19/17.
//  Copyright © 2017 Mohammad Azam. All rights reserved.
//

import Foundation
import UIKit

class SourcesTableViewController : UITableViewController {
    
    
    private var webservice :Webservice!
    private var sourceListViewModel :SourceListViewModel!
    private var dataSource :TableViewDataSource<SourceTableViewCell,SourceViewModel>! 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func updateUI() {
        
        self.webservice = Webservice()
        self.sourceListViewModel = SourceListViewModel(webservice: self.webservice)
        
        // setting up the bindings
        self.sourceListViewModel.bindToSourceViewModels = {
            self.updateDataSource()
        }
       
    }
    
    private func updateDataSource() {
        
        self.dataSource = TableViewDataSource(cellIdentifier: Cells.source, items: self.sourceListViewModel.sourceViewModels) { cell, vm in
            
            cell.nameLabel.text = vm.name
            cell.descriptionLabel.text = vm.body
        }
        
        self.tableView.dataSource = self.dataSource
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == SegueIdentifier.showSourceDetails {
            performSegueForShowSourceDetails(segue: segue)
            
        } else if segue.identifier == SegueIdentifier.addSource {
            performSegueForAddSource(segue: segue)
        }
    }
    
    private func performSegueForAddSource(segue: UIStoryboardSegue) {
        
        guard let addSourceNC = segue.destination as? UINavigationController,
              let addSourceTVC = addSourceNC.childViewControllers.first as? AddSourceTableViewController else {
            fatalError("Segue destination not found")
        }
        
        addSourceTVC.addSourceClosure = { [unowned self] sourceVM, controller in
            
            controller.dismiss(animated: true, completion: nil)
            self.sourceListViewModel.addSource(source: sourceVM)
            print("Updated to \(self.sourceListViewModel.sourceViewModels.count)")
        }
    }
    
    private func performSegueForShowSourceDetails(segue :UIStoryboardSegue) {
        
        guard let indexPath = self.tableView.indexPathForSelectedRow else {
            fatalError("indexPath not found")
        }
        
        let sourceViewModel = self.sourceListViewModel.source(at: indexPath.row)
        let sourceDetailsTVC = segue.destination as! SourceDetailsTableViewController
        sourceDetailsTVC.sourceViewModel = sourceViewModel
    }
}
