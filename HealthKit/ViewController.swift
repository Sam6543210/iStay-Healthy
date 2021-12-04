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
    }
   
    
    
    
    
    
    
    
    
    
    
    
}

