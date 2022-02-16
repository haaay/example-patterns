//
//  GameSession.swift
//  Millionaire
//
//  Created by hayk on 03.03.2021.
//

import Foundation

enum Mode: Int {
    case sequential, random
}

class GameSession: GameDelegate {
    
    var levelStrategy: LevelStrategy
    var levels: [Level]
    
    var levelIndex = 0
    var numOfLevel = GbObservable<Int>(1)
    var score = GbObservable<Int>(0)
    
    var isOver: Bool {
        return levelIndex == levels.count
    }
    
    var level: Level {
        return levels[levelIndex]
    }
    
    init(withMode mode: Mode) {
        
        switch mode {
        case .sequential:
            levelStrategy = SequentialLevelStrategy()
        case .random:
            levelStrategy = RandomLevelStrategy()
        }
        
        let allLevels = levelsList + GameSingleton.instance.userLevels
        levels = levelStrategy.streamlinedLevels(allLevels)
    }
    
    let levelsList = [
        Level(question: "Что за место, попав в которое, человек делает селфи на кухне, которую не может себе позволить?", options: ["Рим", "Париж", "Лондон", "Икея"], answer: 3),
        Level(question: "Что проводит боксер, наносящий удар противнику снизу?", options: ["Свинг", "Хук", "Апперкот", "Джэб"], answer: 2),
        Level(question: "Что помогает запомнить мнемоническое правило «Это я знаю и помню прекрасно»?", options: ["Число Пи", "Ряд активности металлов", "Цвета радуги", "Порядок падежей"], answer: 0),
        Level(question: "Какую площадь имеет клетка стандартной школьной тетради?", options: ["0.25 кв.см", "1 кв.см", "0.5 кв.см", "1.25 кв.см"], answer: 0),
        Level(question: "Какой город объявлен официальной родиной русского Деда Мороза?", options: ["Малая Вишера", "Великий Устюг", "Вышний Волочек", "Нижний Новгород"], answer: 1)
    ]
    
    func levelUp() {
        levelIndex += 1
        score.value = Int(Double(levelIndex)/Double(levels.count)*100)
        
        if !isOver {
            numOfLevel.value = levelIndex + 1
        }
    }
}
