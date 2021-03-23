//
//  LogicalDelegateMock.swift
//  CountOnMeTests
//
//  Created by Anthony TUFFERY on 11/03/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class LogicalDelegateMock: LogicalDelegate {
    var testAlertTitle: String = ""
    var testAlertMessage: String = ""
    func updateDisplay(_ calculInProgress: String) {
    }
    func showAlertPopUp(title: String, message: String) {
        testAlertTitle = title
        testAlertMessage = message
    }
}
