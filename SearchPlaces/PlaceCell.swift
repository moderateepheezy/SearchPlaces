//
//  PlaceCell.swift
//  SearchPlaces
//
//  Created by SimpuMind on 9/2/17.
//  Copyright © 2017 SimpuMind. All rights reserved.
//

import UIKit
import AARatingBar
import SDWebImage

class PlaceCell: UITableViewCell {
    
    var result: Results?{
        didSet{
            let placeImages = result?.photos ?? []
            let placeName = result?.name ?? ""
            let rateValue = result?.rating ?? 0
            ratingbar.value = CGFloat(rateValue)
            
            placeNameLabel.text = placeName
            if placeImages.count != 0{
                guard let ref = placeImages[0].photoReference else {return}
                let imgString = Utilities.imageUrl(ref: ref)
                let url = URL(string: imgString)
                placeImageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "placeholder"))
            }
        }
    }
    
    let containerView: CardView = {
       let view = CardView()
        view.shadowColor = #colorLiteral(red: 0.89453125, green: 0.89453125, blue: 0.89453125, alpha: 1)
        view.backgroundColor = .white
        return view
    }()
    
    let placeImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let placeNameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: 0.3)
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
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

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(containerView)
        self.containerView.addSubview(placeImageView)
        self.containerView.addSubview(placeNameLabel)
        self.containerView.addSubview(distanceLabel)
        self.containerView.addSubview(ratingbar)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.01910316781)
        setupViews()
        
    }
    
    private func setupViews() {
        
        setupContaints()
    }
    
    func setupContaints(){
       _ = containerView.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 240)
        
        _ = placeImageView.anchor(containerView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 160)
        
        _ = placeNameLabel.anchor(placeImageView.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: containerView.frame.width, heightConstant: 18)
        
        _ = ratingbar.anchor(placeNameLabel.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 90, heightConstant: 14)
        
        _ = distanceLabel.anchor(placeNameLabel.bottomAnchor, left: ratingbar.rightAnchor, bottom: nil, right: containerView.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 20, widthConstant: 300, heightConstant: 14)
    }

}
