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
        
        // required by UITableViewDataSource - number of cells
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return mainDelegate.orders.count
        }
        
        // required by UITableViewDataSource - what goes in each cell
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell") ?? UITableViewCell()
            return cell
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
