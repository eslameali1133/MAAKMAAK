//
//  MYViewController.swift
//  MaakMaak
//
//  Created by apple on 2/8/19.
//  Copyright © 2019 M. All rights reserved.
//

import UIKit
import Localize_Swift


// constants
let APPLE_LANGUAGE_KEY = "AppleLanguages"
/// L102Language
class L102Language {
    /// get current Apple language
    class func currentAppleLanguage() -> String{
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
        let current = langArray.firstObject as! String
        return current
    }
    /// set @lang to be the first in Applelanguages list
    class func setAppleLAnguageTo(lang: String) {
        let userdef = UserDefaults.standard
        userdef.set([lang,currentAppleLanguage()], forKey: APPLE_LANGUAGE_KEY)
        userdef.synchronize()
    }
}

class MYViewController: UIViewController {

     var menuBarButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 15))
       // image.contentMode = .scaleAspectFit
        //image.image = UIImage(named: "Logo3_2")
        
//        let logo =
//        let imageView = UIImageView(image:image)
        //self.navigationItem.titleView = image
        
        
        UIView.appearance().semanticContentAttribute = SharedData.SharedInstans.getLanguage() == "en" ? .forceLeftToRight : .forceRightToLeft
        
        
        navigationController?.navigationBar.barTintColor = UIColor.hexColor(string: "#E7A236")
        navigationController?.navigationBar.backgroundColor = UIColor.hexColor(string: "#004080")
        //        self.view.backgroundColor = UIColor.hexColor(string: "bbbd4a")
        self.navigationController?.navigationBar.tintColor = UIColor.hexColor(string: "ffffff")
        self.navigationController?.navigationBar.isTranslucent = false
        
        
        
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
            //            NSAttributedStringKey.font: UIFont(name: "HacenTunisiaBd", size: 18)!
        ]
        
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        
        menuBarButton = UIBarButtonItem(image: UIImage(named:"ch_lan"), style: .plain, target: self, action: #selector(self.menuTapped(_:)))
        //        menuBarButton.tintColor = UIColor.hexColor(string: "ffffff")
        self.navigationItem.leftBarButtonItem = menuBarButton
        
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.appearance().semanticContentAttribute = SharedData.SharedInstans.getLanguage() == "en" ? .forceLeftToRight : .forceRightToLeft
        
    }
    
    
    @IBAction func menuTapped(_ sender:UIButton){
        print("open chnage lang")
        
        changeLanguage()
    }
    
    
    func changeLanguage() {
        AppCommon.sharedInstance.alertWith(title: AppCommon.sharedInstance.localization("changeLanguage"), message: AppCommon.sharedInstance.localization("changeLanguageMessage"), controller: self, actionTitle: AppCommon.sharedInstance.localization("change"), actionStyle: .default, withCancelAction: true) {
            
            if  SharedData.SharedInstans.getLanguage() == "en" {
                L102Language.setAppleLAnguageTo(lang: "ar")
                SharedData.SharedInstans.setLanguage("ar")
                
            } else if SharedData.SharedInstans.getLanguage() == "ar" {
                L102Language.setAppleLAnguageTo(lang: "en")
                SharedData.SharedInstans.setLanguage("en")
                
            }
            UIView.appearance().semanticContentAttribute = SharedData.SharedInstans.getLanguage() == "en" ? .forceLeftToRight : .forceRightToLeft
            
            self.modelView(controller: self, storyboardName: "HomeVender", controllerName: "HomeVendrVC")
            
            
        }
    }
    
    func modelView(controller:UIViewController,storyboardName:String,controllerName:String = "" , object:UIViewController? = nil){
        var  viewController = UIViewController()
        let storyboard = UIStoryboard.init(name: storyboardName, bundle: nil)
        if object == nil {
            viewController = storyboard.instantiateViewController(withIdentifier: controllerName)
        }else{
            viewController = object!
        }
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        delegate.window?.rootViewController = storyboard.instantiateInitialViewController()
        
//        controller.navigationController?.pushViewController(viewController, animated: true)
//        controller.(viewController, animated: true, completion: nil)
    }
}
