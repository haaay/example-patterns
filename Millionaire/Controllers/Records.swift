//
//  Records.swift
//  Millionaire
//
//  Created by hayk on 03.03.2021.
//

import UIKit

protocol RecordsDelegate: AnyObject {
    func setBackgroundColor(_ color: UIColor)
}

class Records: UIViewController, UITableViewDelegate, UITableViewDataSource {

    weak var delegate: RecordsDelegate!
    let records = GameSingleton.instance.records
    
    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: RecordCell.reuseIdentifier, for: indexPath) as! RecordCell
        
        let record = records[indexPath.row]
        
        cell.dateLabel.text = record.date.description.components(separatedBy: " ").first ?? ""
        cell.scoreLabel.text = "\(record.score)"
        
        return cell
    }
    
    @IBAction func action(_ sender: UIButton) {
        
        var color = UIColor()
        
        switch Int.random(in: 0..<4) {
        case 0:
            color = .systemPink
        case 1:
            color = .systemGreen
        case 2:
            color = .systemOrange
        case 3:
            color = .systemTeal
        default:
            color = .systemPink
        }
        
        delegate.setBackgroundColor(color)
    }

}
