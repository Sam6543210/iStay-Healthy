//
//  HealthDetails_ViewController.swift
//  iStay Healthy
//
//  Created by admin on 12/14/21.
//

import UIKit
import HealthKit

class HealthDetails_ViewController: UIViewController {

    @IBOutlet weak var authorizeHealthDetails: UIButton!
    @IBAction func authorizeHealthDetails(_ sender: Any) {
        self.authorizeHealthKit()
    }
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var cholesterolLabel: UILabel!
    @IBOutlet weak var bloodPressureLabel: UILabel!
    @IBOutlet weak var diabetesLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var sodiumLabel: UILabel!
    
    var bmiHeight = 0.0
    var bmiWeight = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayDateOfBirth()
        displayAgeGender()
        displayHealthData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        displayDateOfBirth()
        displayAgeGender()
        displayHealthData()
    }
    func readDateOfBirth() -> DateComponents?
    {
        var birthDay: DateComponents?
        
        do {
             birthDay = try healthKitStore.dateOfBirthComponents()
            
        }
        catch { }
        return birthDay
    }
    func displayDateOfBirth()
    {
        let birthDay = readDateOfBirth()
       
        
        dateOfBirthLabel.text = String("\(birthDay!.day!)-\(birthDay!.month!)-\(birthDay!.year!)")
        
    }
    func authorizeHealthKit(){
        
        let healthkitTypesToRead : Set<HKObjectType> = [
            HKObjectType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.dateOfBirth)!,
            HKObjectType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.bloodType)!,
            HKObjectType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.biologicalSex)!,
            
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodPressureSystolic)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMassIndex)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryCholesterol)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietarySugar)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietarySodium)!
        ]
        let healthKitTypesToWrite : Set<HKSampleType> = [
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodPressureSystolic)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMassIndex)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryCholesterol)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietarySugar)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietarySodium)!
        ]
        
        if !HKHealthStore.isHealthDataAvailable(){
            print("ERROR OCCURRED")
            return
        }
        
        healthKitStore.requestAuthorization(toShare: healthKitTypesToWrite, read: healthkitTypesToRead, completion: { (success, error) -> Void in
            print("Read Write Authorization succeeded!")
        })
    }
    func readCharacteristicHealthData() -> (age:Int?,gender:String?){
        var age : Int?
        var gender : String?
        
        do{
            let birthDay = try healthKitStore.dateOfBirthComponents()
            let biologicalSexObject = try healthKitStore.biologicalSex()
            let calender = Calendar.current
            let currentYear = calender.component(.year, from: Date())
            age = currentYear - birthDay.year!
            let biologicalSex = biologicalSexObject.biologicalSex
            switch biologicalSex.rawValue {
            case 0:
                gender = nil
            case 1:
                gender = "Female"
            case 2:
                gender = "Male"
            case 3:
                gender = "Other"
            default:
                gender = nil
            }
        }
        catch{}
        
        return (age,gender)
    }
    func displayAgeGender(){
        let age = self.readCharacteristicHealthData().age
        let gender = self.readCharacteristicHealthData().gender
        dateOfBirthLabel.text?.append(" (\(age!))")
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
        
        guard let bloodPressureSampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodPressureSystolic) else{
        print("Systolic Blood Pressure sample is no longer available in healthkit")
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
        guard let cholesterolSampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryCholesterol) else{
        print("Cholesterol sample is no longer available in healthkit")
        return
        }
        guard let sugarSampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietarySugar) else{
        print("Sugar sample is no longer available in healthkit")
        return
        }
        guard let sodiumSampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietarySodium) else{
        print("Sodium sample is no longer available in healthkit")
        return
        }
        readSampleHealthData(for: bloodPressureSampleType){
            (sample, error) in
            guard let sample = sample else {
                if let error = error {
                    self.dislayAlert(for: error)
                }
                return
            }
            self.bloodPressureLabel.text = String(sample.quantity.doubleValue(for: HKUnit(from: "mmHg")))
            self.bloodPressureLabel.text?.append(" mmHg")
        }
        readSampleHealthData(for: weightSampleType){
            (sample, error) in
            guard let sample = sample else {
                if let error = error {
                    self.dislayAlert(for: error)
                }
                return
            }
            self.weightLabel.text = String(format: "%.2f",sample.quantity.doubleValue(for: HKUnit(from: "kg")))
            self.weightLabel.text?.append(" kg")
            self.bmiWeight = sample.quantity.doubleValue(for: HKUnit(from: "kg"))
            if(self.bmiHeight != 0){
                self.displayBMI()
            }
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
            self.bmiHeight = sample.quantity.doubleValue(for: HKUnit(from: "ft"))
            if(self.bmiWeight != 0){
                self.displayBMI()
            }
           
        }
        readSampleHealthData(for: cholesterolSampleType){
            (sample, error) in
            guard let sample = sample else {
                if let error = error {
                    self.dislayAlert(for: error)
                }
                return
            }
            self.cholesterolLabel.text = String(sample.quantity.doubleValue(for: HKUnit(from: "mg")))
            self.cholesterolLabel.text?.append(" mg/dL")
        }
        readSampleHealthData(for: sugarSampleType){
            (sample, error) in
            guard let sample = sample else {
                if let error = error {
                    self.dislayAlert(for: error)
                }
                return
            }
            self.diabetesLabel.text = String(sample.quantity.doubleValue(for: HKUnit(from: "mg")))
            self.diabetesLabel.text?.append(" mg/dL")
        }
        readSampleHealthData(for: sodiumSampleType){
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
    func displayBMI(){
        self.bmiHeight = self.bmiHeight * 0.3048
        self.bmiHeight = self.bmiHeight * self.bmiHeight
        let bmi = bmiWeight/bmiHeight
        bmiLabel.text = String(format: "%.2f", bmi)
        bmiLabel.text?.append(" kg/m2")
    }
    private func dislayAlert(for error : Error){
        let alert = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "O.K.", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
