//
//  GameController.swift
//  Millionaire
//
//  Created by hayk on 24.02.2021.
//

import UIKit

protocol GameDelegate: AnyObject {
    var isOver: Bool { get }
    var level: Level { get }
    var numOfLevel: GbObservable<Int> { get }
    var score: GbObservable<Int> { get }
    func levelUp()
}

class GameController: UIViewController {

    @IBOutlet weak var questionLb: UILabel!
    @IBOutlet weak var progressLb: UILabel!
    @IBOutlet var options: [UIButton]!
    
    let game = GameSingleton.instance
    weak var gameDelegate: GameDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        game.session = GameSession(withMode: game.mode)
        gameDelegate = game.session
        
        setLevel()
                
        gameDelegate?.numOfLevel.addObserver(self, options: [.initial, .new], closure: { [weak self] (num, _) in
            self?.addProgress("Level: \(num)")
        })
        
        gameDelegate?.score.addObserver(self, options: [.initial, .new], closure: { [weak self] (score, _) in
            self?.addProgress("Score: \(score)")
        })
    }
    
    func addProgress(_ newText: String) {
        if progressLb.tag == 0 {
            progressLb.text = newText
            progressLb.tag = 1
        } else {
            progressLb.text = (progressLb.text ?? "") + "\n" + newText
            progressLb.tag = 0
        }
    }
    
    deinit {
        gameDelegate?.numOfLevel.removeObserver(self)
        gameDelegate?.score.removeObserver(self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(segue)
    }
    
    func setLevel() {
        
        questionLb.text = gameDelegate.level.question
        
        for option in options {
            option.setTitle(gameDelegate.level.options[option.tag], for: .normal)
        }
    }
    
    @IBAction func optionClicked(_ sender: UIButton) {
        sender.tag == gameDelegate.level.answer ? correct() : wrong()
    }
    
    func correct() {
        gameDelegate.levelUp()
        
        paintScreen(.systemGreen) {
            self.gameDelegate.isOver ? self.endGame() : self.setLevel()
        }
    }
    
    func wrong() {
        paintScreen(.systemPink) {
            self.endGame()
        }
    }
    
    func paintScreen(_ color: UIColor, closure: @escaping () -> Void) {
        view.backgroundColor = color
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.view.backgroundColor = .systemPurple
            closure()
        }
    }
    
    func endGame() {
        
        questionLb.isHidden = true
        progressLb.text = String(game.end()) + " points"
        
        options.forEach { (option) in
            option.isHidden = true
        }
        
        performSegue(withIdentifier: "recordsSegue", sender: nil)
    }
    
}

