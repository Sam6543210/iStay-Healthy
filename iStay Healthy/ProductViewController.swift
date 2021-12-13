//
//  ViewController.swift
//  HealthKit
//
//  Created by admin on 12/1/21.
//

import UIKit

class ProductViewController: UIViewController {
    

    @IBOutlet weak var tableView: UITableView!
    
    var products:[Product]?
    private let manager: ProductManager = ProductManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //fillData()
    }
    func fillData()
    {
        let product1 = Product(productName: "Aloo Bhujia (175g)", productImage: "image3", brand: "Haldiram's", addedFlavour: "natural flavour", allergenInformation1: "Peanut", allergenInformation2: "Cashew", sugarContent: 0.25, sodium: 615.0, fatContent: 38.12, startingAge: 15, endingAge: 50, energy: 569, productPrice: 40, productDescription: "Its a spicy mint flavoured, extruded Potato snack for all ages", id: UUID())
        manager.createProduct(product: product1)
       
    }
    override func viewWillAppear(_ animated: Bool)
    {
        products = manager.fetchProduct()
        if( products != nil && products?.count != 0)
        {
            self.tableView.reloadData()
        }
    }
    
}
extension ProductViewController: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewProductTableViewCell
        let product = self.products![indexPath.row]
        cell.cellProductName.text = product.productName
        cell.cellProductImage.image = UIImage(named: product.productImage!)
        cell.cellProductPrice.text = "Rs. \(product.productPrice)"
      
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 2
 
        return cell
    }
   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = products![indexPath.row]
        let sheet = UIAlertController(title: "Delete",
                                      message: nil,
                                      preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title:"Cancel",
                                      style:.cancel,
                                      handler:nil))
        sheet.addAction(UIAlertAction(title:"Delete",
                                      style:.destructive,
                                      handler:{ [weak self] _ in
                                        self!.manager.deleteProduct(id:product.id)
                                      }))
    }
    
    
    
    
    
    
    
    
    
}

