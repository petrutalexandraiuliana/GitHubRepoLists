//
//  ViewStateContainer.swift
//  GitHubListApp
//
//  Created by petrut alexandra on 28.04.2023.
//

import SwiftUI

public enum ViewState: Equatable {
    case `default`
    case loading(text: String)
    case generalLoading
    case noResultsFound
}

public protocol ViewStateProvider: AnyObject {
    var viewState: ViewState { get set }
}

public extension View {
    func viewState(_ state: Binding<ViewState>) -> some View {
        modifier(ViewStateModifier(state: state))
    }
}

fileprivate struct ViewStateModifier: ViewModifier {
    @Binding var state: ViewState
    
    func body(content: Content) -> some View {
        ViewStateContainer(state: $state, mainView: { content })
    }
}

fileprivate struct ViewStateContainer<MainView: View>: View {
    @Binding var state: ViewState
    let mainView: () -> MainView
    
    var body: some View {
        switch state {
        case .default:
            return AnyView(mainView())
        case let .loading(text):
            return AnyView(LoadingView(text: text))
        case .generalLoading:
            return AnyView(LoadingView(text: "Loading"))
        case .noResultsFound:
            return AnyView(NoResultsView())
        }
    }
    
}

