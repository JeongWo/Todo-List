//
//  RandomColor.swift
//  Todo List
//
//  Created by 김정우 on 2023/04/08.
//

import UIKit

struct RandomColor {
    private let colors: [UIColor] = [.red, .blue, .brown, .magenta, .orange, .purple, .systemBlue]
    private var currentColor: UIColor = UIColor()
    
    public var color: UIColor {
        return currentColor
    }
    init() {
        currentColor = colorRandom()
    }
    private func colorRandom() -> UIColor{
        let index = Int.random(in: 0..<colors.count)
        return colors[index]
    }
}
