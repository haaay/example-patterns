//
//  RecordsKeeper.swift
//  Millionaire
//
//  Created by hayk on 03.03.2021.
//

import Foundation

class RecordsKeeper {
    
    private let caretaker = Caretaker()
    private let key = String(describing: RecordsKeeper.self)

    func save(_ records: [Record]) {
        caretaker.save(records, forKey: key)
    }
    
    func load() -> [Record] {
        caretaker.load(forKey: key)
    }
}

class LevelsKeeper {
    
    private let caretaker = Caretaker()
    private let key = String(describing: LevelsKeeper.self)
    
    func save(_ levels: [Level]) {
        caretaker.save(levels, forKey: key)
    }
    
    func load() -> [Level] {
        caretaker.load(forKey: key)
    }
}
