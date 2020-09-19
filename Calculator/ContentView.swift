//
//  ContentView.swift
//  Calculator
//
//  Created by Dsee.Lab on 2020/9/19.
//

import SwiftUI

struct ContentView: View {
    
    @State private var brain: CalculatorBrain = .left("0")
    
    let scale = UIScreen.main.bounds.width / 414
    
    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            Text(brain.output)
                .font(.system(size: 76))
                .minimumScaleFactor(0.5)
                .padding(.trailing, 24)
                .lineLimit(1)
                .frame(
                    minWidth:0,
                    maxWidth: .infinity,
                    alignment: .trailing)
            CalculatorButtonPad(brain: $brain)
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
    
    @Binding var brain: CalculatorBrain
    
    let row: [CalculatorButtonItem]
    
    var body: some View {
        HStack {
            ForEach(row, id: \.self) { item in
                CalculatorButton(title: item.title,
                                 size: item.size,
                                 foregroundColor: item.foregroundColor,
                                 backgroundColor: item.backgroundColor) {
                    brain = brain.apply(item: item)
                }
            }
        }
    }
}

struct CalculatorButtonPad: View {
    
    @Binding var brain: CalculatorBrain

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
                CalculatorButtonRow(brain: $brain, row: $0)
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.dark)
            ContentView().previewDevice("iPhone 8")
        }
    }
}

