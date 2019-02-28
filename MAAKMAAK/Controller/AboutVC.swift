//
//  AboutVC.swift
//  MAAKMAAK
//
//  Created by apple on 2/21/19.
//  Copyright © 2019 Eslammaakmaak. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func openfacebook(_ sender: Any) {
        guard let url = URL(string: "https://www.facebook.com/maakservice") else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func openyoutube(_ sender: Any) {
        guard let url = URL(string: "https://www.youtube.com/channel/UCv5k037zWmJGxywb2YIJRgw") else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func openmail(_ sender: Any) {
        guard let url = URL(string:"https://www.maakmaak.com") else {
            return
            
        }
        UIApplication.shared.open(url)
    }
}
