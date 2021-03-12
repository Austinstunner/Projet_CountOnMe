//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit
/*
class ViewController: UIViewController {
    // MARK: - IBOutlets
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    var test = Calculator()
    // MARK: - ViewDidLoad
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    // MARK: - IBActions
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        
        if expressionHaveResult {
            textView.text = ""
        }
        
        textView.text.append(numberText)
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        if canAddOperator {
            textView.text.append(" + ")
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        if canAddOperator {
            textView.text.append(" - ")
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard expressionIsCorrect else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        guard expressionHaveEnoughElement else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
    }
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        if canAddOperator {
            textView.text.append(" / ")
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
        
    }
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        if canAddOperator {
            textView.text.append(" * ")
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
        
    }
    @IBAction func tappedACButton(_ sender: UIButton) {
    }
    @IBAction func tappedMButton(_ sender: UIButton) {
    }
    @IBAction func tappedDeleteButton(_ sender: UIButton) {
    }
    
    
    
    
}
*/
import UIKit

final class ViewController: UIViewController {
    
    // MARK: - @IBOUtlet
    
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet var calculaterButtons: [UIButton]!
    
    // MARK: - Private Property
    
    private let logical = Logical()
    
    // MARK: - View Life cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logical.delegate = self
        textView.layer.cornerRadius = 6
        textView.text = logical.calculInProgress
    }
    
    // MARK: - @IBAction
    
    @IBAction private func tappedAllClearButton(_ sender: UIButton) {
        logical.reset()
    }
    
    @IBAction private func tappedCorrectionButton(_ sender: UIButton) {
        logical.correction()
    }
    
    @IBAction private func tappedKeepButton(_ sender: UIButton) {
        logical.memorizeResult()
    }
    
    @IBAction private func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else { return }
        logical.appendSelectedNumber(numberText)
    }
    
    @IBAction private func tappedDecimalButton(_ sender: UIButton) {
        logical.isDecimal()
    }
    
    @IBAction private func tappedOperatorsButton(_ sender: UIButton) {
        guard let operandChoice = sender.title(for: .normal) else { return }
        logical.appendOperand(operandChoice)
    }
    
    @IBAction private func tappedEqualButton(_ sender: UIButton) {
        logical.makeOperation()
    }
}

// MARK: - Extensions

extension ViewController: LogicalDelegate {
    func updateDisplay(_ calculInProgress: String) {
        textView.text = calculInProgress
        textView.layer.cornerRadius = 6
    }
    
    func showAlertPopUp(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
