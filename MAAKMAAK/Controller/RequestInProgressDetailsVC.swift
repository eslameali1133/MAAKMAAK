//
//  RequestInProgressDetailsVC.swift
//  MAAKMAAK
//
//  Created by apple on 2/21/19.
//  Copyright © 2019 Eslammaakmaak. All rights reserved.


import UIKit
import ImageSlideshow
class RequestInProgressDetailsVC: UIViewController {

    var menuBarButton = UIBarButtonItem()
    @IBOutlet weak var ImageSlider: ImageSlideshow!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var tblServices: ContentSizedTableView!
    
    let localSource = [ImageSource(imageString: "mains")!, ImageSource(imageString: "mains")!, ImageSource(imageString: "mains")!, ImageSource(imageString: "mains")!]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSlideShow()
        menuBarButton = UIBarButtonItem(image: UIImage(named:"add (1)"), style: .plain, target: self, action: #selector(self.menuTapped(_:)))
        //        menuBarButton.tintColor = UIColor.hexColor(string: "ffffff")
        self.navigationItem.rightBarButtonItem = menuBarButton
        // Do any additional setup after loading the view.
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.tableViewHeight.constant = self.tblServices.contentSize.height
        self.view.layoutIfNeeded()
    }
    @IBAction func menuTapped(_ sender:UIButton){
        print("open chnage lang")
        performSegue(withIdentifier: "show", sender: self)
        //        changeLanguage()
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InvoiceCell", for: indexPath) as! InvoiceCell
        return cell
    }
    
    
}
