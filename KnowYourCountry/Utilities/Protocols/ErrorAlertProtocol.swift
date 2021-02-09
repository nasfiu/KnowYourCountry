//
//  ErrorAlertProtocol.swift
//  KnowYourCity
//
//  Created by Nasfi on 08/02/21.
//
import Foundation
import UIKit

protocol ErrorAlertProtocol {
    func showAlert(message: String)
}

extension ErrorAlertProtocol where Self: UIViewController {
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: StringConstants.errorAlertTitle, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: StringConstants.ok, style: .cancel, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
