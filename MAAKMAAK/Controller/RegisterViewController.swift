//
//  RegisterViewController.swift
//  MaakMaakAPP
//
//  Created by M on 2/10/19.
//  Copyright © 2019 maakmaak. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    var CarOwnerFalg = true
    
    @IBOutlet weak var RidoBtnCar: UIButton!
      @IBOutlet weak var RidoBtnProvider: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func ServieProviderSelecd(_ sender: Any) {
        CarOwnerFalg = false
        RidoBtnProvider.setImage(UIImage(named: "radio-on-buttonActive"), for: .normal)
          RidoBtnCar.setImage(UIImage(named: "radio-on-buttonmotActive"), for: .normal)
    }
   
    @IBAction func CarOwnerSelect(_ sender: Any) {
        CarOwnerFalg = true
        
        RidoBtnProvider.setImage(UIImage(named: "radio-on-buttonmotActive"), for: .normal)
        RidoBtnCar.setImage(UIImage(named: "radio-on-buttonActive"), for: .normal)
    }

}
