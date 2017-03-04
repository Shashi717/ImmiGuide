//
//  Tour Cell.swift
//  ImmiGuide
//
//  Created by Annie Tung on 2/18/17.
//  Copyright © 2017 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import Foundation
import UIKit

class TourCell: BaseCell {
    
    static let identifier = "PageTourID"
    
    let imageView: UIImageView = {
        let image = UIImage(named: "Tourpage1")
        let im = UIImageView(image: image)
        im.translatesAutoresizingMaskIntoConstraints = false
        im.alpha = 0.9
        im.contentMode = .scaleAspectFill
        im.clipsToBounds = true
        return im
    }()
    
    let textView: UITextView = {
        let view = UITextView()
        view.text = "This is a textview"
        view.isSelectable = false
        view.isEditable = false
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var tour: Tour? {
        didSet {
            guard let tourData = tour else { return }
            setup(tour: tourData)
        }
    }
    
    override func setupCell() {
        super.setupCell()
        
        addSubview(imageView)
        addSubview(textView)
        let _ = [
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.rightAnchor.constraint(equalTo: rightAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            textView.leftAnchor.constraint(equalTo: leftAnchor),
            textView.rightAnchor.constraint(equalTo: rightAnchor),
            textView.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ].map {$0.isActive = true}
    }
    
    private func setup(tour: Tour) {
        imageView.image = tour.image
        
        if let boldFont = UIFont(name: "Montserrat-Medium", size: 41), let regularFont = UIFont(name: "Montserrat-Light", size: 21) {
            
            let shadow = NSShadow()
            shadow.shadowColor = UIColor.darkGray
            shadow.shadowOffset = CGSize(width: 1, height: 1)
            shadow.shadowBlurRadius = 8
            
            let attributedString = NSMutableAttributedString(string: tour.title, attributes: [NSForegroundColorAttributeName:UIColor.white, NSFontAttributeName:boldFont,NSShadowAttributeName:shadow])
            let descriptionString = NSMutableAttributedString(string: "\n\n" + tour.description, attributes: [NSForegroundColorAttributeName:UIColor.white, NSFontAttributeName:regularFont, NSShadowAttributeName:shadow])
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let titleLength = attributedString.string.characters.count
            let descriptionLength = descriptionString.string.characters.count
            let titleRange = NSRange(location: 0, length: titleLength)
            let descriptionRange = NSRange(location: 0, length: descriptionLength)
            
            attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: titleRange)
            descriptionString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: descriptionRange)
            attributedString.append(descriptionString)
            textView.attributedText = attributedString
        } else {
            print("Fonts were not found")
        }
    }
}
