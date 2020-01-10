//
//  InfoProductController.swift
//  Cashmachine
//
//  Created by Игорь Огай on 07.01.2020.
//  Copyright © 2020 Игорь Огай. All rights reserved.
//

import UIKit

protocol InfoProductControllerInput {
    var output: InfoProductControllerOutput? { get set }
}

protocol InfoProductControllerOutput {
    func entered(name: String, unit: String, price: Double, count: Double)
}

class InfoProductController: UIViewController, InfoProductControllerInput {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var unitTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var countTextField: UITextField!
    @IBOutlet weak var alertLabel: UILabel!
    
    var output: InfoProductControllerOutput?
    
    @IBAction func next() {
        if nameTextField.text != "" && unitTextField.text != "" && priceTextField.text != "" && countTextField.text != "" {
            guard let name = nameTextField.text else {
                return
            }
            guard let unit = unitTextField.text else {
                return
            }
            guard let price = Double(priceTextField.text!) else {
                return
            }
            guard let count = Double(countTextField.text!) else {
                return
            }
            
            output?.entered(name: name,
                            unit: unit,
                            price: price,
                            count: count)
        } else {
            alertLabel.text = "Заполните пустые поля!"
        }
    }
    
}
