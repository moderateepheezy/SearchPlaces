//
//  SearchVC.swift
//  SearchPlaces
//
//  Created by SimpuMind on 9/2/17.
//  Copyright © 2017 SimpuMind. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    let searchField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Search a product"
        tf.borderStyle = .none
        tf.font = UIFont(name: "Orkney-Medium", size: 18)
        tf.returnKeyType = .search
        tf.clearButtonMode = .whileEditing
        tf.backgroundColor = .clear
        return tf
    }()
    
    let searchView: UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.9372549057, blue: 0.9568627477, alpha: 1)
        return v
    }()
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.9372549057, blue: 0.9568627477, alpha: 1)
        tv.separatorStyle = .none
        return tv
    }()
    
    var predictions = [Predictions]()
    var searchedArray = [Predictions]()
    
    func fetchPredictions(text: String){
        ApiService.sharedInstance.fetchAutoCompleteData(input: text) { (predictions, error) in
            
            if error != nil{
                return
            }
            
            guard let predictions = predictions else {return}
            self.predictions = predictions
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        searchField.delegate = self
        //searchField.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        searchField.addTarget(self, action: #selector(searchRecordsAsPerText(_ :)), for: .editingChanged)
        
        let backButton = UIButton(frame: CGRect(x: 0, y: 20, width: 50, height: 45))
        backButton.setImage(#imageLiteral(resourceName: "icon_back"), for: .normal)
        backButton.setTitleColor(UIColor.black, for: .normal)
        backButton.addTarget(self, action: #selector(dismissButton(button:)), for: .touchUpInside)
        self.view.addSubview(backButton)
        
        let frame = CGRect(x: 40, y: 25, width: view.frame.width - 50, height: 35)
        searchView.frame = frame
        searchField.frame = frame
        view.addSubview(searchView)
        
        searchField.frame = CGRect(x: 10, y: 0, width: searchView.frame.width - 10, height: searchView.frame.height)
        
        searchView.addSubview(searchField)
        
        tableView.frame = CGRect(x: 0, y: searchView.frame.origin.y + 45, width: view.frame.width, height: view.frame.height - 80)
        view.addSubview(tableView)
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func dismissButton(button: UIButton){
        navigationController?.popViewController(animated: true)
    }
    
    func searchRecordsAsPerText(_ textfield: UITextField) {
        self.searchedArray.removeAll()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { 
            guard let searchText = textfield.text else {return}
            if searchText.characters.count != 0 {
                let text = searchText.replacingOccurrences(of: " ", with: "")
                self.fetchPredictions(text: text)
            }
        }
        
        self.tableView.reloadData()
    }
}


extension SearchVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return predictions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let prediction = predictions[indexPath.item]
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        cell.textLabel?.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        cell.textLabel?.text = prediction.descriptionValue
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let prediction = predictions[indexPath.item]
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationController?.navigationBar.tintColor = .black
        self.navigationItem.backBarButtonItem = backItem
        let vc = PlaceDetailsVC()
        vc.placeId = prediction.placeId
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchVC: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text?.characters.count != 0 {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.predictions.removeAll()
        tableView.reloadData()
        return true
    }
}

