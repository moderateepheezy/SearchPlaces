//
//  PlaceDetailsVC.swift
//  SearchPlaces
//
//  Created by SimpuMind on 9/9/17.
//  Copyright © 2017 SimpuMind. All rights reserved.
//

import UIKit
import AARatingBar
import GoogleMaps

/**
 ** TODOs:
 ** 1: Fix short Scrolling issue review TableView
 ** 2: Add an activity indicator
 ** 3: Fix some issues with guard statement
 **/

class PlaceDetailsVC: UIViewController {

    var placeId: String?
    
    var placeImgArray = [Photos]()
    var reviewsArray = [Reviews]()
    
    let mapview: GMSMapView = {
       let mapview = GMSMapView()
        return mapview
    }()
    
    let placeNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: 0.3)
        label.textColor = #colorLiteral(red: 0.4431372549, green: 0.3525575725, blue: 0.5058823529, alpha: 1)
        return label
    }()
    
    let distanceLabel: SpaceLabel = {
        let label = SpaceLabel()
        label.text = "1.3 KM NEARBY"
        label.characterSpacing = 2
        label.font = UIFont.systemFont(ofSize: 14, weight: 0)
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return label
    }()
    
    let ratingbar: AARatingBar = {
        let rb = AARatingBar()
        rb.backgroundColor = .clear
        rb.color = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        rb.isEnabled = false
        return rb
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
    }()
    
    let reviewTextlabel: UILabel = {
       let label = UILabel()
        label.text = "REVIEWS"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = #colorLiteral(red: 0.4431372549, green: 0.3525575725, blue: 0.5058823529, alpha: 1)
        return label
    }()
    
    let tableView: UITableView = {
       let tv = UITableView()
        tv.backgroundColor = .white
        tv.separatorInset = UIEdgeInsets.zero
        tv.separatorColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return tv
    }()
    
    func fetchPlaceDetails(placeId: String){
        ApiService.sharedInstance.fetchPlaceDetails(placeId: placeId) { (result, error) in
            if error != nil {
                self.navigationController?.popViewController(animated: true)
                return
            }
            guard let result = result else {return}
            self.placeImgArray = result.photos ?? []
            self.reviewsArray = result.reviews ?? []
            self.setupViewsData(result: result)
            self.collectionView.sizeToFit()
            self.collectionView.reloadData()
            self.tableView.sizeToFit()
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        fetchPlaceDetails(placeId: placeId!)
        
        let mapTypeBarButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(changeMapType(barButton:)))
        
        navigationItem.rightBarButtonItem = mapTypeBarButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func setupViewsData(result: Result){
        addSubViews()
        if let geometry  = result.geometry, let location = geometry.location , let name = result.name {
            guard let longitude = location.lng, let latutude = location.lat else {return}
            let long = CLLocationDegrees(longitude)
            let lat = CLLocationDegrees(latutude)
            let camera = GMSCameraPosition.camera(withLatitude: lat,
                                                  longitude: long,
                                                  zoom: 17.5)
            mapview.camera = camera
            
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
            marker.title = name
            marker.appearAnimation = .pop
            marker.map = mapview
        }
        
        guard let placeName = result.name else {return}
        guard let rateValue = result.rating else {return}
        ratingbar.value = CGFloat(rateValue)
        
        placeNameLabel.text = placeName
        
    }
    
    
    func changeMapType(barButton: UIBarButtonItem){
        
        let actionSheet = UIAlertController(title: "Map Types", message: "Select map type:", preferredStyle: .actionSheet)
        
        let normalMapTypeAction = UIAlertAction(title: "Normal", style: .default) { (action) in
            self.mapview.mapType = .normal
        }
        
        
        let terrainMapTypeAction = UIAlertAction(title: "Terrain", style: .default) { (alertAction) -> Void in
            self.mapview.mapType = .terrain
        }
        
        let hybridMapTypeAction = UIAlertAction(title: "Hybrid", style: .default) { (alertAction) -> Void in
            self.mapview.mapType = .hybrid
        }
        
        let cancelAction = UIAlertAction(title: "Close", style: .destructive) { (action) in
            
        }
            
            
            
        actionSheet.addAction(normalMapTypeAction)
        actionSheet.addAction(terrainMapTypeAction)
        actionSheet.addAction(hybridMapTypeAction)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    func addSubViews(){
        view.addSubview(mapview)
        view.addSubview(placeNameLabel)
        view.addSubview(distanceLabel)
        view.addSubview(ratingbar)
        view.addSubview(reviewTextlabel)
        view.addSubview(collectionView)
        view.addSubview(tableView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PlacePicturesCell.self, forCellWithReuseIdentifier: "pictureCell")
        
        tableView.delegate =  self
        tableView.dataSource = self
        tableView.rowHeight = 190
        tableView.register(ReviewCell.self, forCellReuseIdentifier: "reviewCell")
        setupUIConstraints()
    }
    
    func setupUIConstraints(){
       _ = mapview.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 350)
        
        _ = placeNameLabel.anchor(mapview.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: view.frame.width, heightConstant: 18)
        
        _ = ratingbar.anchor(placeNameLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 90, heightConstant: 14)
        
        _ = distanceLabel.anchor(placeNameLabel.bottomAnchor, left: ratingbar.rightAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 20, widthConstant: 300, heightConstant: 14)
        
        _ = collectionView.anchor(ratingbar.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 100)
        
        _ = reviewTextlabel.anchor(collectionView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: view.frame.width, heightConstant: 17)
        
        _ = tableView.anchor(reviewTextlabel.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 10, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 0)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }

    let blackBackgroundView = UIView()
    let zoomImageView = UIImageView()
    let navBarCoverView = UIView()
    let tabBarCoverView = UIView()
    var statusImageView: UIImageView?
    
}

extension PlaceDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return placeImgArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pictureCell", for: indexPath) as! PlacePicturesCell
        if let imgRef = placeImgArray[indexPath.item].photoReference {
            cell.imgRef = imgRef
            cell.placeDetailsVc = self
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
    }
}

extension PlaceDetailsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as! ReviewCell
        cell.review = reviewsArray[indexPath.item]
        cell.selectionStyle = .none
        return cell
    }
}

extension PlaceDetailsVC {
    func animateImageView(imageView: UIImageView){
        
        if let startingFrame = imageView.superview?.convert(imageView.frame, to: nil){
            self.statusImageView = imageView
            
            imageView.alpha = 0
            
            blackBackgroundView.frame = view.frame
            blackBackgroundView.backgroundColor = .black
            blackBackgroundView.alpha = 0
            view.addSubview(blackBackgroundView)
            
            navBarCoverView.frame = CGRect(x: 0, y: 0, width: 1000, height: 20 + 44)
            navBarCoverView.backgroundColor = .black
            navBarCoverView.alpha = 0
            
            if let keyWindow = UIApplication.shared.keyWindow{
                keyWindow.addSubview(navBarCoverView)
                
                tabBarCoverView.frame = CGRect(x: 0, y: keyWindow.frame.height - 49, width: 1000, height: 49)
                tabBarCoverView.backgroundColor = .black
                tabBarCoverView.alpha = 0
                
                keyWindow.addSubview(tabBarCoverView)
            }
            
            zoomImageView.backgroundColor = .red
            zoomImageView.isUserInteractionEnabled = true
            zoomImageView.image = imageView.image
            zoomImageView.contentMode = .scaleAspectFill
            zoomImageView.clipsToBounds = true
            zoomImageView.frame = startingFrame
            view.addSubview(zoomImageView)
            zoomImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(zoomOut)))
            
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                
                let height = (self.view.frame.width / startingFrame.width) * startingFrame.height
                
                let y = self.view.frame.height / 2 - height / 2
                
                self.zoomImageView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: height)
                
                self.blackBackgroundView.alpha = 1
                
                self.navBarCoverView.alpha = 1
                
                self.tabBarCoverView.alpha = 1
                
            }, completion: nil)
            
        }
    }
    
    @objc func zoomOut(){
        if let startingFrame = statusImageView?.superview?.convert(statusImageView!.frame, to: nil){
            
            UIView.animate(withDuration: 0.75, animations: {
                self.zoomImageView.frame = startingFrame
                self.navBarCoverView.alpha = 0
                self.blackBackgroundView.alpha = 0
                self.tabBarCoverView.alpha = 0
            }, completion: { (didComplete) in
                self.zoomImageView.removeFromSuperview()
                self.blackBackgroundView.removeFromSuperview()
                self.navBarCoverView.removeFromSuperview()
                self.tabBarCoverView.removeFromSuperview()
                self.statusImageView?.alpha = 1
            })
        }
    }
}
