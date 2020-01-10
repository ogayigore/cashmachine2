//
//  BarcodeController.swift
//  Cashmachine
//
//  Created by Игорь Огай on 07.01.2020.
//  Copyright © 2020 Игорь Огай. All rights reserved.
//

import UIKit

protocol BarcodeControllerInput {
    var output: BarcodeControllerOutput? { get set }
}

protocol BarcodeControllerOutput {
    func input(barcode: Int)
}

class BarcodeController: UIViewController, BarcodeControllerInput {
    var output: BarcodeControllerOutput?
    
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var barcodeTextField: UITextField!
    
    @IBAction func next() {
        if barcodeTextField.text != "" {
            guard let barcode = Int(barcodeTextField.text!) else {
                return
            }
            
            output?.input(barcode: barcode)
        } else {
            alertLabel.text = "Введите номер"
        }
    }
}
