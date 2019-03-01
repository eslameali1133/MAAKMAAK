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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var btnReject: UIButton!
    func set(_ req:request)  {
        self.lblName.text = req.name
        self.lblBrand.text = req.brand
        self.lblServiceType.text = req.service
        self.lblTime.text = req.time
        
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
