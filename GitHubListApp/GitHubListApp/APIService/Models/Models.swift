//
//  Models.swift
//  GitHubListApp
//
//  Created by petrut alexandra on 27.04.2023.
//

import Foundation

struct RepositoryItem: Decodable {
    let id: Int
    let name: String?
    let url: String?
    let description: String?
    let language: String?
    let forks: Int?
    let openIssues: Int?
    let watchersCount: Int?
    let owner: Owner
    let stargazersCount: Int?
    let size: Int
    let archived: Bool?
    let updatedAt: String?
    let commentsUrl: String?
    let commitsUrl: String?
    let eventsUrl: String?
    let subscriptionUrl: String?
}

struct Owner: Decodable {
    let avatarUrl: String?
    let login: String?
    let followersUrl: String?
}

struct RepositoryResponse: Decodable {
    let totalCount: Int
    let items: [RepositoryItem]
}
