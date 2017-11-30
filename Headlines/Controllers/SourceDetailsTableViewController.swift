//
//  SourceDetailsTableViewController.swift
//  Headlines
//
//  Created by Mohammad Azam on 11/19/17.
//  Copyright © 2017 Mohammad Azam. All rights reserved.
//

import Foundation
import UIKit

class SourceDetailsTableViewController : UITableViewController {
    
    var sourceViewModel :SourceViewModel!
    private var headlineListViewModel :HeadlineListViewModel!
    private var dataSource :TableViewDataSource<HeadlineTableViewCell,HeadlineViewModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    private func updateUI() {
        
        self.title = self.sourceViewModel.name 
        self.headlineListViewModel = HeadlineListViewModel(source :sourceViewModel)
        
        self.headlineListViewModel.populateHeadlines {
            
            // setup the data source here
            self.dataSource = TableViewDataSource(cellIdentifier: Cells.headline, items: self.headlineListViewModel.headlines) { cell, vm in
                
                cell.titleLabel.text = vm.title
                cell.descriptionLabel.text = vm.description
            }
            
            self.tableView.dataSource = self.dataSource
            self.tableView.reloadData()
        }
    }
}
