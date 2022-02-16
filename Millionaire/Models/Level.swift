//
//  Level.swift
//  Millionaire
//
//  Created by hayk on 24.02.2021.
//

import Foundation

struct Level: Codable {
    let question: String
    let options: [String]
    let answer: Int
}
