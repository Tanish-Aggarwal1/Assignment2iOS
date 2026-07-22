//
//  ViewController.swift
//  PizzaApp
//
//  Created by Tanish Aggarwal on 2026-07-14.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.titleTextAttributes = [
                .foregroundColor: UIColor.white,
                    .font: UIFont.systemFont(ofSize: 24, weight: .bold)
            ]
    }


}

