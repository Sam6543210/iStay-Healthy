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
       // print(self.products![indexpath1.row].productName)
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
       // print(cartProducts?[0].brand)
        cartProducts.append(t)
        showToast(controller:self,message:"Product added to cart",seconds:2)
      /*  let cart = self.storyboard?.instantiateViewController(withIdentifier:"cartId") as! CartViewController
        self.navigationController?.pushViewController(cart,animated: true)*/
    }
    func showToast(controller:ProductViewController, message:String,seconds:Double)
    {
        let alert = UIAlertController(title:nil,message:message,preferredStyle:.alert)
        alert.view.backgroundColor = UIColor.gray
        alert.view.alpha = 0.6
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.white
      //  alert.view.tintColor = UIColor.gray
        alert.view.layer.cornerRadius = 15
        controller.present(alert,animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2)
        {
            alert.dismiss(animated: true)
        }
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

