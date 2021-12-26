//
//  WavePortalDataSource.swift
//  WavePortal
//
//  Created by PJ Gray on 12/26/21.
//

import Foundation
import web3swift
import BigInt

class WavePortalDataSource {
    let contractAddressString = "0xb0f599e8995B8CB7dA5ccA453367eeB58F197514"

    enum WavePortalError: Error {
        case ABINotFound
        case nullResults
        case nullContract
        case errorConvertingResults
    }

    func getAllWaves(success: ((_ waves: [Wave]) -> Void)?, failure: ((_ error: Error?) -> Void)? ) {
        do {
            if let path = Bundle.main.path(forResource: "WavePortalABI", ofType: "json"), let contractAddress = EthereumAddress(self.contractAddressString) {
                let contractABI = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                let web3 = Web3.InfuraRinkebyWeb3()
                if let contract = web3.contract(contractABI, at: contractAddress) {
                    let extraData: Data = Data()
                    let tx = contract.read("getAllWaves", parameters: [], extraData: extraData, transactionOptions: nil)
                    DispatchQueue.global().async {
                        do {
                            if let results = try tx?.call(transactionOptions: nil) {
                                DispatchQueue.main.async {
                                    var waves: [Wave] = []
                                    for result in (results["0"] as? [[Any]]) ?? [] {
                                        if let waveAddress = result[0] as? EthereumAddress, let message = result[1] as? String, let timestamp = result[2] as? BigUInt {
                                            let wave = Wave(waverAddress: waveAddress.address, message: message, timestamp: Date(timeIntervalSince1970: TimeInterval(timestamp)))
                                            waves.append(wave)
                                        } else {
                                            failure?(WavePortalError.errorConvertingResults)
                                            return
                                        }
                                    }
                                    success?(waves)
                                }
                            } else {
                                DispatchQueue.main.async {
                                    failure?(WavePortalError.nullResults)
                                }
                            }
                        } catch let error {
                            DispatchQueue.main.async {
                                failure?(error)
                            }
                        }
                    }
                } else {
                    failure?(WavePortalError.nullContract)
                }
            } else {
                failure?(WavePortalError.ABINotFound)
            }
        } catch let error {
            failure?(error)
        }
    }
}
