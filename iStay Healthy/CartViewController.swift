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
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


}

extension CartViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return cartProducts.count
        
           
        
    }
    func compare(product:MyCart) -> (mesage:String,result:Bool)
    {
        return ("More sugar Content",false)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CartTableViewCell
       
        cell.cellCartProductPrice.text = "Rs. \(cartProducts[indexPath.row].price)"
        cell.cellCartProductName.text = cartProducts[indexPath.row].productName
        cell.cellCartProductImage.image = UIImage(named:(cartProducts[indexPath.row].productImage))
        let (message,result) = compare(product:cartProducts[indexPath.row])
        if(result)
        {
            cell.recommendedOrNotRecommendedProductImage.image = UIImage(named:"approval")
            cell.layer.cornerRadius = 10
            cell.layer.borderColor = UIColor.green.cgColor
            cell.layer.borderWidth = 2
            
        }
        else{
            cell.recommendedOrNotRecommendedProductImage.image = UIImage(named:"disapproval")
            cell.layer.cornerRadius = 10
            cell.layer.borderColor = UIColor.red.cgColor
            cell.layer.borderWidth = 2
            //toast message on hover 
        }
        return cell
    }
 
    
    
}
