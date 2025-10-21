// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

@available(iOS 15.0, *)
struct CornerStyle: ViewModifier {
    
    let radius: CGFloat
    let colors: [Color]
    let lineWidth: CGFloat
    let blurRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .overlay{
                RoundedRectangle(cornerRadius: radius, style: .continuous)
                    .strokeBorder(
                        LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing) ,lineWidth: lineWidth)
                    .blur(radius: blurRadius)
            }
    }
}

@available(iOS 15.0, *)
public extension View {
    func gradientStroke(radius: CGFloat = 25,
                        colors: [Color] = [.gray.opacity(0.7), .gray.opacity(0.1)],
                        lineWidth: CGFloat = 1,
                        blurRadius: CGFloat = 1) -> some View {
        
        modifier(CornerStyle(radius: radius,
                             colors: colors,
                             lineWidth: lineWidth,
                             blurRadius: blurRadius))
    }
}
