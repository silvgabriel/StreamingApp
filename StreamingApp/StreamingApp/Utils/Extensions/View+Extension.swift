//
//  View+Extension.swift
//  StreamingApp
//
//  Created by Gabriel Monteiro Camargo da Silva on 04/04/25.
//

import SwiftUI

extension View {
    func showLoading(when condition: Bool, name text: String = "Loading...") -> some View {
        overlay {
            if condition {
                ZStack {
                    Color.loadingBG
                        .ignoresSafeArea()

                    HStack(spacing: 16) {
                        Text(text)
                        ProgressView()

                    }
                }
                .font(.title3)
                .tint(.white)
                .foregroundStyle(.white)
            }
        }
    }

    func roundedCorners(_ radius: CGFloat) -> some View {
        clipShape(RoundedRectangle(cornerRadius: radius))
    }

    func outlined<S>(radius: CGFloat, lineWidth: CGFloat, color: S = Color.white) -> some View where S: ShapeStyle {
        roundedCorners(radius)
            .overlay {
                RoundedRectangle(cornerRadius: radius)
                    .stroke(color, lineWidth: lineWidth)
            }
    }
}
