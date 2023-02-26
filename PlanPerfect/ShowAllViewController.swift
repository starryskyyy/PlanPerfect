//
//  ShowAllViewController.swift
//  PlanPerfect
//
//  Created by Danesh Zhao-Graham on 2023-02-26.
//

import UIKit

class ShowAllViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set a custom color with separate red, green, blue, and alpha values
            let customColor = UIColor(red: 27/255, green: 209/255, blue: 161/255, alpha: 1)

            // Set the title color to the custom color
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: customColor]

            // Set the back button color to the custom color
            navigationController?.navigationBar.tintColor = customColor
        }
}
