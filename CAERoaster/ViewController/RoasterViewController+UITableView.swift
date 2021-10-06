//
//  RoasterViewController+UITableView.swift
//  CAERoaster
//
//  Created by Shubham Kapoor on 06/10/21.
//

import UIKit

extension RoasterViewController: UITableViewDataSource, DateFormatable {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.roasterModel.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.roasterModel[roasterDateArray[section]]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let roasterCell = tableView.dequeueReusableCell(withIdentifier: "RoasterTableCell") as! RoasterTableCell
        roasterCell.configureCell(cellData: roasterModel[roasterDateArray[indexPath.section]]?[indexPath.row])
        return roasterCell
    }
}

extension RoasterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
        let label = UILabel(frame: CGRect(x: 10, y: 0, width: tableView.frame.size.width, height: 40))
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.text = self.convertDateToString(date: roasterDateArray[section], dateFormat: .ddMMMyyyy)
        view.addSubview(label)
        view.backgroundColor = UIColor.lightGray

        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
