//
//  OrderViewController.swift
//  PizzaApp
//
//  Created by Tanish Aggarwal on 2026-07-14.
//

import UIKit

class OrderViewController: UIViewController {

    
    // MARK: - Outlets
        @IBOutlet var datePicker: UIDatePicker!
        @IBOutlet var tbAddress: UITextField!
        @IBOutlet var sizeSegment: UISegmentedControl!
        
        @IBOutlet var swPepperoni: UISwitch!
        @IBOutlet var swBacon: UISwitch!
        @IBOutlet var swChicken: UISwitch!
        
        @IBOutlet var swMushroom: UISwitch!
        @IBOutlet var swOnion: UISwitch!
        @IBOutlet var swPeppers: UISwitch!
        
        // keeps track of which avatar the user picked - default to avatar1
        var selectedAvatar: String = "avatar1"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Avatar Buttons
        @IBAction func avatar1Pressed(_ sender: UIButton) {
            selectedAvatar = "avatar1"
            showAvatarChosenAlert(name: "Avatar 1")
        }
        
        @IBAction func avatar2Pressed(_ sender: UIButton) {
            selectedAvatar = "avatar2"
            showAvatarChosenAlert(name: "Avatar 2")
        }
        
        @IBAction func avatar3Pressed(_ sender: UIButton) {
            selectedAvatar = "avatar3"
            showAvatarChosenAlert(name: "Avatar 3")
        }
        
        func showAvatarChosenAlert(name: String) {
            let alertController = UIAlertController(title: "Avatar Selected", message: name, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true)
        }

    
    // MARK: - Save Order
        @IBAction func saveOrderPressed(_ sender: UIButton) {
            
            // format the date picker's Date into a String for the DB
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            let deliveryDateString = formatter.string(from: datePicker.date)
            
            let addressText = tbAddress.text ?? ""
            
            // segmented control index: 0 = Small, 1 = Medium, 2 = Large
            let sizeValue = sizeSegment.selectedSegmentIndex
            
            // build meat toppings string - join only the ones that are ON
            var meats: [String] = []
            if swPepperoni.isOn { meats.append("Pepperoni") }
            if swBacon.isOn { meats.append("Bacon") }
            if swChicken.isOn { meats.append("Chicken") }
            let meatToppingsString = meats.joined(separator: ", ")
            
            // build veg toppings string
            var vegs: [String] = []
            if swMushroom.isOn { vegs.append("Mushroom") }
            if swOnion.isOn { vegs.append("Onion") }
            if swPeppers.isOn { vegs.append("Peppers") }
            let vegToppingsString = vegs.joined(separator: ", ")
            
            // build the Order object
            let newOrder = Order()
            newOrder.initWithData(theRow: 0,
                                   theDeliveryDate: deliveryDateString,
                                   theAddress: addressText,
                                   theSize: sizeValue,
                                   theMeatToppings: meatToppingsString,
                                   theVegToppings: vegToppingsString,
                                   theAvatar: selectedAvatar)
            
            // insert into database via AppDelegate
            let mainDelegate = UIApplication.shared.delegate as! AppDelegate
            let returnCode = mainDelegate.insertIntoDatabase(order: newOrder)
            
            var returnMSG = "Order Saved!"
            if returnCode == false {
                returnMSG = "Order Failed to Save"
            }
            
            let alertController = UIAlertController(title: "Save Order", message: returnMSG, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true)
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
