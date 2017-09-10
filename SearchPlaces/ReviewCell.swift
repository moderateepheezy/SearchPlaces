//
//  ReviewCell.swift
//  SearchPlaces
//
//  Created by SimpuMind on 9/10/17.
//  Copyright © 2017 SimpuMind. All rights reserved.
//

import UIKit
import AARatingBar

class ReviewCell: UITableViewCell {

    var review: Reviews? {
        didSet{
            guard let imgeUrl = review?.profilePhotoUrl else {return}
            guard let userName = review?.authorName else {return}
            guard let rating = review?.rating else {return}
            guard let text = review?.text else {return}
            guard let time = review?.time else {return}
            
            let url = URL(string: imgeUrl)
            userImageView.sd_setImage(with: url, completed: nil)
            ratingbar.value = CGFloat(rating)
            reviewerNameLabel.text = userName
            reviewTextLabel.text = text
            
            let epocTime = TimeInterval(time)
            let date = Date(timeIntervalSince1970: epocTime)
            reviewTimeLabel.text = Utilities.timeAgoSinceDate(date)
        }
    }
    
    let userImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let ratingbar: AARatingBar = {
        let rb = AARatingBar()
        rb.backgroundColor = .clear
        rb.color = #colorLiteral(red: 0.4431372549, green: 0.4352941176, blue: 0.5058823529, alpha: 1)
        rb.isEnabled = false
        return rb
    }()
    
    let reviewerNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = #colorLiteral(red: 0.2078431373, green: 0.2039215686, blue: 0.2392156863, alpha: 1)
        return label
    }()
    
    let reviewTextLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = #colorLiteral(red: 0.4431372549, green: 0.4352941176, blue: 0.5058823529, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    let reviewTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = #colorLiteral(red: 0.6078431373, green: 0.6, blue: 0.662745098, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
   
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(userImageView)
        self.contentView.addSubview(ratingbar)
        self.contentView.addSubview(reviewerNameLabel)
        self.contentView.addSubview(reviewTextLabel)
        self.contentView.addSubview(reviewTimeLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        userImageView.layer.cornerRadius = userImageView.frame.height / 2
        userImageView.clipsToBounds = true
        
        setupUIcontriants()
        
    }
    
    func setupUIcontriants(){
        _ = userImageView.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 40, heightConstant: 40)
        
        _ = reviewerNameLabel.anchor(self.topAnchor, left: userImageView.rightAnchor, bottom: nil, right: self.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 17)
        
        _ = ratingbar.anchor(reviewerNameLabel.bottomAnchor, left: userImageView.rightAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 90, heightConstant: 14)
        
        _ = reviewTimeLabel.anchor(nil, left: nil, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 15, rightConstant: 10, widthConstant: 0, heightConstant: 12)
        
        _ = reviewTextLabel.anchor(ratingbar.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 10, rightConstant: 10, widthConstant: 0, heightConstant: 0)
    }
    
    func getLabelHeight(text: String, font: UIFont) -> CGRect{
        
        return  NSString(string: text).boundingRect(with: CGSize(width: self.frame.width, height: 1000) , options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin) , attributes: [NSFontAttributeName: font], context: nil)
    }

}
