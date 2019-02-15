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
class ProfileVC: MYViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var imageProfile: AMCircleImageView!
    @IBOutlet weak var MapImageView: customImageView!
      @IBOutlet weak var TXTCountry: UITextField!
     @IBOutlet weak var TXTCity: UITextField!
     @IBOutlet weak var TXTArea: UITextField!
    var AlertController: UIAlertController!
    let picker = UIImagePickerController()
    let pickerCountry = ToolbarPickerView()
    let pickerCity = ToolbarPickerView()
    let pickerArea = ToolbarPickerView()
      var countryArray: [CountryModel] = [CountryModel]()
      var CityArray: [CityModel] = [CityModel]()
      var AreaArray: [AreaModel] = [AreaModel]()
    
     var pickerslectnum = 0 // flage to different betwwen Deopdown
    var CountryID = ""
     var CityID = ""
      var AreaID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        SetupUploadImage()
        SetUpPicker()
        // sheet to chose
       
    }
    
    func loadData(){
        
        var CountryMode = CountryModel()
        CountryMode.id = "1"
         CountryMode.nameAR = "مصر"
        CountryMode.nameEN = "Egypt"
        
        countryArray.append(CountryMode)
        
    }
    func SetUpPicker(){
        
        TXTCountry.inputView = pickerCountry
        self.TXTCountry.inputAccessoryView = self.pickerCountry.toolbar
        pickerCountry.delegate = self
        pickerCountry.dataSource = self
        self.pickerCountry.toolbarDelegate = self
        self.pickerCountry.reloadAllComponents()
        
        
        TXTCity.inputView = pickerCity
        self.TXTCity.inputAccessoryView = self.pickerCity.toolbar
        pickerCity.delegate = self
        pickerCity.dataSource = self
        self.pickerCity.toolbarDelegate = self
        self.pickerCity.reloadAllComponents()
        
        
        TXTArea.inputView = pickerArea
        self.TXTArea.inputAccessoryView = self.pickerArea.toolbar
        pickerArea.delegate = self
        pickerArea.dataSource = self
        self.pickerArea.toolbarDelegate = self
        self.pickerArea.reloadAllComponents()
        
        
        
    }
    
    func SetupUploadImage()
    {
        AlertController = UIAlertController(title:"" , message:AppCommon.sharedInstance.localization("ChoseImage") , preferredStyle: UIAlertController.Style.actionSheet)
        
        let Cam = UIAlertAction(title: AppCommon.sharedInstance.localization("camera"), style: UIAlertAction.Style.default, handler: { (action) in
            self.openCame()
        })
        let Gerall = UIAlertAction(title: AppCommon.sharedInstance.localization("gallery"), style: UIAlertAction.Style.default, handler: { (action) in
            self.opengelar()
        })
        
        let Cancel = UIAlertAction(title: AppCommon.sharedInstance.localization("cancel"), style: UIAlertAction.Style.cancel, handler: { (action) in
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

extension ProfileVC: ToolbarPickerViewDelegate {
    
    func didTapDone() {
        
        self.view.endEditing(true)
    }
    
    func didTapCancel() {
        if  pickerslectnum == 1
        {
            self.TXTCountry.text = nil
            self.TXTCountry.resignFirstResponder()
        }else if pickerslectnum == 2{
            self.TXTCity.text = nil
            self.TXTCity.resignFirstResponder()
            
        }else if pickerslectnum == 3{
           
            self.TXTArea.text = nil
            self.TXTArea.resignFirstResponder()
          
        }else
        {
            print("nil")
        }
        self.view.endEditing(true)
    }
}

//AppCommon.sharedInstance.localization("cancel")
extension ProfileVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerCountry {
            return countryArray.count+1
        }
        else if pickerView == pickerCity {
            return CityArray.count+1
            
        }  else {
            return AreaArray.count+1
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerCountry {
            if row == 0{
                return  AppCommon.sharedInstance.localization("Chosecountry")
            }else {
               if SharedData.SharedInstans.getLanguage() == "en"
               {
                return countryArray[row-1].nameEN
                }else
               {
                return countryArray[row-1].nameAR
                }
            }
        } else if pickerView == pickerCity {
            if row == 0{
                return  AppCommon.sharedInstance.localization("ChoseCity")
            }else {
                if SharedData.SharedInstans.getLanguage() == "en"
                {
                return CityArray[row-1].nameEN
                }else
                {
                     return CityArray[row-1].nameAR
                }
            }
        } else {
            if row == 0{
                return AppCommon.sharedInstance.localization("ChoseArea")
            }else {
                if SharedData.SharedInstans.getLanguage() == "en"
                {
                    return AreaArray[row-1].nameEN
                }else
                {
                    return AreaArray[row-1].nameAR
                }
            }
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerCountry {
            pickerslectnum = 1
            if countryArray.count != 0 {
                if row == 0 {
                    TXTCountry.text = nil
                  
                }else {
                    if SharedData.SharedInstans.getLanguage() == "en"
                    {
                        TXTCountry.text = countryArray[row-1].nameEN
                    }else
                    {
                        TXTCountry.text = countryArray[row-1].nameAR
                    }
                    CountryID = countryArray[row-1].id
//                    sectionModel.GetProvincesReg(view: self.view, provincesID: provincesID, VC: self)
                }
            }
            
        } else if pickerView == pickerCity {
            pickerslectnum = 2
            if CityArray.count != 0 {
                if row == 0 {
                    TXTCity.text = nil
                    
                }else {
                    if SharedData.SharedInstans.getLanguage() == "en"
                    {
                        TXTCity.text = CityArray[row-1].nameEN
                    }else
                    {
                        TXTCity.text = CityArray[row-1].nameAR
                    }
                    CityID = CityArray[row-1].id
                    //                    sectionModel.GetProvincesReg(view: self.view, provincesID: provincesID, VC: self)
                }
            }
            else {
                pickerslectnum = 3
                if AreaArray.count != 0 {
                    if row == 0 {
                        TXTCountry.text = nil
                        
                    }else {
                        if SharedData.SharedInstans.getLanguage() == "en"
                        {
                            TXTCountry.text = AreaArray[row-1].nameEN
                        }else
                        {
                            TXTCountry.text = AreaArray[row-1].nameAR
                        }
                        AreaID = AreaArray[row-1].id
                        //                    sectionModel.GetProvincesReg(view: self.view, provincesID: provincesID, VC: self)
                    }
                }
            
        }
        }
        
        //        self.view.endEditing(true)
    }
    
}
