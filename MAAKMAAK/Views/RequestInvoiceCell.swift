//
//  RequestInvoiceCell.swift
//  MAAKMAAK
//
//  Created by apple on 2/20/19.
//  Copyright © 2019 Eslammaakmaak. All rights reserved.
//

import UIKit

class RequestInvoiceCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblBrand: UILabel!
    @IBOutlet weak var lblServiceType: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    func set(req:RequestServices)  {
//        self.lblName.text = req.name
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
