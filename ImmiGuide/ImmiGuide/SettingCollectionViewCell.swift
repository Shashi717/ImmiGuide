//
//  SettingCollectionViewCell.swift
//  ImmiGuide
//
//  Created by Annie Tung on 2/19/17.
//  Copyright © 2017 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import UIKit
import SnapKit

class SettingCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "Flag Cell"
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(flagImage)
        setupConstraints()
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeLanguage(sender:)))
//        flagImage.isUserInteractionEnabled = true
//        flagImage.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        flagImage.snp.makeConstraints { (image) in
            image.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    func changeLanguage(sender: Any) {
        print("language selection tapped")
        
        
    }
    
    lazy var flagImage: UIImageView  = {
        let image : UIImageView = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    
}
