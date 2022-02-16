//
//  LevelAddition.swift
//  Millionaire
//
//  Created by hayk on 14.03.2021.
//

import UIKit

class LevelAddition: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var questionPlace: UITextView!
    @IBOutlet var optionFields: [UITextField]!
    @IBOutlet weak var correctOptionControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionPlace.delegate = self
        
        optionFields.forEach { option in
            option.delegate = self
        }
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let t = textField.text, t.count > 25 && string.count > 0 {
            return false
        }
        
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if textView.text.count > 100 && text.count > 0 {
            return false
        }
        
        if text == "\n" {
            optionFields[0].becomeFirstResponder()
            return false
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.tag < 3 {
            optionFields[textField.tag + 1].becomeFirstResponder()
        } else {
            addLevelIfCompleted()
        }
        
        return true
    }

    @IBAction func addLevelClicked(_ sender: UIButton) {
        addLevelIfCompleted()
    }
    
    @IBAction func unwind(for unwindSegue: UIStoryboardSegue) {}
    
    func addLevelIfCompleted() {
        
        hideKeyboard()
        
        do { try addLevel() }
        catch { alert(withMessage: "Fill in all the fields") }
    }
    
    func addLevel() throws {
                
        struct Empty: Error {}
        var options = [String]()
        
        if questionPlace.text.isEmpty {
            throw Empty()
        }
        
        try optionFields.forEach { field in
            if field.text == nil || field.text!.isEmpty {
                throw Empty()
            } else {
                options.append(field.text!)
            }
        }
        
        let level = Level(question: questionPlace.text, options: options, answer: correctOptionControl.selectedSegmentIndex)
        
        GameSingleton.instance.saveLevel(level)
        alert(withMessage: "Your question has been added")
        clearFields()
    }
    
    func alert(withMessage message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
    
    func clearFields() {
        
        questionPlace.text.removeAll()
        correctOptionControl.selectedSegmentIndex = 0
        
        optionFields.forEach { field in
            field.text?.removeAll()
        }
    }
    
}
