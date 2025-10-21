//
//  UpScrollResizeImage2.swift
//  SectionView
//
//  Created by MacBook on 22/11/2024.
//

import SwiftUI
import SDWebImageSwiftUI

@available(iOS 17.0, *)
public struct UpScrollResizeImage: View {
    let url: String
    let height: CGFloat
    
    public var body: some View {
        VStack{
            GeometryReader { proxy in
                let minY = proxy.frame(in: .scrollView).minY
                let scale = minY > 0 ? max(1, 1 + (minY / 1000)) : 1
                
                RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                    .fill(.clear)
                    .frame(height: height)
                    .background(
                        LoadableImage(url: URL(string: url), defaultImage: .movie)
                            .scaledToFill()
                            .scaleEffect(scale, anchor: .top)
                            .scrollTransition(.animated) { view, phase in
                                view.scaleEffect(scale, anchor: .top)
                                    .offset(y: -minY)
                            }.frame(width: proxy.size.width)
                    ).clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
            }
            
        }.frame(height: height)
    }
}

enum EmtypImage {
    case movie
    case avatar
    case tvShow
    case provider
    
    var name: String {
        switch self {
        case .movie,.tvShow:
            return "default-movie"
        case .avatar,.provider:
            return "default-avatar"
        }
    }
}

@available(iOS 17.0, *)
struct LoadableImage: View {
    var url : URL?
    var defaultImage: EmtypImage
    
    var body: some View {
        VStack {
            WebImage(url: url){ phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
                    
                case .failure:
                    Image(defaultImage.name)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
                    
                case .empty:
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }
            }
        }
    }
}
