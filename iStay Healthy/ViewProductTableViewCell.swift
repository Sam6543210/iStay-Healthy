//
//  ViewProductTableViewCell.swift
//  HealthKit
//
//  Created by admin on 12/2/21.
//

import UIKit

class ViewProductTableViewCell: UITableViewCell {
    @IBOutlet weak var cellProductPrice: UILabel!
    
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var cellProductName: UILabel!
    @IBOutlet weak var cellProductImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
