//
//  HistoryView.swift
//  Calculator
//
//  Created by Dsee.Lab on 2020/9/21.
//

import SwiftUI

struct HistoryView: View {
    
    @ObservedObject var model: CalculatorMode
    @Binding var isPresenting: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            if model.totalCount == 0 {
                Text("没有履历")
            } else {
                HStack {
                    Text("履历").font(.headline)
                    Text(model.historyDetail).lineLimit(nil)
                }
                HStack {
                    Text("显示").font(.headline)
                    Text(model.brain.output)
                }
                Slider(value: $model.slidingIndex, in: 0...Float(model.totalCount), step: 1)
            }
//            Button("关闭") {
//                isPresenting = false
//            }
        }
        .padding()
    }
}

//struct HistoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        HistoryView()
//    }
//}
