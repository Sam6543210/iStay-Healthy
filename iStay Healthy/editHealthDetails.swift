//
//  editHealthDetails.swift
//  iStay Healthy
//
//  Created by admin on 12/21/21.
//

import UIKit
import  HealthKit

class editHealthDetails: UIViewController {

    @IBOutlet weak var bloodPressureField: UITextField!
    @IBOutlet weak var cholesterolField: UITextField!
    @IBOutlet weak var sugarField: UITextField!
    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var sodiumField: UITextField!
    
    @IBAction func saveHealth(_ sender: Any) {
        writeToKit()
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func writeToKit(){
        let today = NSDate()
        if (bloodPressureField.text != "" ){
            print("inside if loop")
            let bloodPressure = bloodPressureField.text
            if let type = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodPressureSystolic){
                let quantity = HKQuantity(unit: HKUnit.millimeterOfMercury(), doubleValue: Double(bloodPressure!)!)
                let sample = HKQuantitySample(type: type, quantity: quantity, start: today as Date, end: today as Date)
                healthKitStore.save(sample, withCompletion: {(success, error) in
                    print("Saved \(success), error \(String(describing: error))")
                })
            }
        }
        if (cholesterolField.text != "" ){
            let cholesterol = cholesterolField.text
            if let type = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryCholesterol){
                let quantity = HKQuantity(unit: HKUnit.gramUnit(with: .milli), doubleValue: Double(cholesterol!)!)
                let sample = HKQuantitySample(type: type, quantity: quantity, start: today as Date, end: today as Date)
                healthKitStore.save(sample, withCompletion: {(success, error) in
                    print("Saved \(success), error \(String(describing: error))")
                })
            }
        }
        if (sugarField.text != "" ){
            print("inside if loop")
            let sugar = sugarField.text
            if let type = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietarySugar){
                let quantity = HKQuantity(unit: HKUnit.gramUnit(with: .milli), doubleValue: Double(sugar!)!)
                let sample = HKQuantitySample(type: type, quantity: quantity, start: today as Date, end: today as Date)
                healthKitStore.save(sample, withCompletion: {(success, error) in
                    print("Saved \(success), error \(String(describing: error))")
                })
            }
        }
        if (heightField.text != "" ){
            print("inside if loop")
            let height = heightField.text
            if let type = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height){
                let quantity = HKQuantity(unit: HKUnit.foot(), doubleValue: Double(height!)!)
                let sample = HKQuantitySample(type: type, quantity: quantity, start: today as Date, end: today as Date)
                healthKitStore.save(sample, withCompletion: {(success, error) in
                    print("Saved \(success), error \(String(describing: error))")
                })
            }
        }
        if (weightField.text != "" ){
            print("inside if loop")
            let weight = weightField.text
            if let type = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass){
                let quantity = HKQuantity(unit: HKUnit.gramUnit(with: .kilo), doubleValue: Double(weight!)!)
                let sample = HKQuantitySample(type: type, quantity: quantity, start: today as Date, end: today as Date)
                healthKitStore.save(sample, withCompletion: {(success, error) in
                    print("Saved \(success), error \(String(describing: error))")
                })
            }
        }
        if (sodiumField.text != "" ){
            print("inside if loop")
            let sodium = sodiumField.text
            if let type = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietarySodium){
                let quantity = HKQuantity(unit: HKUnit.gramUnit(with: .milli), doubleValue: Double(sodium!)!)
                let sample = HKQuantitySample(type: type, quantity: quantity, start: today as Date, end: today as Date)
                healthKitStore.save(sample, withCompletion: {(success, error) in
                    print("Saved \(success), error \(String(describing: error))")
                })
            }
        }
    }

}
