//
//  LoadingView.swift
//  GitHubListApp
//
//  Created by petrut alexandra on 28.04.2023.
//

import SwiftUI

struct LoadingView: View {
    let text: String
    
    init(text: String) {
        self.text = text
    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Text(self.text)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                ActivityIndicator()
            }
            .frame(width: geometry.size.width,
                   height: geometry.size.height,
                   alignment: .center)
            .offset(y: -geometry.size.height/4)
        }
    }
}

public struct ActivityIndicator: UIViewRepresentable {
    
    public func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.startAnimating()
        
        return indicator
    }
    
    public func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {}
    
}

