//
//  Coordinator.swift
//  Cashmachine
//
//  Created by Игорь Огай on 07.01.2020.
//  Copyright © 2020 Игорь Огай. All rights reserved.
//

import UIKit

class ServiceAssembly {
    var cashmachineService: CashmachineService {
        return CashmachineServiceImpl()
    }
}

class CoordinatorAssembly {
    private let serviceAssembly = ServiceAssembly()
    
    var coordinator: Coordinator {
        let coordinator = Coordinator()
        coordinator.cashmachineService = serviceAssembly.cashmachineService
        return coordinator
    }
}

class Coordinator {
    var window: UIWindow?
    var cashmachineService: CashmachineService?
    
    var barcodeVC: BarcodeController?
    var infoProductVC: InfoProductController?
    var finishVC: FinishController?
    var barcode = 0
    var product: Product!
    var store = [Product]()
    
    func start() {
        let barcodeVC = vc("BarcodeController") as! BarcodeController
        barcodeVC.output = self
        window?.rootViewController = barcodeVC
        self.barcodeVC = barcodeVC
    }
}

extension Coordinator: BarcodeControllerOutput {
    func input(barcode: Int) {
        self.barcode = barcode
        let infoVC = vc("InfoProductController") as! InfoProductController
        infoVC.output = self
        barcodeVC?.present(infoVC, animated: true, completion: nil)
        self.infoProductVC = infoVC
    }
}

extension Coordinator: InfoProductControllerOutput {
    
    func entered(name: String, unit: String, price: Double, count: Double) {
        let qrImage = generateQRCode(from: "\(barcode)\n\(name)\n\(unit)\n\(price)\n\(count)")
        let product = Product(barcode: barcode,
                              name: name,
                              unit: unit,
                              price: price,
                              count: count,
                              qr: qrImage!)
        
        self.product = product
        let finishVC = vc("FinishController") as! FinishController
        finishVC.cashmachineService = cashmachineService
        finishVC.product = product
        finishVC.output = self
        infoProductVC?.present(finishVC, animated: true, completion: nil)
        self.finishVC = finishVC
    }
}

extension Coordinator: FinishControllerOutput {
    func saveProduct() {
        store.append(product)
        print(store)
        
        finishVC?.alertLabel.text = "Сохранено"
        
        barcodeVC = nil
        infoProductVC = nil
        finishVC = nil
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let barcodeVC = self.vc("BarcodeController") as! BarcodeController
            barcodeVC.output = self
            self.window?.rootViewController = barcodeVC
            self.barcodeVC = barcodeVC
        }
    }
}

private extension Coordinator {
    func vc(_ id: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(identifier: id)
    }
}

private extension Coordinator {
    private func generateQRCode(from string: String) -> UIImage? {
        print("GENERATE QR")
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }
}
