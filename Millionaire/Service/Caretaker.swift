//
//  Caretaker.swift
//  Millionaire
//
//  Created by hayk on 14.03.2021.
//

import Foundation

typealias Memento = Data

class Caretaker {
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    func save<Object: Codable>(_ objects: [Object], forKey key: String) {
        do {
            let data: Memento = try encoder.encode(objects)
            UserDefaults.standard.setValue(data, forKey: key)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func load<Object: Codable>(forKey key: String) -> [Object] {
        guard let data: Memento = UserDefaults.standard.data(forKey: key) else { return [] }
        
        do {
            return try decoder.decode([Object].self, from: data)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
