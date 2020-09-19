//
//  CalculatorButtonItem.swift
//  Calculator
//
//  Created by Dsee.Lab on 2020/9/19.
//

import Foundation
import SwiftUI

enum CalculatorButtonItem {
    
    enum Operator: String {
        case plus = "+"
        case minus = "-"
        case multiply = "x"
        case divide = "÷"
        case equal = "="
    }
    
    enum Command: String {
        case clear = "AC"
        case flip = "+/-"
        case percent = "%"
    }
    
    case digit(Int)
    case dot
    case `operator`(Operator)
    case command(Command)
}


extension CalculatorButtonItem {
    
    var title: String {
        switch self {
        case .digit(let value): return String(value)
        case .dot: return "."
        case .operator(let `operator`): return `operator`.rawValue
        case .command(let command): return command.rawValue
        }
    }
    
    
    var size: CGSize {
        if case CalculatorButtonItem.digit(let value) = self, value == 0 {
            return CGSize(width: 88 * 2 + 8, height: 88)
        } else {
            return CGSize(width: 88, height: 88)
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .digit, .dot: return .digitBackground
        case .operator: return .operatorBackground
        case .command: return .commandBackground
        }
    }
    
    var foregroundColor: Color {
        if case Self.command = self {
            return .commandForeground
        } else {
            return .white
        }
    }
    
}

extension CalculatorButtonItem: Hashable { }
