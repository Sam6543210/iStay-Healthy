//
//  ViewController.swift
//  HealthKit
//
//  Created by admin on 12/1/21.
//

import UIKit

class ProductViewController: UIViewController {
    

    @IBOutlet weak var tableView: UITableView!
    
    var products:[Product]? = nil
    private let manager: ProductManager = ProductManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       // fillData()
    }
    func fillData()
    {
        let product1 = Product(productName: "Ferrero Rocher (300g)", productImage: "product4", brand: "Ferrero", addedFlavour: "Vanillin", allergenInformation1: "Hazelnuts", allergenInformation2: "Gluten", sugarContent: 39.9, sodium: 8, fatContent: 42.7, startingAge: 10, endingAge: 40, energy: 595, productPrice: 845, productDescription: "Ferrero Rocher is a chocolate made of whole roasted hazelnut encased in a thin wafer shell filled with cream", id: UUID())
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
        cell.layer.borderColor = UIColor.purple.cgColor
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
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue,sender:Any?)
    {
        if(segue.identifier == "navigateToProductDetail")
        {
            let productDetail = segue.destination as?
                Product_Details_ControllerViewController
            guard productDetail != nil else { return }
            productDetail?.selectedProduct =
                self.products![self.tableView.indexPathForSelectedRow!.row]
        }
    }
    
    
    
}

