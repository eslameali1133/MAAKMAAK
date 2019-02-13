//
//  HomeVendrVC.swift
//  MaakMaak
//
//  Created by apple on 2/8/19.
//  Copyright © 2019 M. All rights reserved.
//

import UIKit

class HomeVendrVC: MYViewController {
    
    
    
    @IBOutlet weak var viewho: UIView!
    @IBOutlet weak var ProfileSV: UIStackView!
    @IBOutlet weak var SrviceSV: UIStackView!
    @IBOutlet weak var requessSV: UIStackView!
    @IBOutlet weak var invoiceV: UIStackView!
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.viewho.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/4))
        self.SrviceSV.transform = CGAffineTransform(rotationAngle: -(CGFloat(Double.pi/4)))
        self.ProfileSV.transform = CGAffineTransform(rotationAngle: -(CGFloat(Double.pi/4)))
        self.invoiceV.transform = CGAffineTransform(rotationAngle: -(CGFloat(Double.pi/4)))
        self.requessSV.transform = CGAffineTransform(rotationAngle: -(CGFloat(Double.pi/4)))
    }
    
    
    @IBAction func GoProfile(_ sender: Any) {
    }
    
    @IBAction func GoRequest(_ sender: Any) {
    }
    
    @IBAction func GoInvioce(_ sender: Any) {
    }
    
    @IBAction func GoService(_ sender: Any) {
    }
}
