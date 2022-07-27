//
//  UIViewController + Extension.swift
//  FindMusicApp
//
//  Created by Serhii Dvornyk on 27.07.2022.
//

import UIKit

extension UIViewController {
    
    func alertOk(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default) { alert in
            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}
