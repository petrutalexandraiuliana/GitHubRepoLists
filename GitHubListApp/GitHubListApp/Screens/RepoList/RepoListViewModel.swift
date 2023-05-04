//
//  RepoListViewModel.swift
//  GitHubListApp
//
//  Created by petrut alexandra on 28.04.2023.
//

import Foundation
import Combine

final class RepoListViewModel: ObservableObject {
    
    @Published var repos: [RepositoryItem] = []
    @Published var viewState: ViewState = .default
    
    private let apiService: APIService
    private var cancellablesSet: Set<AnyCancellable> = Set()
    private var currentPageNumber = 0
    
    let showRepoDetailsAction: (RepositoryItem) -> Void

    init(apiService: APIService, showRepoDetailsAction: @escaping (RepositoryItem) -> Void) {
        self.apiService = apiService
        self.showRepoDetailsAction = showRepoDetailsAction
        fetchRepos(pageNumber: currentPageNumber)
    }
    
    private func fetchRepos(pageNumber: Int) {
        let dateStart = Date.getStartOfYear().formattedDateString(format: YearMonthDayFormatISO8601)
        if pageNumber == 0 {
            viewState = .generalLoading
        }
        apiService
            .fetchTrendingRepositories(from: dateStart, pageNumber: pageNumber)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.viewState = .noResultsFound
                    print("Error fetching trending repositories: \(error.localizedDescription)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] repos in
                
                if pageNumber == 0 {
                    self?.repos = repos
                } else {
                    self?.repos.append(contentsOf: repos)
                }
                
                if repos.count > 0 {
                    self?.viewState = .default
                } else {
                    self?.viewState = .noResultsFound
                }
            })
            .store(in: &cancellablesSet)
    }
    
    func loadMoreRepos(currentShownRepo: RepositoryItem) {
        if currentShownRepo.id == repos.last?.id ?? 0 {
            currentPageNumber = currentPageNumber + 1
            fetchRepos(pageNumber: currentPageNumber)
        }
    }
    
}
