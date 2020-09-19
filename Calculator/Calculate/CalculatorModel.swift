//
//  CalculatorModel.swift
//  Calculator
//
//  Created by Dsee.Lab on 2020/9/19.
//

import Foundation
import Combine

class CalculatorMode: ObservableObject {
        
    @Published var brain: CalculatorBrain = .left("0")
    
    @Published var history: [CalculatorButtonItem] = []
    
    func apply(_ item: CalculatorButtonItem) {
        brain = brain.apply(item: item)
        history.append(item)
    }
    
}
