//
//  GameSingleton.swift
//  Millionaire
//
//  Created by hayk on 03.03.2021.
//

import Foundation

class GameSingleton {
    
    static let instance = GameSingleton()
    private init() {
        records = recordsKeeper.load()
        userLevels = levelsKeeper.load()
    }
    
    var session: GameSession?
    var mode: Mode = .sequential
    
    private(set) var records = [Record]()
    private let recordsKeeper = RecordsKeeper()
    
    private(set) var userLevels = [Level]()
    private let levelsKeeper = LevelsKeeper()
    
    @discardableResult func end() -> Int {
        guard let score = session?.score.value else { return 0 }
        let record = Record(date: Date(), score: score)
        records.insert(record, at: 0)
        recordsKeeper.save(records)
        session = nil
        
        return score
    }
    
    func saveLevel(_ level: Level) {
        userLevels.append(level)
        levelsKeeper.save(userLevels)
    }
}
