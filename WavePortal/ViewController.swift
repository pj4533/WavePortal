//
//  ViewController.swift
//  WavePortal
//
//  Created by PJ Gray on 12/25/21.
//

import UIKit
import web3swift

class ViewController: UIViewController {
    let contractAddressString = "0xb0f599e8995B8CB7dA5ccA453367eeB58F197514"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            if let path = Bundle.main.path(forResource: "WavePortalABI", ofType: "json"), let contractAddress = EthereumAddress(self.contractAddressString) {
                let contractABI = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                let web3 = Web3.InfuraRinkebyWeb3()
                if let contract = web3.contract(contractABI, at: contractAddress) {
                    let extraData: Data = Data()
                    let tx = contract.read("getAllWaves", parameters: [], extraData: extraData, transactionOptions: nil)
                    if let results = try tx?.call(transactionOptions: nil) {
                        print(results)
                    } else {
                        print("results null")
                    }
                } else {
                    print("contract null")
                }
            }
        } catch let error {
            print(error.localizedDescription)
        }
        
        
        
    }


}

