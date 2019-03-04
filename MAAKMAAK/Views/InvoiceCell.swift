//
//  InvoiceCell.swift
//  MAAKMAAK
//
//  Created by apple on 2/21/19.
//  Copyright © 2019 Eslammaakmaak. All rights reserved.
//

import UIKit

class InvoiceCell: UITableViewCell {

    
    
    @IBOutlet weak var lblServiceName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnRemove: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func removeService(_ sender: UIButton) {
    }
    func setData(item:OrederDetails) {
        self.lblPrice.text = "\(item.price ?? 0)"
        self.lblServiceName.text = item.serviceNameEN
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
