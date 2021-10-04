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
        viewModel.getRoasterData()
    }
}
