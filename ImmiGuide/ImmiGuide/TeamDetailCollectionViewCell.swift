//
//  TeamDetailCollectionViewCell.swift
//
//
//  Created by Madushani Lekam Wasam Liyanage on 2/20/17.
//
//

import UIKit

class TeamDetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        nameLabel.font = UIFont(name: "Montserrat-Medium", size: 17)
        nameLabel.textColor = UIColor.darkGray
        titleLabel.font = UIFont(name: "Montserrat-Light", size: 17)
        titleLabel.textColor = UIColor.darkGray
    }

    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    

}
