//
//  ViewController.swift
//  WavePortal
//
//  Created by PJ Gray on 12/25/21.
//

import UIKit

class ViewController: UIViewController {
    let datasource = WavePortalDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.datasource.getAllWaves { waves in
            print(waves)
        } failure: { error in
            print("ERROR: \(error?.localizedDescription ?? "Unknown error")")
        }
    }


}

