//
//  HeadlineModifier.swift
//  afterapp
//
//  Created by MacBook on 13/9/2024.
//

import SwiftUI

/// A custom modifier that styles text as a headline with a specific font and alignment.
private struct HeadlineModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 23, weight: .heavy, design: .rounded))
            .safeAreaPadding(.horizontal, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}



struct HeadlineContainer<Content: View>: View {
    
    /// A container that displays a title with optional action and content. Supports a rounded background option.
    /// - Parameters:
    ///   - title: The title text displayed at the top of the container.
    ///   - actionTitle: Optional text for the action button (defaults to an empty string). If empty or nil, no button is shown.
    ///   - roundedBgr: An enum controlling the background style (rounded or none).
    ///   - content: A view builder that defines the content inside the container.
    ///   - action: A closure that runs when the action button is pressed (defaults to an empty closure).
    ///
    let title: String
    let actionTitle: String? // Optional action title, used to conditionally display the button
    let roundedBgr: RoundedBackground
    let content: Content
    let action: () -> () // Closure that represents the action to perform (defaults to empty)
    
    enum RoundedBackground {
        case background, none
    }
    
    // Initializer with default values for `actionTitle`, `roundedBgr`, and `action`
    init(title: String, actionTitle: String = "", roundedBgr: RoundedBackground = .none ,@ViewBuilder content: () -> Content, action: @escaping () -> () = { }) {
        self.title = title
        self.actionTitle = actionTitle
        self.roundedBgr = roundedBgr
        self.content = content()
        self.action = action
    }
    
    var body: some View {
        switch roundedBgr {
        case .background:
            VStack(spacing: 10){
                HStack{
                    Text(title)
                    Spacer()
                    if let actionTitle = actionTitle {
                        Button(action: action){
                            Text(actionTitle)
                                .font(.system(size: 16))
                                .foregroundColor(.white.opacity(0.5))
                                .font(.subheadline).bold()
                        }
                    }
                }
                .headlineTitle() // Applies the headline title styling
                content
            }.safeAreaPadding(10)
                .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous)) // removing clipShape, will create a hovering row offect
                .background(RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                    .fill(.darkBlue)
                    .shadow(color: .black.opacity(0.2), radius: 10, y: 5))
            
            
        case .none:
            VStack(spacing: 10){
                Text(title)
                    .headlineTitle()
                content
            }.padding(.top)
                .safeAreaPadding(.horizontal,8)
        }
    }
}

extension View {
    func headlineTitle() -> some View {
        modifier(HeadlineModifier())
    }
}
