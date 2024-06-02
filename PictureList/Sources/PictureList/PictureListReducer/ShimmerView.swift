//
//  ShimmerView.swift
//  
//
//  Created by Mayank Gandhi on 02/06/24.
//

import Foundation

import SwiftUI

struct ShimmerView: View {
    @State private var phase: CGFloat = 0.0

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.gray.opacity(0.3)
                    .blur(radius: 30)
                    .offset(x: -geometry.size.width / 2)
                
                Color.gray.opacity(0.1)
                    .blur(radius: 30)
                    .offset(x: geometry.size.width / 2)
            }
            .mask(
                Rectangle()
                    .fill(
                        LinearGradient(gradient: Gradient(stops: [
                            .init(color: .white, location: phase),
                            .init(color: .gray, location: phase + 0.2),
                            .init(color: .white, location: phase + 0.4)
                        ]), startPoint: .leading, endPoint: .trailing)
                    )
                    .animation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false))
                    .onAppear {
                        self.phase = 1.0
                    }
            )
        }
    }
}
