//
//  Menu.swift
//  Millionaire
//
//  Created by hayk on 24.02.2021.
//

import UIKit

class Menu: UIViewController, RecordsDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setBackgroundColor(_ color: UIColor) {
        view.backgroundColor = color
    }

    @IBAction func unwind(for unwindSegue: UIStoryboardSegue) {
        
    }
    
    @IBAction func play(_ sender: UIButton) {
        
    }
    
    @IBAction func records(_ sender: UIButton) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let bt = sender as? UIButton,
              let mode = Mode(rawValue: bt.tag)
        else { return }
        
        GameSingleton.instance.mode = mode
        
        
        guard let recordsVC = segue.destination as? Records
        else { return }
        
        recordsVC.delegate = self
    }
    
}
