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

        // Do any additional setup after loading the view.
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
    func compare(product:MyCart) -> (mesage:String,result:Bool)
    {
        let sugar = Int(product.sugarContent)
        
        
            return("High Sugar content",false)
        
    }
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CartTableViewCell
       
        cell.cellCartProductPrice.text = "Rs. \(cartProducts[indexPath.row].price)"
        cell.cellCartProductName.text = cartProducts[indexPath.row].productName
        cell.cellCartProductImage.image = UIImage(named:(cartProducts[indexPath.row].productImage))
        
       let  (message,result) = compare(product:cartProducts[indexPath.row])
        
        if(result)
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
            //toast message on tap
            
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
        showToast(controller:self,message:sender.ourCustomValue,seconds:2)
    }
    func showToast(controller:CartViewController, message:String,seconds:Double)
    {
        let alert = UIAlertController(title:nil,message:message,preferredStyle:.alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        controller.present(alert,animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2)
        {
            alert.dismiss(animated: true)
        }
    }
    
}
class CustomTapGestureRecognizer:UITapGestureRecognizer
{
    var ourCustomValue: String = ""
}
