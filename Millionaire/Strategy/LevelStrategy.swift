//
//  LevelStrategy.swift
//  Millionaire
//
//  Created by hayk on 10.03.2021.
//

import UIKit

protocol LevelStrategy: AnyObject {
    func streamlinedLevels(_ levels: [Level]) -> [Level]
}


