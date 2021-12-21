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

    @IBOutlet weak var passedProductImge: UIImageView!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var sodiumLabel: UILabel!
    
    var selectedProduct: Product? = nil
    let healthDetails = HealthDetails_ViewController.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpProductDetail()
        displayHealthData()
        
        // Do any additional setup after loading the view.
    }
    func setUpProductDetail()
    {
        self.passedProductImge.image = UIImage(named:(selectedProduct?.productImage)!)
        
    }
    
    
    func displayHealthData(){
        
        guard let weightSampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass) else{
        print("Weight sample is no longer available in healthkit")
        return
        }
        guard let heightSampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height) else{
        print("Height sample is no longer available in healthkit")
        return
        }
        guard let sodiumSampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietarySodium) else{
        print("Sodium sample is no longer available in healthkit")
        return
        }
        healthDetails.readSampleHealthData(for: weightSampleType){
            (sample, error) in
            guard let sample = sample else {
                if let error = error {
                    self.dislayAlert(for: error)
                }
                return
            }
            self.weightLabel.text = String(sample.quantity.doubleValue(for: HKUnit(from: "kg")))
            self.weightLabel.text?.append(" kg")
        }
        healthDetails.readSampleHealthData(for: heightSampleType){
            (sample, error) in
            guard let sample = sample else {
                if let error = error {
                    self.dislayAlert(for: error)
                }
                return
            }
            self.heightLabel.text = String(sample.quantity.doubleValue(for: HKUnit(from: "ft")))
            self.heightLabel.text?.append(" ft")
        }
        healthDetails.readSampleHealthData(for: sodiumSampleType){
            (sample, error) in
            guard let sample = sample else {
                if let error = error {
                    self.dislayAlert(for: error)
                }
                return
            }
            self.sodiumLabel.text = String(sample.quantity.doubleValue(for: HKUnit(from: "mg")))
            self.sodiumLabel.text?.append(" mg/dL")
        }
    }
    private func dislayAlert(for error : Error){
        let alert = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "O.K.", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
}
