//
//  WavesViewController.swift
//  WavePortal
//
//  Created by PJ Gray on 12/27/21.
//

import UIKit

class WavesViewController: UIViewController {
    var waves: [Wave] = []
    
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.reloadData()
    }
}

extension WavesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.waves.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let wave = self.waves[indexPath.row]

        cell.textLabel?.text = "\(wave.message) - (\(wave.timestamp))"
        cell.detailTextLabel?.text = "\(wave.waverAddress)"
        
        return cell
    }
}
