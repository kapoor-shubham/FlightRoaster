//
//  RoasterViewController.swift
//  CAERoaster
//
//  Created by Shubham Kapoor on 04/10/21.
//

import UIKit

class RoasterViewController: UIViewController {
    
    lazy var viewModel = RoasterViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVMCallbacks()
        viewModel.getRoasterData()
    }
    
    func setupVMCallbacks() {
        viewModel.fetchData = { (success) in
            self.viewModel.getRoasterDataFromDB()
        }
    }
}
