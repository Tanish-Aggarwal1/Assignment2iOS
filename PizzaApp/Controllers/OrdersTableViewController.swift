//
//  OrdersTableTableViewController.swift
//  PizzaApp
//
//  Created by Tanish Aggarwal on 2026-07-14.
//

import UIKit

class OrdersTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // grab AppDelegate for db access
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // table view outlet - connect in storyboard
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainDelegate.readDataFromDatabase()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // refresh again every time screen appears (in case new order was just saved)
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            mainDelegate.readDataFromDatabase()
            tableView.reloadData()
        }
        
        // MARK: - Table Methods (stubs for now - filled in Step 7)
    
    // how many cells to display
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return mainDelegate.orders.count
        }
        
        // height of each cell
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 90
        }
    // what goes in each cell
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            // dequeue custom cell (from prototype in storyboard) with fallback for safety
            let tableCell = tableView.dequeueReusableCell(withIdentifier: "orderCell") as? OrderCell
                ?? OrderCell(style: .default, reuseIdentifier: "orderCell")
            
            let rowNum = indexPath.row
            let order = mainDelegate.orders[rowNum]
            
            // convert size int to text for display
            var sizeText = "Unknown"
            if order.size == 0 { sizeText = "Small" }
            if order.size == 1 { sizeText = "Medium" }
            if order.size == 2 { sizeText = "Large" }
            
            // fill cell contents
            tableCell.primaryLabel.text = "\(sizeText) - \(order.deliveryDate ?? "")"
            tableCell.secondaryLabel.text = "\(order.address ?? "")"
            tableCell.avatarImageView.image = UIImage(named: order.avatar ?? "")
            
            tableCell.accessoryType = .disclosureIndicator
            
            return tableCell
        }
        
        // handle tap on a cell - save selection to AppDelegate, then segue to detail
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let rowNum = indexPath.row
            
            // save which order was tapped, so OrderDetailViewController can read it
            mainDelegate.selectedOrder = mainDelegate.orders[rowNum]
            
            // trigger the named segue from storyboard
            performSegue(withIdentifier: "orderCellToDetail", sender: nil)
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
