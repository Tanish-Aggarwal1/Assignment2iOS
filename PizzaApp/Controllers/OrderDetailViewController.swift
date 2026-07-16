//
//  OrderDetailViewController.swift
//  PizzaApp
//
//  Created by Tanish Aggarwal on 2026-07-14.
//

import UIKit

// screen showing full details of one order - populated from AppDelegate.selectedOrder

class OrderDetailViewController: UIViewController {

    
    // MARK: - Outlets
    @IBOutlet var avatarImageView: UIImageView!
        @IBOutlet var lblDeliveryDate: UILabel!
        @IBOutlet var lblAddress: UILabel!
        @IBOutlet var lblSize: UILabel!
        @IBOutlet var lblMeatToppings: UILabel!
        @IBOutlet var lblVegToppings: UILabel!
        @IBOutlet var lblAvatar: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // grab the order the user tapped from AppDelegate
                let mainDelegate = UIApplication.shared.delegate as! AppDelegate
                
                guard let order = mainDelegate.selectedOrder else { return }
                
                // convert size int back into a readable label
                var sizeText = "Unknown"
                if order.size == 0 { sizeText = "Small" }
                if order.size == 1 { sizeText = "Medium" }
                if order.size == 2 { sizeText = "Large" }
                
                // set text on each label
                lblDeliveryDate.text = "Delivery: \(order.deliveryDate ?? "")"
                lblAddress.text = "Address: \(order.address ?? "")"
                lblSize.text = "Size: \(sizeText)"
                lblMeatToppings.text = "Meats: \(order.meatToppings ?? "")"
                lblVegToppings.text = "Veggies: \(order.vegToppings ?? "")"
                lblAvatar.text = "Avatar: \(order.avatar ?? "")"
                
                // load the avatar image
                avatarImageView.image = UIImage(named: order.avatar ?? "")
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
