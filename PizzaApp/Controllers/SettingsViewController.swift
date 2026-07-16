//
//  SettingsViewController.swift
//  PizzaApp
//
//  Created by Tanish Aggarwal on 2026-07-14.
//

import UIKit

class SettingsViewController: UIViewController {

    
    // MARK: - Outlets
        @IBOutlet var tbName: UITextField!
        @IBOutlet var tbPhone: UITextField!
        @IBOutlet var tbEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // recall previously entered info from UserDefaults
                let defaults = UserDefaults.standard
                
                if let name = defaults.object(forKey: "lastName") as? String {
                    tbName.text = name
                }
                if let phone = defaults.object(forKey: "lastPhone") as? String {
                    tbPhone.text = phone
                }
                if let email = defaults.object(forKey: "lastEmail") as? String {
                    tbEmail.text = email
                }
    }
    
    // MARK: - Save Settings
        @IBAction func saveSettingsPressed(_ sender: UIButton) {
            let defaults = UserDefaults.standard
            
            defaults.set(tbName.text, forKey: "lastName")
            defaults.set(tbPhone.text, forKey: "lastPhone")
            defaults.set(tbEmail.text, forKey: "lastEmail")
            defaults.synchronize()
            
            let alertController = UIAlertController(title: "Settings", message: "Info Saved", preferredStyle: .alert)
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
