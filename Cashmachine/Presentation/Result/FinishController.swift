//
//  FinishController.swift
//  Cashmachine
//
//  Created by Игорь Огай on 07.01.2020.
//  Copyright © 2020 Игорь Огай. All rights reserved.
//

import UIKit

protocol FinishControllerInput {
    var product: Product! { get set }
    var output: FinishControllerOutput? { get set }
}

protocol FinishControllerOutput {
    func saveProduct()
}

class FinishController: UIViewController, FinishControllerInput {
    var product: Product!
    var output: FinishControllerOutput?
    var cashmachineService: CashmachineService?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var alertLabel: UILabel!
    
    override func viewDidLoad() {
        nameLabel.text = product.name
        descriptionTextView.text = "Номер продукта: \(product.barcode)\nНазвание: \(product.name)\nЕдиница измерения: \(product.unit)\nЦена: \(product.price)\nКоличество: \(product.count)"
    }
    
    @IBAction func save() {
        output?.saveProduct()
    }
}
