//
//  ProfileVC.swift
//  MaakMaakAPP
//
//  Created by M on 2/11/19.
//  Copyright © 2019 maakmaak. All rights reserved.
//

import UIKit
import SwiftyJSON
import Cosmos
import Alamofire

protocol shareLocationDelegate {
    func shareLocationDelegate(lat: String, Long: String)
}
class ProfileVC: MYViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var vendorProfile: VendorProfileModel?
    
    @IBOutlet weak var imageProfile: customImageView!{
        didSet{
            imageProfile.layer.cornerRadius = imageProfile.frame.width/2
            imageProfile.clipsToBounds = true
        }
    }
    @IBOutlet weak var MapImageView: customImageView!
    @IBOutlet weak var TXTCountry: UITextField!
    @IBOutlet weak var TXTCity: UITextField!
    @IBOutlet weak var TXTArea: UITextField!
    @IBOutlet weak var TXT_ContactPerson: UITextField!
    @IBOutlet weak var TXT_Email: UITextField!
    @IBOutlet weak var TXT_MObile: UITextField!
    @IBOutlet weak var TXT_name: UITextField!
    @IBOutlet weak var Rate: CosmosView!
    
    var AlertController: UIAlertController!
    let picker = UIImagePickerController()
    let pickerCountry = ToolbarPickerView()
    let pickerCity = ToolbarPickerView()
    let pickerArea = ToolbarPickerView()
    var countryArray: [CountryModel] = [CountryModel]()
    var CityArray: [CityModel] = [CityModel]()
    var AreaArray: [AreaModel] = [AreaModel]()
    var userid = ""
    var http = HttpHelper()
    var pickerslectnum = 0 // flage to different betwwen Deopdown
    var CountryID = ""
    var CityID = ""
    var AreaID = ""
    var LatPosition = ""
    var LngPosition = ""
    
    var ComeFromSetData = false
    override func viewDidLoad() {
        super.viewDidLoad()
        http.delegate = self
        if  SharedData.SharedInstans.GetIsLogin(){
            userid =  UserDefaults.standard.string(forKey: "UserId")!
            loadProfileData()
        }
        SetupUploadImage()
        SetUpPicker()
        // sheet to chose
        
    }
    
    func loadProfileData (){
        
        let params = ["userId":userid] as [String: Any]
        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        http.GetWithoutHeader(url: APIConstants.GetVenderProfile, parameters: params, Tag: 1)
        loadCountryData()
    }
    func SetData(){
        print(vendorProfile?.mobile)
        TXT_MObile.text = vendorProfile?.mobile
        TXT_name.text = vendorProfile?.companyName
        Rate.rating = Double((vendorProfile?.rate)!)
        TXT_Email.text = vendorProfile?.email
        
        if vendorProfile?.contactPerson != "null" || vendorProfile?.contactPerson != ""
        {
            TXT_ContactPerson.text = vendorProfile?.contactPerson
        }
        print(vendorProfile?.image)
        
        if  (vendorProfile?.image)! != ""
        {
            imageProfile.loadimageUsingUrlString(url: (vendorProfile?.image)!)
        }else
        {
            imageProfile.image =  UIImage(named: "man")
        }
        
        if  (vendorProfile?.latitude)! != "" || (vendorProfile?.latitude)! != "0"
        {
            LoadMapImage(lat:(vendorProfile?.latitude)! , Long: (vendorProfile?.longitude)!)
        }else
        {
            MapImageView.image =  UIImage(named: "officePlaceholder-1")
        }
        
        self.LatPosition = (vendorProfile?.latitude)!
        self.LngPosition = (vendorProfile?.longitude)!
        
        
    }
    
    func loadCountryData(){
        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        http.GetWithoutHeader(url: APIConstants.GetCountry, Tag: 2)
    }
    
    func loadCityData(countryid:String){
        let params = ["countryId":countryid] as [String: Any]
        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        http.GetWithoutHeader(url: APIConstants.GetCity, parameters: params, Tag: 3)
    }
    
    func loadAreaData(cityid:String){
        let params = ["cityId":cityid] as [String: Any]
        AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
        http.GetWithoutHeader(url: APIConstants.GetArea, parameters: params, Tag: 4)
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
        
        let mapul = "https://maps.google.com/maps/api/staticmap?key=AIzaSyB-3KGui1I1wguVGxALFNa5cld4ijK8fS4&markers=color:red|\(Lat),\(Lng)&\("zoom=17&size=\(2 * Int(MapImageView.frame.size.width))x\(2 * Int(MapImageView.frame.size.height))")&sensor=true&fbclid=IwAR2rsCS0d9D-aow4D3AWs9-fv3EdiSDsFFUU80Gm6oQ7vCZwlXUaPjUOmU8"
        
        let urlI = URL(string: mapul.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        if let url = urlI {
            print("map: \(urlI!)")
            MapImageView.loadimageUsingUrlString(url: mapul)
        } else{
            print("map: \(urlI)")
            print("nil")
        }
        
    }
    
    
    
    func UpdateCustomerProfile() {
          let mobile = UserDefaults.standard.string(forKey: "mobile")!
        let UserId = UserDefaults.standard.string(forKey: "UserId")!
        var parameters = [:] as [String: Any]
      
        print(mobile)
        let data = self.imageProfile.image!.jpegData(compressionQuality: 0.5)
        let headers: HTTPHeaders = [
            /* "Authorization": "your_access_token",  in case you need authorization header */
            "Content-type": "multipart/form-data"
        ]
        parameters = [
            "UserId" : UserId,
            "CompanyName": TXT_name.text!,
            "Image": data!,
            "Mobile": mobile,
            "CityId" : CityID,
            "AreaId": AreaID,
            "CountryId" : CountryID,
            "ContactPerson": TXT_ContactPerson.text!,
            "Latitude" : LatPosition,
            "Longitude": LngPosition,
            "Email" : TXT_Email.text!,
            
        ]
        
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                for (key,value) in parameters {
                    if let value = value as? String {
                        multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                    }
                }
                
                if let data = self.imageProfile.image!.jpegData(compressionQuality: 0.5){
                    multipartFormData.append(data, withName: "image", fileName: "Venderphoto\(arc4random_uniform(100))"+".jpeg", mimeType: "image/jpeg")
                }
                
//                let data = self.imageProfile.image!.jpegData(compressionQuality: 0.5)
//
//                multipartFormData.append(data!, withName: "Venderphoto", fileName: "Venderphoto\(arc4random_uniform(100))"+".jpeg", mimeType: "image/jpeg")
                
        },
            usingThreshold:UInt64.init(),
            to: "http://hwsrv-434369.hostwindsdns.com/api/ProviderAccount/SaveProfile",
            method: .post, headers: headers,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    
                    upload.uploadProgress(closure: { (progress) in
                        print(progress)
                    })
                    upload.responseJSON { response in
                        // If the request to get activities is succesfull, store them
                        if response.result.isSuccess{
                            print(response.debugDescription)
                            AppCommon.sharedInstance.dismissLoader(self.view)
                            
                        } else {
                            var errorMessage = "ERROR MESSAGE: "
                            if let data = response.data {
                                // Print message
                                print(errorMessage)
                                AppCommon.sharedInstance.dismissLoader(self.view)
                                
                            }
                            print(errorMessage) //Contains General error message or specific.
                            print(response.debugDescription)
                            AppCommon.sharedInstance.dismissLoader(self.view)
                        }
                        
                        
                    }
                case .failure(let encodingError):
                    print("FALLE ------------")
                    print(encodingError)
                    AppCommon.sharedInstance.dismissLoader(self.view)
                }
        }
        )
    }
    
    
    @IBAction func Btn_Save(_ sender: Any) {
        if validation(){
            AppCommon.sharedInstance.ShowLoader(self.view,color: UIColor.hexColorWithAlpha(string: "#000000", alpha: 0.35))
            UpdateCustomerProfile()
        }
    }
    
}


extension ProfileVC: shareLocationDelegate {
    func shareLocationDelegate(lat: String, Long: String){
        self.tabBarController?.tabBar.isHidden = false
        print(lat,Long)
        self.LatPosition = lat
        self.LngPosition = Long
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
                print(CityArray[row-1].id)
                
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
                    loadCityData(countryid: countryArray[row-1].id)
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
                    loadAreaData(cityid: CityArray[row-1].id)
                }
            }
            
        }
        else {
            pickerslectnum = 3
            if AreaArray.count != 0 {
                if row == 0 {
                    TXTArea.text = nil
                    
                }else {
                    if SharedData.SharedInstans.getLanguage() == "en"
                    {
                        TXTArea.text = AreaArray[row-1].nameEN
                    }else
                    {
                        TXTArea.text = AreaArray[row-1].nameAR
                    }
                    AreaID = AreaArray[row-1].id
                    
                }
            }
            
        }
        
        //        self.view.endEditing(true)
    }
    
    func validation () -> Bool {
        var isValid = true
        
        if AreaID == "" {
            Loader.showError(message: AppCommon.sharedInstance.localization("AreaReq"))
            isValid = false
        }
        if CityID == "" {
            Loader.showError(message: AppCommon.sharedInstance.localization("CityReq"))
            isValid = false
        }
        
        if CountryID == "" {
            Loader.showError(message: AppCommon.sharedInstance.localization("CountrtReq"))
            isValid = false
        }
        
        
        if TXT_name.text! == "" {
            Loader.showError(message: AppCommon.sharedInstance.localization("NameReq"))
            isValid = false
        }
        return isValid
    }
    
    
    
    
}



extension ProfileVC: HttpHelperDelegate {
    func receivedResponse(dictResponse: Any, Tag: Int) {
        print(dictResponse)
        AppCommon.sharedInstance.dismissLoader(self.view)
        let forbiddenMail : String = AppCommon.sharedInstance.localization("Duplicated user")
        if Tag == 1 {
            
            let json = JSON(dictResponse)
            let Result =  JSON(json["result"])
            let message =  JSON(json["message"])
            let status =  JSON(json["status"])
            print(Result)
            print(message)
            print(status)
            if status.stringValue == "400" {
                vendorProfile = VendorProfileModel(userId: Result["userId"].stringValue, mobile:  Result["mobile"].stringValue, email:Result["email"].stringValue , rate:  Result["rate"].intValue, image:  Result["image"].stringValue, companyName:  Result["companyName"].stringValue, cityId:  Result["cityId"].stringValue, areaId:  Result["areaId"].stringValue, countryId:  Result["countryId"].stringValue, latitude:  Result["latitude"].stringValue, longitude:  Result["longitude"].stringValue, contactPerson:  Result["contactPerson"].stringValue)
                
                print(Result["mobile"].stringValue)
                
                if Result["countryId"].stringValue != "null" ||   Result["countryId"].stringValue != "" {
                    CountryID = Result["countryId"].stringValue
                    CityID =  Result["cityId"].stringValue
                    AreaID =  Result["areaId"].stringValue
                    loadCountryData()
                    loadCityData(countryid: Result["countryId"].stringValue)
                    loadAreaData(cityid:  Result["cityId"].stringValue)
                    ComeFromSetData = true
                }
                print(countryArray.count)
                SetData()
                
            } else {
                
                Loader.showError(message: (forbiddenMail))
            }
        }
            
        else if Tag == 2 {
            
            let json = JSON(dictResponse)
            let Result =  JSON(json["result"])
            let message =  JSON(json["message"])
            let status =  JSON(json["status"])
            print(Result)
            print(message)
            print(status)
            countryArray.removeAll()
            if status.stringValue == "201" {
                let result =  json["result"].arrayValue
                for json in result{
                    let obj = CountryModel(id: json["id"].stringValue, nameAR:  json["nameAR"].stringValue, nameEN:  json["nameEN"].stringValue)
                    countryArray.append(obj)
                    
                }
                
                if ComeFromSetData == true{
                    print(countryArray.first{$0.id == CountryID}?.nameEN)
                    
                    if SharedData.SharedInstans.getLanguage() == "en"
                    {
                        TXTCountry.text = countryArray.first{$0.id == CountryID}?.nameEN
                        
                    }else
                    {
                        TXTCountry.text = countryArray.first{$0.id == CountryID}?.nameAR
                    }
                }
                
            } else {
                
                Loader.showError(message: (forbiddenMail))
            }
        }
            
        else if Tag == 3 {
            
            let json = JSON(dictResponse)
            let Result =  JSON(json["result"])
            let message =  JSON(json["message"])
            let status =  JSON(json["status"])
            print(Result)
            print(message)
            print(status)
            if status.stringValue == "201" {
                let result =  json["result"].arrayValue
                for json in result{
                    let obj = CityModel(id: json["id"].stringValue, nameAR:  json["nameAR"].stringValue, nameEN:  json["nameEN"].stringValue)
                    CityArray.append(obj)
                    
                }
                
                if ComeFromSetData == true{
                    print(CityArray.first{$0.id == CityID}?.nameEN)
                    
                    if SharedData.SharedInstans.getLanguage() == "en"
                    {
                        TXTCity.text = CityArray.first{$0.id == CityID}?.nameEN
                        
                    }else
                    {
                        TXTCity.text = CityArray.first{$0.id == CityID}?.nameAR
                    }
                }
                
                
            } else {
                
                Loader.showError(message: (forbiddenMail))
            }
        }
            
        else if Tag == 4 {
            
            let json = JSON(dictResponse)
            let Result =  JSON(json["result"])
            let message =  JSON(json["message"])
            let status =  JSON(json["status"])
            print(Result)
            print(message)
            print(status)
            if status.stringValue == "200" {
                let result =  json["result"].arrayValue
                for json in result{
                    let obj = AreaModel(id: json["id"].stringValue, nameAR:  json["nameAR"].stringValue, nameEN:  json["nameEN"].stringValue)
                    AreaArray.append(obj)
                    
                }
                
                if ComeFromSetData == true{
                    ComeFromSetData = false
                    print(AreaArray.first{$0.id == AreaID}?.nameEN)
                    
                    if SharedData.SharedInstans.getLanguage() == "en"
                    {
                        TXTArea.text = AreaArray.first{$0.id == AreaID}?.nameEN
                        
                    }else
                    {
                        TXTArea.text = AreaArray.first{$0.id == AreaID}?.nameAR
                    }
                }
                
            } else {
                
                Loader.showError(message: (forbiddenMail))
            }
        }
        
    }
    
    func receivedErrorWithStatusCode(statusCode: Int) {
        print(statusCode)
        AppCommon.sharedInstance.alert(title: "Error", message: "\(statusCode)", controller: self, actionTitle: AppCommon.sharedInstance.localization("ok"), actionStyle: .default)
        
        AppCommon.sharedInstance.dismissLoader(self.view)
    }
    
    func retryResponse(numberOfrequest: Int) {
        
    }
}
