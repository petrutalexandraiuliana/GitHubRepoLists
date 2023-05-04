//
//  WelcomeScreenViewModel.swift
//  GitHubListApp
//
//  Created by petrut alexandra on 27.04.2023.
//

import UIKit

final class WelcomeScreenViewModel {
    let goToRepoListAction: () -> Void
    
    init(goToRepoListAction: @escaping () -> Void) {
        self.goToRepoListAction = goToRepoListAction
    }
    
    func openPrivacyAndPolicyWebLink() {
        if let url = URL(string: XapoURLString) {
            UIApplication.shared.open(url)
        }
    }
}
