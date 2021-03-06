//
//  ContentView.swift
//  Calculator
//
//  Created by Dsee.Lab on 2020/9/19.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var model: CalculatorMode
    @State private var editingHistory: Bool = false
    @State private var showingResult: Bool = false
    
    let scale = UIScreen.main.bounds.width / 414
    
    var body: some View {
        VStack(spacing: 12) {
            Spacer()
//            Button("操作履历:\(model.history.count)") {
//                editingHistory = true
//            }.sheet(isPresented: $editingHistory) {
//                HistoryView(model: model, isPresenting: $editingHistory)
//            }
            HistoryView(model: model, isPresenting: $editingHistory)
            Text(model.brain.output)
                .font(.system(size: 76))
                .minimumScaleFactor(0.5)
                .padding(.trailing, 24)
                .lineLimit(1)
                .frame(
                    minWidth:0,
                    maxWidth: .infinity,
                    alignment: .trailing)
                .onTapGesture {
                    showingResult = true
                }.alert(isPresented: $showingResult) {
                    Alert(title: Text(model.historyDetail), message: Text(model.brain.output), primaryButton: .cancel(Text("取消")), secondaryButton: .default(Text("复制")) {
                        UIPasteboard.general.string = model.brain.output
                    })
                }
            CalculatorButtonPad()
                .padding(.bottom)
        }
        .scaleEffect(scale)
    }
            
}

struct CalculatorButton: View {
    
    let fontSize: CGFloat = 38
    let title: String
    let size: CGSize
    let foregroundColor: Color
    let backgroundColor: Color
    let action: () -> Void

    var body: some View {
        // 实现方式一
        Button(action: action) {
            Text(title)
                .font(.system(size: fontSize))
                .foregroundColor(foregroundColor)
                .foregroundColor(foregroundColor)
                .frame(width: size.width, height: size.height)
                .background(backgroundColor)
                .cornerRadius(size.width/2)
        }

        // 实现方式二
//        Button(action: action) {
//            ZStack {
//                RoundedRectangle(cornerRadius: size.width/2)
//                    .frame(width: size.width, height: size.height)
//                    .foregroundColor(backgroundColor)
//                Text(title)
//                    .font(.system(size: fontSize))
//                    .foregroundColor(foregroundColor)
//
//            }
//        }
    }
}


struct CalculatorButtonRow: View {
    
//    @Binding var brain: CalculatorBrain
    @EnvironmentObject var model: CalculatorMode

    let row: [CalculatorButtonItem]
    
    var body: some View {
        HStack {
            ForEach(row, id: \.self) { item in
                CalculatorButton(title: item.title,
                                 size: item.size,
                                 foregroundColor: item.foregroundColor,
                                 backgroundColor: item.backgroundColor) {
                    model.apply(item)
                }
            }
        }
    }
}

struct CalculatorButtonPad: View {
    
//    @Binding var brain: CalculatorBrain
//    var model: CalculatorMode
    
    let pad: [[CalculatorButtonItem]] = [
        [.command(.clear), .command(.flip), .command(.percent), .operator(.divide)],
        [.digit(1), .digit(2), .digit(3), .operator(.plus)],
        [.digit(4), .digit(5), .digit(6), .operator(.minus)],
        [.digit(7), .digit(8), .digit(9), .operator(.multiply)],
        [.digit(0), .dot, .operator(.equal)]
    ]
    
    var body: some View {
        VStack(spacing: 8) {
            ForEach(pad, id: \.self) {
                CalculatorButtonRow(row: $0)
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .environmentObject(CalculatorMode())
                .preferredColorScheme(.dark)
            ContentView()
                .environmentObject(CalculatorMode())
                .previewDevice("iPhone 8")
        }
    }
}

