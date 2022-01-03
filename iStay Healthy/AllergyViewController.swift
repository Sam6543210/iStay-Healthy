//
//  AllergyViewController.swift
//  iStay Healthy
//
//  Created by admin on 12/27/21.
//

import UIKit

class AllergyViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func saveAllergyAction(_ sender: Any) {
        updateAllergyData()
        let alll = manager.fetchAllergy()
        print("after update:\n\(String(describing: alll))")
        self.navigationController?.popViewController(animated: true)
    }
    
    
    private let manager: AllergyManager = AllergyManager()
    let allergyNameArray: [String] = ["Peanut", "Soy", "Gluten", "Cashew", "Milk", "Wheat", "Almond","Hazelnuts","Guava", "Papaya"]
    var selectArr = [String]()
    let allergyStatusArray: [String] = ["Yes", "No", "Yes", "Yes", "No", "No", "No", "No", "No", "No"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //fillData()
       
        self.tableView.isEditing = true
        //self.tableView.allowsSelection = false
        //self.tableView.allowsSelectionDuringEditing = true
        self.tableView.allowsMultipleSelectionDuringEditing = true
    }
    func fillData(){
        for i in 0...(allergyNameArray.count-1) {
        let allergy1 = Allergy(allergyName: allergyNameArray[i], allergyStatus: allergyStatusArray[i], allergyId: UUID())
            manager.createAllergy(allergy: allergy1)
        }
    }
    func updateAllergyData(){
        let allAllergy = manager.fetchAllergy()
        print("before update:\n \(String(describing: allAllergy))")
        let count = selectArr.count
        if(count > 0 ){
            for i in 0...count-1 {
                let countAlgy = (allAllergy?.count)!
                let algy = allAllergy
                for j in 0...countAlgy-1 {
                    
                    if(selectArr[i] == algy![j].allergyName){
                        let updateAllergyYes = Allergy(allergyName: algy![j].allergyName, allergyStatus: "Yes", allergyId: algy![j].allergyId)
                        print("\(String(describing: algy![j].allergyName)) updated to yes")
                        manager.updateAllergy(allergy: updateAllergyYes)
                    }
                    else{
                        var flag = false
                        for k in 0...selectArr.count-1 {
                            if(algy![j].allergyName == selectArr[k]){
                                flag = true
                                break
                            }
                        }
                        if(flag == false){
                            let updateAllergyNo = Allergy(allergyName: algy![j].allergyName, allergyStatus: "No", allergyId: algy![j].allergyId)
                           // print("\(String(describing: algy![j].allergyName)) updated to No")
                            manager.updateAllergy(allergy: updateAllergyNo)
                        }
                    }
                }
            }
        }
        else{
            let countAlgy = (allAllergy?.count)!
            let algy = allAllergy
            for j in 0...countAlgy-1 {
                let updateAllergyNo = Allergy(allergyName: algy![j].allergyName, allergyStatus: "No", allergyId: algy![j].allergyId)
                print("\(String(describing: algy![j].allergyName)) updated to No")
                manager.updateAllergy(allergy: updateAllergyNo)
        }
    }
}
}
extension AllergyViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allergyNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let allergycell = tableView.dequeueReusableCell(withIdentifier: "allergycell", for: indexPath)
        allergycell.textLabel?.text = allergyNameArray[indexPath.row]
        return allergycell
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.selectDeselectCell(tableView: tableView, indexPath: indexPath)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectDeselectCell(tableView: tableView, indexPath: indexPath)
    }
    
}
extension AllergyViewController{
    func selectDeselectCell(tableView: UITableView, indexPath: IndexPath){
        self.selectArr.removeAll()
        if let arr = tableView.indexPathsForSelectedRows{
            for index in arr{
                selectArr.append(allergyNameArray[index.row])
            }
        }
        print(selectArr)
    }
}
