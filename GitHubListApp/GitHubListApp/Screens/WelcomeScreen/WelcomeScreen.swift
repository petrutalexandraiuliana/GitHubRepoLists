//
//  WelcomeScreen.swift
//  GitHubListApp
//
//  Created by petrut alexandra on 27.04.2023.
//

import SwiftUI

struct WelcomeScreen: View {
    
    let viewModel: WelcomeScreenViewModel
    
    @State private var scale = 0.5

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.xapoGrey
                VStack(alignment: .center, spacing: 25) {
                    HStack {
                        Spacer()
                        Text("Go to Xapo")
                            .font(.footnote)
                            .bold()
                            .onTapGesture {
                                viewModel.goToRepoListAction()
                            }
                    }.padding(.top, 40)
                    Spacer()
                    
                    Image.logo
                        .resizable()
                        .frame(width: 100, height: 100)
                        .scaleEffect(scale)
                        .animation(.linear(duration: 1), value: scale)
                        .onAppear {
                            scale = 1
                        }

                    Text("Welcome to iOS Test")
                        .font(.largeTitle)
                    Text("iOS Test for Xapo App")
                    Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy")
                    Spacer()
                    
                    Button(action: {
                        viewModel.goToRepoListAction()
                    }) {
                        Text("Enter the App")
                            .padding(.horizontal, 0.04 * geo.size.width)
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(Color.xapoOrange)
                    .cornerRadius(25)
                    
                    VStack(alignment: .center) {
                        Text("Privacy")
                            .underline() +
                        Text(" and") +
                        Text(" Terms of use").underline()
                    }.padding(.bottom, 50)
                        .onTapGesture {
                            viewModel.openPrivacyAndPolicyWebLink()
                        }
                    
                }.foregroundColor(.white)
                    .padding(.horizontal, 0.13 * geo.size.width)
                    .multilineTextAlignment(.center)
            }.edgesIgnoringSafeArea(.all)
        }
    }
}

struct WelcomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen(viewModel: WelcomeScreenViewModel(goToRepoListAction: {}))
    }
}
