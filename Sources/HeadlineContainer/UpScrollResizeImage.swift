//
//  UpScrollResizeImage2.swift
//  HeadlineContainer
//
//  Created by MacBook on 22/11/2024.
//


struct UpScrollResizeImage2: View {
    let url: String
    let height: CGFloat
    var body: some View {
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