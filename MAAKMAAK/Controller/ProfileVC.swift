//
//  ProfileVC.swift
//  MaakMaakAPP
//
//  Created by M on 2/11/19.
//  Copyright © 2019 maakmaak. All rights reserved.
//

import UIKit

protocol shareLocationDelegate {
    func shareLocationDelegate(lat: String, Long: String)
}
class ProfileVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var imageProfile: AMCircleImageView!
       @IBOutlet weak var MapImageView: customImageView!
    var AlertController: UIAlertController!
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // sheet to chose
        AlertController = UIAlertController(title:"" , message: "اختر صورة شخصية", preferredStyle: UIAlertController.Style.actionSheet)
        
        let Cam = UIAlertAction(title: "الكاميرا", style: UIAlertAction.Style.default, handler: { (action) in
            self.openCame()
        })
        let Gerall = UIAlertAction(title: "معرض الصور", style: UIAlertAction.Style.default, handler: { (action) in
            self.opengelar()
        })
        
        let Cancel = UIAlertAction(title: "غلق", style: UIAlertAction.Style.cancel, handler: { (action) in
            //
        })
        
        self.AlertController.addAction(Cam)
        self.AlertController.addAction(Gerall)
        self.AlertController.addAction(Cancel)
    }
    
    
    func openCame(){
        
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func opengelar(){
        
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func UpdateImage(_ sender: UIButton) {
        picker.delegate = self
        picker.allowsEditing = false
        self.present(AlertController, animated: true, completion: nil)
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }

        imageProfile.image = selectedImage
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    // chose location
    @IBAction func openMapToShareLocation(_ sender: UIButton) {
        self.tabBarController?.tabBar.isHidden = true
        let storyBoard : UIStoryboard = UIStoryboard(name: "HomeVender", bundle: nil)
        let secondView = storyBoard.instantiateViewController(withIdentifier: "ChooseLocationToShareViewController") as! ChooseLocationToShareViewController
        secondView.shareLocationDelegate = self
        self.navigationController?.pushViewController(secondView, animated: true)
//        show(secondView, sender: nil)
       
    }
    
    func LoadMapImage(lat: String, Long: String)
    {
        
        let Lat = lat
        let Lng = Long
        let staticMapUrl: String = "http://maps.google.com/maps/api/staticmap?markers=color:red|\(Lat),\(Lng)&\("zoom=17&size=\(2 * Int(MapImageView.frame.size.width))x\(2 * Int(MapImageView.frame.size.height))")&sensor=true"
        
        let mapul = "https://maps.google.com/maps/api/staticmap?key=AIzaSyCsqUTyaFGZWyuahXVzjgjT_E3ldB3ECCE&markers=color:red|\(Lat),\(Lng)&\("zoom=17&size=\(2 * Int(MapImageView.frame.size.width))x\(2 * Int(MapImageView.frame.size.height))")&sensor=true&fbclid=IwAR2rsCS0d9D-aow4D3AWs9-fv3EdiSDsFFUU80Gm6oQ7vCZwlXUaPjUOmU8"
        
        let urlI = URL(string: mapul.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        if let url = urlI {
            print("map: \(urlI)")
            MapImageView.loadimageUsingUrlString(url: mapul)
        } else{
            print("map: \(urlI)")
            print("nil")
        }
        
        
    }
}


extension ProfileVC: shareLocationDelegate {
    func shareLocationDelegate(lat: String, Long: String){
       self.tabBarController?.tabBar.isHidden = false
        print(lat,lat)
        LoadMapImage(lat: lat, Long: Long)
      
    }
    
    
}
