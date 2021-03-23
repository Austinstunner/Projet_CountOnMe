//
//  SimpleCalcTests.swift
//  SimpleCalcTests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

final class CalculatorTests: XCTestCase {
    var logical: Logical!
    var logicalDelegateMock = LogicalDelegateMock()
    override func setUp() {
        super.setUp()
        logical = Logical()
        logical.delegate = logicalDelegateMock
    }
    // MARK: - Test Calcul
    // Addition
    func testGiven2Plus3_WhenAddition_ThenResultShouldBe5() {
        logical.appendSelectedNumber("2")
        logical.appendOperand("+")
        logical.appendSelectedNumber("3")
        logical.makeOperation()
        XCTAssertEqual(logical.calculInProgress, " = 5")
    }
    // Substraction
    func testGiven5Minus2_WhenSubstraction_ThenResultShouldBe3() {
        logical.appendSelectedNumber("5")
        logical.appendOperand("-")
        logical.appendSelectedNumber("2")
        logical.makeOperation()
        XCTAssertEqual(logical.calculInProgress, " = 3")
    }
    // Multiplication
    func testGiven6Multiplying3_WhenMultiplication_ThenResultSouldBe18() {
        logical.appendSelectedNumber("6")
        logical.appendOperand("x")
        logical.appendSelectedNumber("3")
        logical.makeOperation()
        XCTAssertEqual(logical.calculInProgress, " = 18")
    }
    // Division
    func testGiven1ODivide2_WhenDivision_ThenResultSouldBe5() {
        logical.appendSelectedNumber("10")
        logical.appendOperand("÷")
        logical.appendSelectedNumber("2")
        logical.makeOperation()
        XCTAssertEqual(logical.calculInProgress, " = 5")
    }
    // Test Complexe Operation
    func testComplexeOperation_WhenAllOperand_ThenResultSouldBe67Dot9() {
        logical.calculInProgress = "40 + 6 x 9.3 ÷ 2"
        logical.makeOperation()
        XCTAssertEqual(logical.calculInProgress, " = 67.9")
    }
    // Keep Result
    func testGivenKeepResult_WhenKeepPress_ThenCalculInProgressShoudBe1() {
        logical.calculInProgress = "3 - 2"
        logical.makeOperation()
        logical.memorizeResult()
        XCTAssertEqual(logical.calculInProgress, "1")
    }
    // Test Number Correction
    func testGiven5Plus23_WhenCorrectionForLastNumber_ThenResultSouldBe5Plus2() {
        logical.calculInProgress = "5 + 23"
        logical.correction()
        XCTAssertTrue(logical.calculInProgress == "5 + 2")
    }
    // Test Operand Correction
    func testGiven5Plus23Minus_WhenCorrectionForLastOperand_ThenResultSouldBe5Plus23() {
        logical.calculInProgress = "5 + 23 - "
        logical.correction()
        XCTAssertTrue(logical.calculInProgress == "5 + 23")
    }
    // Test Reset Method
    func testResetOperation_WhenPressReset_ThenResultSouldBeNothing() {
        logical.calculInProgress = "5 / 2"
        logical.reset()
        XCTAssertEqual(logical.calculInProgress, "")
    }
    // Test Format Result
    func testFormatResult_WhenDecimalReduction_ThenResultSouldBeFalseCase1AndTrueCase2() {
        logical.calculInProgress = "11 ÷ 3.5"
        logical.makeOperation()
        XCTAssertFalse(logical.calculInProgress == " = 3.14285714")
        XCTAssertTrue(logical.calculInProgress == " = 3.14286")
    }
    // MARK: - Test Alert
    // Alert enough Elements Test
    func testOperationIsImpossible_WhenOperationHaventEnoughElements_ThenResultSouldBeFalse() {
        logical.appendSelectedNumber("2 + ")
        logical.makeOperation()
        XCTAssertEqual(logical.calculInProgress, "2 + ")
        XCTAssertEqual(logicalDelegateMock.testAlertTitle, Logical.ErrorCase.operationImpossible.title)
        XCTAssertEqual(logicalDelegateMock.testAlertMessage, Logical.ErrorCase.operationImpossible.message)
    }
    // Alert Division by 0
    func testGivenAlertMessage_WhenLastElementsAreDivideandZero_ThenResultSouldBeDisplayAlertMessage() {
        logical.calculInProgress = "5 ÷ 0"
        logical.makeOperation()
        XCTAssertEqual(logicalDelegateMock.testAlertMessage, Logical.ErrorCase.divideByZero.message)
    }
    // Alert can't add 2 Operators
    func testGivenAlertMessage_WhenAlreadyHaveAnOperand_ThenResultSouldBeAlertMessage() {
        logical.calculInProgress = "5 + "
        logical.appendOperand("+")
        XCTAssertEqual(logicalDelegateMock.testAlertMessage, Logical.ErrorCase.wrongOperator.message)
    }
    // Alert Double Decimal
    func testGivenDecimalExist_WhenAlreadyHaveAPoint_ThenResultSouldBeAlertMessage() {
        logical.calculInProgress = "5 + 3"
        logical.isDecimal()
        logical.isDecimal()
        XCTAssertEqual(logicalDelegateMock.testAlertMessage, Logical.ErrorCase.decimalExist.message)
    }
    // Alert Double Equal
    func testGivenResult_WhenDoubleEqual_ThenResultShouldBeAlert() {
        logical.appendSelectedNumber("2")
        logical.appendOperand("+")
        logical.appendSelectedNumber("3")
        logical.makeOperation()
        XCTAssertEqual(logical.calculInProgress, " = 5")
        logical.makeOperation()
        XCTAssertEqual(logicalDelegateMock.testAlertMessage, Logical.ErrorCase.operationHaveResult.message)
    }
    // Alert Correction After Result
    func testGivenAlertMessage_WhenCorrectionAfterEqual_ThenResultShouldBeAlert() {
        logical.calculInProgress = "5 + 23"
        logical.makeOperation()
        logical.correction()
        XCTAssertEqual(logicalDelegateMock.testAlertMessage, Logical.ErrorCase.operationHaveResult.message)
    }
    // Alert Error Syntax
    func testGivenAlertMessage_WhenAppendPlusAfterDecimal_ThenResultShouldBeAlert() {
        logical.calculInProgress = "3."
        logical.appendOperand("+")
        XCTAssertEqual(logicalDelegateMock.testAlertMessage, Logical.ErrorCase.syntax.message)
    }
    // Alert Adding Operand Last
    func testGivenAlertMessage_WhenOperandAfterResult_ThenResultShouldBeAlert() {
        logical.calculInProgress = "5 + 3"
        logical.makeOperation()
        logical.appendOperand("-")
        XCTAssertEqual(logicalDelegateMock.testAlertMessage, Logical.ErrorCase.operationHaveResult.message)
    }
    // Alert Adding Operand First
    func testGivenAlertMessage_WhenStartWithOperand_ThenResultSouldBeAlert() {
        logical.appendOperand("+")
        XCTAssertEqual(logicalDelegateMock.testAlertMessage, Logical.ErrorCase.operationImpossible.message)
    }
    // Alert Adding Decimal First
    func testGivenAlertMessage_WhenStartWithDecimal_ThenResultSouldBeAlert() {
        logical.calculInProgress = ""
        logical.isDecimal()
        XCTAssertEqual(logicalDelegateMock.testAlertMessage, Logical.ErrorCase.syntax.message)
    }
    // Alert Adding Decimal After Operand
    func testGivenAlertMessage_WhenDecimalAfterOperator_ThenResultSouldBeAlert() {
        logical.calculInProgress = "5 + "
        logical.isDecimal()
        XCTAssertEqual(logicalDelegateMock.testAlertMessage, Logical.ErrorCase.syntax.message)
    }
    // Alert Adding Decimal After Result
    func testGivenAlertMessage_WhenDecimalBeforeEqual_ThenResultSouldBeAlert() {
        logical.calculInProgress = "5 + 3."
        logical.makeOperation()
        XCTAssertEqual(logicalDelegateMock.testAlertMessage, Logical.ErrorCase.syntax.message)
    }
    // Alert Adding Number After Result
    func testGivenAlertMessage_WhenNumberAfterResult_ThenResultShouldBeAlert() {
        logical.calculInProgress = "5 + 6"
        logical.makeOperation()
        logical.appendSelectedNumber("3")
        XCTAssertEqual(logicalDelegateMock.testAlertMessage, Logical.ErrorCase.operationHaveResult.message)
    }
    // Alert Keep Result
    func testKeepOnce_WhenPressKeep_ThenResultSouldBeAlertMessage() {
        logical.calculInProgress = "5 + 2 - 3"
        logical.makeOperation()
        logical.memorizeResult()
        logical.calculInProgress = "4"
        logical.memorizeResult()
        XCTAssertEqual(logicalDelegateMock.testAlertMessage, Logical.ErrorCase.memorize.message)
    }
    // Alert Unknow Operand
    func testGivenAlertMessage_WhenUnknowOperand_ThenResultSouldBeAlertMessage() {
        logical.calculInProgress = "5"
        logical.appendOperand("E")
        XCTAssertEqual(logicalDelegateMock.testAlertMessage, Logical.ErrorCase.operationImpossible.message)
    }
}
