//
//  CartTableViewCell.swift
//  iStay Healthy
//
//  Created by admin on 12/21/21.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var informationImage: UIImageView!
    {
        didSet
        {
            informationImage.isUserInteractionEnabled = true
        }
    }
    @IBOutlet weak var recommendedOrNotRecommendedProductImage: UIImageView!
    
    @IBOutlet weak var cellCartProductPrice: UILabel!
    @IBOutlet weak var cellCartProductName: UILabel!
    @IBOutlet weak var cellCartProductImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
