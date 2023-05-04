//
//  HorizontalRepoDetailsList.swift
//  GitHubListApp
//
//  Created by petrut alexandra on 03.05.2023.
//

import SwiftUI

struct RepoDetailsItem {
    let image: Image
    let description: String
    let value: String
}

struct HorizontalRepoDetailsList: View {
    let items: [RepoDetailsItem]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 30) {
                ForEach(items, id: \.description) { item in
                    VStack(spacing: 8) {
                        Text(item.description)
                            .font(.callout)
                        item.image
                        Text(item.value)
                            .font(.callout)
                    }.foregroundColor(.gray)
                }
            }
        }
        .frame(height: 100)
    }
}
