//
//  RequestCell.swift
//  MAAKMAAK
//
//  Created by M on 2/15/19.
//  Copyright © 2019 Eslammaakmaak. All rights reserved.
//

import UIKit

class RequestCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblBrand: UILabel!
    @IBOutlet weak var lblServiceType: UILabel!
    
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var btnAccept: UIButton!
    @IBOutlet weak var btnShow: UIButton!
    
    var selectTapped: ((RequestCell) -> Void)?
    @IBAction func btnSelect(_ sender: UIButton) {
        selectTapped?(self)
    }
    var rejectTapped: ((RequestCell) -> Void)?
    @IBAction func btnReject(_ sender: UIButton) {
        rejectTapped?(self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var btnReject: UIButton!
    func set(req:RequestServices)  {
        self.lblName.text = req.customerName
        self.lblBrand.text = req.carBrandEN
        self.lblServiceType.text = req.serviceNameEN
        self.lblTime.text = req.creationDate
    }
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
