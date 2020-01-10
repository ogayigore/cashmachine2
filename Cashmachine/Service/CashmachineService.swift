//
//  CashmachineService.swift
//  Cashmachine
//
//  Created by Игорь Огай on 07.01.2020.
//  Copyright © 2020 Игорь Огай. All rights reserved.
//

import UIKit

protocol CashmachineService {
    func add(product: Product)
}

class CashmachineServiceImpl: CashmachineService {
    func add(product: Product) {
        print("Добавлено!")
    }
}
