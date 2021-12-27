//
//  AllergyViewController.swift
//  iStay Healthy
//
//  Created by admin on 12/27/21.
//

import UIKit

class AllergyViewController: UIViewController {
    private let manager: AllergyManager = AllergyManager()
    let allergyNameArray: [String] = ["Soy", "Gluten", "Cashew", "Milk", "Wheat", "Almond","Hazelnuts","Guava", "Papaya", "Peanut"]
    let allergyStatusArray: [String] = ["No", "Yes", "Yes", "No", "No", "No", "No", "No", "No", "Yes"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //fillData()
    }
    func fillData(){
        for i in 0...(allergyNameArray.count-1) {
        let allergy1 = Allergy(allergyName: allergyNameArray[i], allergyStatus: allergyStatusArray[i], allergyId: UUID())
            manager.createAllergy(allergy: allergy1)
        }
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
