//
//  ViewController.swift
//  HealthKit
//
//  Created by admin on 12/1/21.
//

import UIKit

class ProductViewController: UIViewController {
    
    var cartItem:Product? = nil
    @IBOutlet weak var tableView: UITableView!
    
   
    var products:[Product]? = nil
    private let manager: ProductManager = ProductManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
      // fillData()
    }
    func fillData()
    {
        let product1 = Product(productName: "Haldiram's Soan Papdi (1kg)", productImage: "product17", brand: "Haldiram's", addedFlavour: "No", allergenInformation1: "Wheat", allergenInformation2:"Almond", sugarContent: 46.06, sodium:8, fatContent: 23.06, startingAge: 15, endingAge: 65, energy: 490, productPrice: 230, productDescription: "Soan Papdi is a crispy flaky and met-in-your-mouth confection that experiences blissful journey with each bite", id: UUID())
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
        cell.addToCartButton.tag = indexPath.row
        cell.addToCartButton.addTarget(self, action: #selector(addToButton(sender:)), for: .touchUpInside)
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = UIColor.purple.cgColor
        cell.layer.borderWidth = 2
 
        return cell
    }
   
    @objc func addToButton(sender:UIButton)
    {
        let indexpath1 = IndexPath(row:sender.tag,section:0)
       
       cartItem = self.products![indexpath1.row]
        let cartImage:String = cartItem!.productImage ?? ""
       let cartName:String = cartItem!.productName ?? ""
        let cartPrice:Int64 = cartItem!.productPrice
        let cartFatContent:NSDecimalNumber = cartItem!.fatContent ?? 0.0
        let cartSugarContent:NSDecimalNumber = cartItem!.sugarContent ?? 0.0
        let cartSodium:NSDecimalNumber = cartItem!.sodium ?? 0.0
        let cartAllergnInformation1:String = cartItem!.allergenInformation1 ?? ""
        let cartAllergnInformation2:String = cartItem!.allergenInformation2 ?? ""
        let cartBrand:String = cartItem!.brand ?? ""
        let cartAddedFlavour:String = cartItem!.addedFlavour ?? ""
        let cartEnergy:Int64 = cartItem!.energy
        let cartStartingAge:Int64 = cartItem!.startingAge
        let cartEndingAge:Int64 = cartItem!.endingAge
        
        let id:UUID = cartItem!.id
        let t = MyCart(pName: cartName, pImage: cartImage, pBrand: cartBrand, pAddedFlavour: cartAddedFlavour, pAllergenInformation1: cartAllergnInformation1, pAllergenInformation2: cartAllergnInformation2, pSugarContent: cartSugarContent, pSodium: cartSodium, pFatContent: cartFatContent, pPrice: cartPrice, pStartingAge: cartStartingAge, pEndingAge: cartEndingAge, pEnergy: cartEnergy, id1: id)
       
        cartProducts.append(t)
        showToast(controller:self,message:"Product added to cart",seconds:2)
        
      
    }
    func showToast(controller:UIViewController, message:String,seconds:Double)
    {
        let alert = UIAlertController(title:nil,message:message,preferredStyle:.alert)
        alert.view.backgroundColor = UIColor.gray
        alert.view.alpha = 0.6
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.green
      
        alert.view.layer.cornerRadius = 15
        controller.present(alert,animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2)
        {
            alert.dismiss(animated: true)
        }
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

