//
//  ViewController.swift
//  HealthKit
//
//  Created by admin on 12/1/21.
//

import UIKit

class ViewController: UIViewController {
    var productList = [Product]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fillData()
    }
    func fillData()
    {
        let product1 = Product(pName:"Cream Fantasy (30 g)",pImage:"image1",pPrice:"Rs. 40")
        productList.append(product1)
        
        let product2 = Product(pName:"Cream Fantasy(50g)",pImage:"image1",pPrice:"Rs. 60")
        productList.append(product2)
        
        let product3 = Product(pName:"Cream Fantasy(50g)",pImage:"image1",pPrice:"Rs. 60")
        productList.append(product3)
        let product4 = Product(pName:"Cream Fantasy(50g)",pImage:"image1",pPrice:"Rs. 60")
        productList.append(product4)
    }
    
}
extension ViewController: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewProductTableViewCell
        cell.cellProductImage.image = UIImage(named: productList[indexPath.row].productImage)
        cell.cellProductName.text = productList[indexPath.row].productName
        cell.cellProductPrice.text = productList[indexPath.row].price
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 2
        return cell
    }
   
    
    
    
    
    
    
    
    
    
    
    
}

