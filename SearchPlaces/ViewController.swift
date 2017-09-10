//
//  ViewController.swift
//  SearchPlaces
//
//  Created by SimpuMind on 9/2/17.
//  Copyright © 2017 SimpuMind. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController{
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.separatorColor = .clear
        return tv
    }()
    
    let bgImageView: UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "Map")
        iv.blurEffect()
        return iv
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = #colorLiteral(red: 0.4431372549, green: 0.3525575725, blue: 0.5058823529, alpha: 1)
        
        return refreshControl
    }()
    
    var nearbyViewModel = NearbyViewModel()
    let locationManager = CLLocationManager()
    
    var coordinate : CLLocationCoordinate2D?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Places Near You"
        
        let searchBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleSearch(barButtonItem:)))
        
        searchBarButtonItem.tintColor = .black
        
        navigationItem.rightBarButtonItem = searchBarButtonItem
        
        view.addSubview(bgImageView)
        view.addSubview(tableView)
        tableView.addSubview(refreshControl)
        
        setupConstraints()
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.allowsBackgroundLocationUpdates = false
            self.locationManager.activityType = .other
            self.locationManager.requestAlwaysAuthorization()
            self.locationManager.startUpdatingLocation()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 260
        tableView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.01910316781)
        tableView.register(PlaceCell.self, forCellReuseIdentifier: "cell")
        
        loadData()
    }
    
    func loadData(){
        guard let cordinate = locationManager.location?.coordinate else {return}
        let locValue: CLLocationCoordinate2D = cordinate
        print(locValue.latitude)
        print(locValue.longitude)
        self.nearbyViewModel.fetchNearbyResults(longitude:  String(locValue.longitude), latitude: String(locValue.latitude)) {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = nil
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func setupConstraints(){
        
        _ = bgImageView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        _ = tableView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 84, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    func handleSearch(barButtonItem: UIBarButtonItem) {
        let vc = SearchVC()
        vc.searchField.becomeFirstResponder()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func handleRefresh(_ refreshControl: UIRefreshControl) {
        loadData()
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nearbyViewModel.numberOfItemsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PlaceCell
        cell.selectionStyle = .none
        
        cell.result = nearbyViewModel.resultForItemAt(indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let result = nearbyViewModel.resultForItemAt(indexPath: indexPath)
        let vc = PlaceDetailsVC()
        vc.placeId = result.placeId!
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationController?.navigationBar.tintColor = .black
        self.navigationItem.backBarButtonItem = backItem
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
            print(error)
    }
}


