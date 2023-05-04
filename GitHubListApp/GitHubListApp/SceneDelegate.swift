//
//  SceneDelegate.swift
//  GitHubListApp
//
//  Created by petrut alexandra on 28.04.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private var coordinator: GitHubListCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: windowScene)
        self.coordinator = GitHubListCoordinator(window: self.window)
        self.coordinator?.start()
        
        windowScene.delegate = self
        
    }
}
