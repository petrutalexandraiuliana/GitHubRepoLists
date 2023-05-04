//
//  GitHubListCoordinator.swift
//  GitHubListApp
//
//  Created by petrut alexandra on 27.04.2023.
//

import SwiftUI

final class GitHubListCoordinator {
    
    private var window: UIWindow?
    private let navigationController = UINavigationController()
    private let apiService = APIService()
    
    init(window: UIWindow?) {
        self.window = window
        self.window?.makeKeyAndVisible()
    }
    
    func start() {
        let welcomeScreenViewModel = WelcomeScreenViewModel(goToRepoListAction: { [weak self] in
            self?.showReposScreen()
        })
        let welcomeScreenVC = UIHostingController(rootView: WelcomeScreen(viewModel: welcomeScreenViewModel))
        window?.rootViewController = welcomeScreenVC
    }
    
    private func showReposScreen() {
        let reposViewModel = RepoListViewModel(apiService: apiService,
                                               showRepoDetailsAction: { [weak self] repo in
            self?.showRepoDetails(repo: repo)
        })
        let reposVC = UIHostingController(rootView: RepoListScreen(viewModel: reposViewModel))
        navigationController.viewControllers = [reposVC]
        window?.rootViewController = navigationController
    }
    
    private func showRepoDetails(repo: RepositoryItem) {
        let repoDetailsViewModel = RepoDetailsViewModel(repoItem: repo, showErrorUrlAction: { [weak self] in
            self?.showErrorUrlAlert()
        })
        let repoDetailsScreen = RepoDetailsScreen(viewModel: repoDetailsViewModel)
        navigationController.pushViewController(UIHostingController(rootView: repoDetailsScreen), animated: true)
    }
    
    private func showErrorUrlAlert() {
        let alertController = UIAlertController(title: "Unable to open URL", message: "Sorry, the URL cannot be opened.", preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)

        alertController.addAction(cancelAction)
        alertController.addAction(okAction)

        navigationController.present(alertController, animated: true, completion: nil)
    }
}
