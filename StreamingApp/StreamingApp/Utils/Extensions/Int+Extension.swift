//
//  Int+Extension.swift
//  StreamingApp
//
//  Created by Gabriel Monteiro Camargo da Silva on 07/04/25.
//

import Foundation

extension Int {
    var formattedTime: String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = .pad
        formatter.unitsStyle = .positional

        return formatter.string(from: TimeInterval(self))
    }
}
