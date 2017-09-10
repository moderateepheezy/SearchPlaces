//
//  PlacePicturesCell.swift
//  SearchPlaces
//
//  Created by SimpuMind on 9/9/17.
//  Copyright © 2017 SimpuMind. All rights reserved.
//

import UIKit

class PlacePicturesCell: UICollectionViewCell {
    
    var placeDetailsVc: PlaceDetailsVC?
    
    var imgRef: String?{
        didSet{
            guard let urlString = imgRef else {return}
            let apiUrl = Utilities.imageUrl(ref: urlString)
            let url = URL(string: apiUrl)
            imageView.sd_setImage(with: url, placeholderImage: nil)
        }
    }
    
    let imageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.isUserInteractionEnabled = true
        iv.layer.masksToBounds = true
        iv.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.9372549057, blue: 0.9568627477, alpha: 1)
        return iv
    }()
    
    public func animate(sender: UITapGestureRecognizer){
        placeDetailsVc?.animateImageView(imageView: imageView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        addSubview(imageView)
        _ = imageView.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animate(sender:))))
    }
}
