//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    // MARK: - @IBOutlet
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet var digitsButtons: [UIButton]!
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
