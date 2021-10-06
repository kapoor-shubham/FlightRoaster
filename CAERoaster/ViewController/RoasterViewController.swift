//
//  RoasterViewController.swift
//  CAERoaster
//
//  Created by Shubham Kapoor on 04/10/21.
//

import UIKit

class RoasterViewController: UIViewController {
    
    @IBOutlet weak var tableRoaster: UITableView!
    
    lazy var viewModel = RoasterViewModel()
    var roasterModel = [Date: [Roaster]]()
    var roasterDateArray = [Date]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVMCallbacks()
        viewModel.getRoasterData()
    }
    
    func setupVMCallbacks() {
        viewModel.dataFetchReady = { (success) in
            self.viewModel.getRoasterDataFromDB()
        }
        
        viewModel.roasterDBResponse = { (model, dateArray) in
            DispatchQueue.main.async {
                self.roasterModel = model
                self.roasterDateArray = dateArray
                self.tableRoaster.reloadData()
            }
        }
    }
}
