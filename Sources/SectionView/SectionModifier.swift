//
//  SectionView.swift
//  afterapp
//
//  Created by MacBook on 13/9/2024.
//

//
//  SectionView.swift
//  afterapp
//
//  Created by MacBook on 13/9/2024.
//

import SwiftUI

/// A custom modifier that styles text as a headline with a specific font and alignment.

@available(iOS 17.0, *)
private struct HeadlineModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 23, weight: .heavy, design: .rounded))
            .safeAreaPadding(.horizontal, 8)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

@available(iOS 17.0, *)
public struct SectionView<Content: View>: View {
    
    /// A container that displays a title with optional action and content. Supports a rounded background option.
    /// - Parameters:
    ///   - title: The title text displayed at the top of the container.
    ///   - actionTitle: Optional text for the action button (defaults to an empty string). If empty or nil, no button is shown.
    ///   - roundedBgr: An enum controlling the background style (rounded or none).
    ///   - content: A view builder that defines the content inside the container.
    ///   - action: A closure that runs when the action button is pressed (defaults to an empty closure).
    ///
    private let title: String
    private let actionTitle: String? // Optional action title, used to conditionally display the button
    private let roundedBgr: RoundedBackground
    private let content: Content
    private let action: () -> () // Closure that represents the action to perform (defaults to empty)
    
    public enum RoundedBackground {
        case none
        case card           // with shadow
        case bordered       // just border
        case gradient([Color])  // gradient background
    }
    
    // Initializer with default values for `actionTitle`, `roundedBgr`, and `action`
    public init(title: String, actionTitle: String = "", roundedBgr: RoundedBackground = .none ,@ViewBuilder content: () -> Content, action: @escaping () -> () = { }) {
        self.title = title
        self.actionTitle = actionTitle.isEmpty ? nil : actionTitle
        self.roundedBgr = roundedBgr
        self.content = content()
        self.action = action
    }
    
    public var body: some View {
        switch roundedBgr {
        case .none:
            VStack(spacing: 10) {
                headerView
                content
            }
            .padding(.top)
            .safeAreaPadding(.horizontal, 8)
            
        case .card:
            VStack(spacing: 10) {
                headerView
                content
            }
            .safeAreaPadding(16)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(Color(.systemBackground))
                    .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
            )
            .padding(.horizontal, 8)
            
        case .bordered:
            VStack(spacing: 10) {
                headerView
                content
            }
            .safeAreaPadding(16)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
            .padding(.horizontal, 8)
            
        case .gradient(let colors):
            VStack(spacing: 10) {
                headerView
                content
            }
            .safeAreaPadding(16)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: colors.isEmpty ? [.blue.opacity(0.1), .purple.opacity(0.1)] : colors,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            )
            .padding(.horizontal, 8)
        }
    }
    
    // Helper computed property for the header section
    @ViewBuilder
    private var headerView: some View {
        HStack {
            Text(title)
                .headlineTitle()
            
            Spacer()
            
            if let actionTitle = actionTitle, !actionTitle.isEmpty {
                Button(action: action) {
                    Text(actionTitle)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(Color.accentColor)
                }
                .padding(.trailing, 8)
            }
        }
    }
}

@available(iOS 17.0, *)
public extension View {
    func headlineTitle() -> some View {
        modifier(HeadlineModifier())
    }
}
