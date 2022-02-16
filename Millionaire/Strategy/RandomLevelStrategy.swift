//
//  RandomLevelStrategy.swift
//  Millionaire
//
//  Created by hayk on 10.03.2021.
//

import UIKit

class RandomLevelStrategy: LevelStrategy {
    func streamlinedLevels(_ levels: [Level]) -> [Level] {
        return levels.shuffled()
    }
}
