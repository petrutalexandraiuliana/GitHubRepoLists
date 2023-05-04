//
//  RepoDetailsViewModel.swift
//  GitHubListApp
//
//  Created by petrut alexandra on 03.05.2023.
//

import SwiftUI

struct RepoLinkItem {
    let description: String
    let urlString: String
    let image: Image
}
final class RepoDetailsViewModel {
    
    let repoItem: RepositoryItem
    let repoDetailsItems: [RepoDetailsItem]
    let linkItems: [RepoLinkItem]
    
    private let showErrorUrlAction: () -> Void
    
    init(repoItem: RepositoryItem, showErrorUrlAction: @escaping () -> Void) {
        self.repoItem = repoItem
        self.showErrorUrlAction = showErrorUrlAction
        self.repoDetailsItems = [
               RepoDetailsItem(image: .starFill,
                                description: "starts",
                                value: "\(repoItem.stargazersCount ?? 0)"),

               RepoDetailsItem(image: .eye,
                                description: "watchers",
                                value: "\(repoItem.watchersCount ?? 0)"),

               RepoDetailsItem(image: .ant,
                                description: "issues",
                                value: "\(repoItem.openIssues ?? 0)"),

               RepoDetailsItem(image: .docOnDocFill,
                                description: "size",
                                value: "\(repoItem.size)"),

               RepoDetailsItem(image: .tuningFork,
                                description: "forks",
                                value: "\(repoItem.forks ?? 0)")
           ]

           self.linkItems = [
               RepoLinkItem(description: "Comments",
                            urlString: repoItem.commentsUrl ?? "",
                            image: .message),

               RepoLinkItem(description: "Followers",
                            urlString: repoItem.owner.followersUrl ?? "",
                            image: .person),

               RepoLinkItem(description: "Subscriptions",
                            urlString: repoItem.subscriptionUrl ?? "",
                            image: .checkmarkSealFill),

               RepoLinkItem(description: "Events",
                            urlString: repoItem.eventsUrl ?? "",
                            image: .speakerWave),

               RepoLinkItem(description: "Commits",
                            urlString: repoItem.commitsUrl ?? "",
                            image: .chevronLeftSlashChevronRight)
           ]
    }
    
    func openUrl(urlString: String) {
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        } else {
            showErrorUrlAction()
        }
    }
}
