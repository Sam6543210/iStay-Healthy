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
    @IBOutlet weak var heartRateLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    
    var selectedProduct: Product? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpProductDetail()
        displayHealthData()
        displayAgeGender()
        // Do any additional setup after loading the view.
    }
    func setUpProductDetail()
    {
        self.passedProductImge.image = UIImage(named:(selectedProduct?.productImage)!)
        
    }
    
    func readCharacteristicHealthData() -> (age:Int?,gender:HKBiologicalSex?){
        var age : Int?
        var gender : HKBiologicalSex?
        //read age
        do{
            let birthDay = try healthKitStore.dateOfBirthComponents()
            let biologicalSex = try healthKitStore.biologicalSex()
            let calender = Calendar.current
            let currentYear = calender.component(.year, from: Date())
            age = currentYear - birthDay.year!
            gender = biologicalSex.biologicalSex
        }
        catch{}
        
        return (age,gender)
    }
    func displayAgeGender(){
        let (age,gender) = self.readCharacteristicHealthData()
        ageLabel.text = "\(age!) years"
        genderLabel.text = "\(gender!)"
    }
    func readSampleHealthData(for sampleType : HKSampleType, completion : @escaping (HKQuantitySample?, Error?) -> Swift.Void){
        
        let mostRecentPredicate = HKQuery.predicateForSamples(withStart: Date.distantPast, end: Date(), options: .strictEndDate)
        let sortDiscriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let limit = 1
        
        let sampleQuery = HKSampleQuery(sampleType: sampleType, predicate: mostRecentPredicate, limit: limit, sortDescriptors: [sortDiscriptor]){
            (query, samples, error) in
            DispatchQueue.main.async {
                guard let samples = samples,
                      let mostRecentSample = samples.first as? HKQuantitySample else{
                        completion(nil,error)
                        return
                }
                completion(mostRecentSample,nil)
            }
        }
        HKHealthStore().execute(sampleQuery)
    }
    
    func displayHealthData(){
        guard let heartRateSampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate) else{
        print("Heart rate sample is no longer available in healthkit")
        return
        }
        guard let weightSampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass) else{
        print("Weight sample is no longer available in healthkit")
        return
        }
        guard let heightSampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height) else{
        print("Height sample is no longer available in healthkit")
        return
        }
        readSampleHealthData(for: heartRateSampleType){
            (sample, error) in
            guard let sample = sample else {
                if let error = error {
                    self.dislayAlert(for: error)
                }
                return
            }
            self.heartRateLabel.text = String(sample.quantity.doubleValue(for: HKUnit(from: "count/min")))
            self.heartRateLabel.text?.append(" count/min")
        }
        readSampleHealthData(for: weightSampleType){
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
        readSampleHealthData(for: heightSampleType){
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
        
    }
    private func dislayAlert(for error : Error){
        let alert = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "O.K.", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
}
