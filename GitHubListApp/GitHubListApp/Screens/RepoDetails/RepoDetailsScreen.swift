//
//  RepoDetailsScreen.swift
//  GitHubListApp
//
//  Created by petrut alexandra on 03.05.2023.
//

import SwiftUI

struct RepoDetailsScreen: View {
    
    let viewModel: RepoDetailsViewModel
    
    @State private var openButtonOffset = -100.0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(alignment: .top) {
                AsyncImage(url: URL(string: viewModel.repoItem.owner.avatarUrl ?? "")) { image in
                    image.resizable()
                } placeholder: {
                    Image.personFill
                }
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                VStack(alignment: .leading) {
                    Text(viewModel.repoItem.name ?? "")
                        .font(.title)
                    
                    Text("last update: 20.6.1006")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Button(action: {
                        viewModel.openUrl(urlString: viewModel.repoItem.url ?? "")
                    }) {
                        Text("Open")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .offset(y: openButtonOffset)
                    .onAppear {
                        withAnimation(.easeIn(duration: 0.3)) { self.openButtonOffset = 0 }
                    }
                }.padding(.leading)
            }
            Text(viewModel.repoItem.description ?? "")
            
            HorizontalRepoDetailsList(items: viewModel.repoDetailsItems)
            linksList
                .padding(.trailing)
            Spacer()
        }.padding(.leading)
    }
    
    var linksList: some View {
        List {
            ForEach(viewModel.linkItems, id: \.description) { linkItem in
                Button(action: {
                    viewModel.openUrl(urlString: linkItem.urlString)
                }) {
                    HStack {
                        linkItem.image
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text(linkItem.description)
                            .font(.subheadline)
                        Spacer()
                        Image.chevronRight
                    }
                }.foregroundColor(.black)
            }
        }.listStyle(.plain)
    }
}
