//
//  PressEffectButtonStyle.swift
//  StreamingApp
//
//  Created by Gabriel Monteiro Camargo da Silva on 11/04/25.
//

import SwiftUI

struct PressEffectButtonStyle: ButtonStyle {

    // MARK: - Public Methods
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}
