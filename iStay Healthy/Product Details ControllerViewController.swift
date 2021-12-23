//
//  Product Details ControllerViewController.swift
//  HealthKit
//
//  Created by admin on 12/6/21.
//

import UIKit
import HealthKit

let healthKitStore: HKHealthStore = HKHealthStore()

class Product_Details_ControllerViewController: UIViewController {

    @IBOutlet weak var passedProductImge: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var poductDescriptionLabel: UILabel!
    @IBOutlet weak var productEnergyLabel: UILabel!
    @IBOutlet weak var productFatLabel: UILabel!
    @IBOutlet weak var productSodiumLabel: UILabel!
    @IBOutlet weak var productSugarLabel: UILabel!
    @IBOutlet weak var ageGrpLabel: UILabel!
    
    @IBOutlet weak var addToCartButton: UIButton!
    @IBAction func addToCartAction(_ sender: Any) {
    }
    
    var selectedProduct: Product? = nil
    let healthDetails = HealthDetails_ViewController.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpProductDetail()
        
        // Do any additional setup after loading the view.
    }
    func setUpProductDetail()
    {
        self.passedProductImge.image = UIImage(named:(selectedProduct?.productImage)!)
        self.productNameLabel.text = selectedProduct?.productName
        self.productNameLabel.frame = CGRect(x: 20, y: 350, width: self.productNameLabel.intrinsicContentSize.width, height: self.productNameLabel.intrinsicContentSize.height)
        self.productPriceLabel.text?.append("\(String(selectedProduct!.productPrice))")
        self.ageGrpLabel.text?.append("\(String(selectedProduct!.startingAge))-\(String(selectedProduct!.endingAge)))")
        self.ageGrpLabel.frame = CGRect(x: 200, y: 380, width: self.ageGrpLabel.intrinsicContentSize.width, height: self.ageGrpLabel.intrinsicContentSize.height)
        self.poductDescriptionLabel.text?.append("\(String((selectedProduct?.productDescription)!))")
        self.poductDescriptionLabel.frame = CGRect(x: 20, y: 410, width: self.poductDescriptionLabel.intrinsicContentSize.width, height: self.poductDescriptionLabel.intrinsicContentSize.height)
        self.productEnergyLabel.text = "\(String(describing: (selectedProduct?.energy)!))"
        self.productFatLabel.text = "\(String(describing: (selectedProduct?.fatContent)!))"
        self.productSugarLabel.text = "\(String(describing: (selectedProduct?.sugarContent)!))"
        self.productSodiumLabel.text = "\(String(describing: (selectedProduct?.sodium)!))"
        
    }
    
    private func dislayAlert(for error : Error){
        let alert = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "O.K.", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
}
