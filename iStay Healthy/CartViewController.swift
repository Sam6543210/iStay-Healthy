//
//  CartViewController.swift
//  iStay Healthy
//
//  Created by admin on 12/21/21.
//

import UIKit
var cartProducts = [MyCart]()

class CartViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
   

}

extension CartViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return cartProducts.count
        
           
        
    }
    func compare(product:MyCart) -> (message:String,result:Bool)
    {
        let product2 = Product(productName: product.productName, productImage: product.productImage, brand: product.brand, addedFlavour: product.addedFlavour, allergenInformation1: product.allergenInformation1, allergenInformation2: product.allergenInformation2, sugarContent: product.sugarContent, sodium: product.sodium, fatContent: product.fatContent, startingAge: product.startingAge, endingAge: product.endingAge, energy: product.energy, productPrice: product.price, productDescription: product.productName, id: product.id)
        let productDetails = Product_Details_ControllerViewController.init()
        productDetails.getHealthData()
        productDetails.getAllergyYes()
        let (result,message) = productDetails.showResult(product2: product2)
        return(message,result)
    }
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CartTableViewCell
       
        cell.cellCartProductPrice.text = "Rs. \(cartProducts[indexPath.row].price)"
        cell.cellCartProductName.text = cartProducts[indexPath.row].productName
        cell.cellCartProductImage.image = UIImage(named:(cartProducts[indexPath.row].productImage))
        
       let  (message,result) = compare(product:cartProducts[indexPath.row])
        
        if(result == false)
        {
            cell.recommendedOrNotRecommendedProductImage.image = UIImage(named:"approval")
            cell.layer.cornerRadius = 10
            cell.layer.borderColor = UIColor.green.cgColor
            cell.layer.borderWidth = 2
            let hover = CustomTapGestureRecognizer(target: self, action: #selector(self.onTap(sender:)))
            hover.ourCustomValue = message
            cell.informationImage.addGestureRecognizer(hover)
            
        }
        else{
            cell.recommendedOrNotRecommendedProductImage.image = UIImage(named:"disapproval")
            cell.layer.cornerRadius = 10
            cell.layer.borderColor = UIColor.red.cgColor
            cell.layer.borderWidth = 2
            
            
            let hover = CustomTapGestureRecognizer(target: self, action: #selector(self.onTap(sender:)))
            hover.ourCustomValue = message
            cell.informationImage.addGestureRecognizer(hover)
  
            
        }
        return cell
    }
 
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        cartProducts.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.endUpdates()
    }
    @objc
    func onTap(sender:CustomTapGestureRecognizer)
    {
        showToast(controller:self,message:sender.ourCustomValue,seconds:6)
    }
    func showToast(controller:CartViewController, message:String,seconds:Double)
    {
        let alert = UIAlertController(title:nil,message:message,preferredStyle:.alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        controller.present(alert,animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 6)
        {
            alert.dismiss(animated: true)
        }
    }
    
}
class CustomTapGestureRecognizer:UITapGestureRecognizer
{
    var ourCustomValue: String = ""
}
