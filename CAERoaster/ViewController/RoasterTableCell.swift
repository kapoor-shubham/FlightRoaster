//
//  RoasterTableCell.swift
//  CAERoaster
//
//  Created by Shubham Kapoor on 06/10/21.
//

import UIKit

class RoasterTableCell: UITableViewCell {
    
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblHeaderDescription: UILabel!
    @IBOutlet weak var lblMatchCrew: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func prepareForReuse() {
        self.imgIcon.image = nil
        self.lblHeader.text = nil
        self.lblTime.text = nil
        self.lblHeaderDescription.text = nil
        self.lblMatchCrew.text = nil
    }
    
    func configureCell(cellData: Roaster?) {
        imgIcon.image = UIImage(named: (cellData?.dutyCode?.lowercased() ?? DutyCode.flight.rawValue.lowercased())) ?? UIImage(named: (DutyCode.flight.rawValue).lowercased())
        lblMatchCrew.text = cellData?.dutyCode?.lowercased() == DutyCode.standby.rawValue.lowercased() ? Constants.matchCrew : ""
  
        switch cellData?.dutyCode?.lowercased() {
        case DutyCode.flight.rawValue.lowercased():
            lblTime.text = "\(cellData?.timeArrive ?? "") - \(cellData?.timeDepart ?? "")"
            lblHeader.text = "\(cellData?.departure ?? "") - \(cellData?.destination ?? "")"
            lblHeaderDescription.text = ""
        case DutyCode.layover.rawValue.lowercased():
            lblTime.text = "\(cellData?.timeDepart ?? "") hours"
            lblHeader.text = cellData?.dutyCode ?? ""
            lblHeaderDescription.text = cellData?.dutyID ?? ""
        case DutyCode.off.rawValue.lowercased():
            lblHeader.text = cellData?.dutyCode ?? ""
            lblHeaderDescription.text = cellData?.dutyID ?? ""
        case DutyCode.positioning.rawValue.lowercased():
            lblTime.text = "\(cellData?.timeArrive ?? "") - \(cellData?.timeDepart ?? "")"
            lblHeader.text = cellData?.dutyCode ?? ""
            lblHeaderDescription.text = cellData?.dutyID ?? ""
        case DutyCode.standby.rawValue.lowercased():
            lblTime.text = "\(cellData?.timeArrive ?? "") - \(cellData?.timeDepart ?? "")"
            lblHeader.text = cellData?.dutyCode ?? ""
            lblHeaderDescription.text = cellData?.dutyID ?? ""
        default:
            lblTime.text = "\(cellData?.timeArrive ?? "") - \(cellData?.timeDepart ?? "")"
            lblHeader.text = cellData?.dutyCode ?? ""
            lblHeaderDescription.text = cellData?.dutyID ?? ""
        }
    }
}
