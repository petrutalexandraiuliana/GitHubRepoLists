//
//  RepoListScreen.swift
//  GitHubListApp
//
//  Created by petrut alexandra on 28.04.2023.
//

import SwiftUI

struct RepoListScreen: View {
    
    @ObservedObject var viewModel:  RepoListViewModel
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.repos, id: \.name) { repo in
                    RepoListItemView(avatarUrl: repo.owner.avatarUrl ?? "",
                                     title: repo.name ?? "",
                                     description: repo.description ?? "",
                                     watchers: repo.watchersCount ?? 0)
                    .onTapGesture {
                        viewModel.showRepoDetailsAction(repo)
                    }
                    .onAppear {
                        viewModel.loadMoreRepos(currentShownRepo: repo)
                    }
                }
            }
            .listStyle(.plain)
        }.viewState($viewModel.viewState)
            .navigationBarTitle("Github Trending Projects", displayMode: .large)
    }
}

fileprivate struct RepoListItemView: View {
    
    @State private var animate = false

    let avatarUrl: String
    let title: String
    let description: String
    let watchers: Int
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: avatarUrl)) { image in
                     image.resizable()
                 } placeholder: {
                     Image(systemName:"person.fill")
                 }
                 .frame(width: 80, height: 80)
                 .clipShape(RoundedRectangle(cornerRadius: 25))
            Spacer()
                .frame(width: 30)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title2)
                    .lineLimit(2)
                    .foregroundColor(.blue)
                    .opacity(animate ? 1 : 0)
                    .animation(.easeIn, value: animate)
                    .onAppear { animate = true }
                
                Text(description)
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .lineLimit(2)
            }
            Spacer()
            HStack(spacing: 0) {
                Text("\(watchers)")
                    .font(.caption2)
                Image(systemName:"eye")
                    .resizable()
                    .frame(width: 10, height: 10)
                    .foregroundColor(.gray)
            }.padding(.trailing, 10)
        }
    }
}
