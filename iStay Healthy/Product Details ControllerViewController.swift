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

    @IBOutlet weak var heartRateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func readHealthData() -> (age : Int?, bpm : Int?){
        var age : Int?
        var bpm : Int?
        
        //read age
        do{
            let birthDay = try healthKitStore.dateOfBirthComponents()
            let calender = Calendar.current
            let currentYear = calender.component(.year, from: Date())
            age = currentYear - birthDay.year!
        }
        catch{}
        
        //read bpm
        do{
            
        }
        return (age, bpm)
    }
    
    
    
}
