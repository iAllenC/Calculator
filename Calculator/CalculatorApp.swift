//
//  CalculatorApp.swift
//  Calculator
//
//  Created by Dsee.Lab on 2020/9/19.
//

import SwiftUI

@main
struct CalculatorApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(CalculatorMode())
        }
    }
}
