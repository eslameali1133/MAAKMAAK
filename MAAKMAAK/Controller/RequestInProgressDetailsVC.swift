//
//  RequestInProgressDetailsVC.swift
//  MAAKMAAK
//
//  Created by apple on 2/21/19.
//  Copyright © 2019 Eslammaakmaak. All rights reserved.


import UIKit
import ImageSlideshow
import Kingfisher
class RequestInProgressDetailsVC: UIViewController {

    var menuBarButton = UIBarButtonItem()
    @IBOutlet weak var ImageSlider: ImageSlideshow!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    var  serviceType = 0
    @IBOutlet weak var tblServices: ContentSizedTableView!
    var newService :ServiceType?
    var price = 0
    var OrderId :Int?
    var OrderData : OrderData?
    @IBOutlet weak var lblCustomerName: UILabel!
    @IBOutlet weak var lblBrand: UILabel!
    @IBOutlet weak var lblService: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    let localSource = [ImageSource(imageString: "mains")!, ImageSource(imageString: "mains")!, ImageSource(imageString: "mains")!, ImageSource(imageString: "mains")!]
    override func viewDidLoad(){
        super.viewDidLoad()
        
        getOrderData()
        menuBarButton = UIBarButtonItem(image: UIImage(named:"add (3)"), style: .plain, target: self, action: #selector(self.menuTapped(_:)))
        self.navigationItem.rightBarButtonItem = menuBarButton
    }
    override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()
        self.tableViewHeight.constant = self.tblServices.contentSize.height
        self.view.layoutIfNeeded()
    }
    @IBAction func menuTapped(_ sender:UIButton){
        print("open chnage lang")
        let storyBoard = UIStoryboard(name: "HomeVender", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "AddServiceVC") as! AddServiceVC
        vc.pushed = "2"
        self.navigationController?.pushViewController(vc, animated:true)
    }
    func getOrderData(){
        OrderDetailsModel.getOrderDetails(orderId: OrderId!) { (error:Error?, success:Bool, orderData:OrderData?) in
            if success {
                self.OrderData = orderData!
//                self.setupSlideShow()
            }
        }
    }
    func setImages()  {
        ImageCache.default.memoryStorage.config.totalCostLimit = 1
       
                if (self.OrderData?.orderImges?.count)! > 0 {
                    var images = [KingfisherSource]()
                    ImageCache.default.clearMemoryCache()
                    for index in 0...(self.OrderData?.orderImges?.count)!-1{
                        images.append(KingfisherSource(urlString: self.OrderData?.orderImges[index]))
                    }
                    self.ImageSlider.setImageInputs(images)
                    self.ImageSlider.preload = .all
                
            }
        
    }
    func setupSlideShow(){
        ImageSlider.slideshowInterval = 0
        ImageSlider.pageIndicatorPosition = .init(horizontal: .center, vertical: .bottom)
        ImageSlider.contentScaleMode = UIView.ContentMode.scaleAspectFill
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        pageControl.pageIndicatorTintColor = UIColor.black
        ImageSlider.pageIndicator = pageControl
        //         optional way to show activity indicator during image load (skipping the line will show no activity indicator)
        ImageSlider.activityIndicator = DefaultActivityIndicator()
        ImageSlider.currentPageChanged = { page in
            print("current page:", page)
        }
        // can be used with other sample sources as `afNetworkingSource`, `alamofireSource` or `sdWebImageSource` or `kingfisherSource`
        ImageSlider.setImageInputs(localSource)
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(RequestInProgressDetailsVC.didTap))
        ImageSlider.addGestureRecognizer(recognizer)
    }
    @objc func didTap(){
        let fullScreenController = ImageSlider.presentFullScreenController(from: self )
        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension RequestInProgressDetailsVC :UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.OrderData == nil ? 0 : self.OrderData?.orderDetails?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InvoiceCell", for: indexPath) as! InvoiceCell
        return cell
    }
}
extension RequestInProgressDetailsVC:AddingService {
    func addService(service: ServiceType, price: Int) {
        self.newService = service
        self.price = price
    }
}
