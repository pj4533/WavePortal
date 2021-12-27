//
//  ViewController.swift
//  WavePortal
//
//  Created by PJ Gray on 12/25/21.
//

import UIKit

class ViewController: UIViewController {
    let datasource = WavePortalDataSource()
    var waves: [Wave] = []
    
    @IBOutlet weak var connectWalletButton: UIButton!
    @IBOutlet weak var viewAllButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reloadWaves()
    }
    
    func reloadWaves() {
        self.datasource.getAllWaves { waves in
            self.waves = waves
            self.viewAllButton.setTitle("View All \(self.waves.count) Waves", for: .normal)
        } failure: { error in
            print("ERROR: \(error?.localizedDescription ?? "Unknown error")")
        }
    }

    @IBAction func tappedViewAll(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "WavesViewController") as? WavesViewController {
            vc.waves = self.waves
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func tappedConnectWallet(_ sender: Any) {
    }
}

