//
//  APIService.swift
//  GitHubListApp
//
//  Created by petrut alexandra on 27.04.2023.
//

import Combine
import Foundation

let XapoURLString = "https://www.xapobank.com"
let numberOfReposPerPage = 10

private let BaseGitHubUrl = "https://api.github.com"
private let GetAllReposEndpoint = "/search/repositories"

//make pagination add details and add animation
final class APIService {
    
    func fetchTrendingRepositories(from dateStartString: String,
                                   pageNumber: Int) -> AnyPublisher<[RepositoryItem], Error> {
        
        let queryParams: [String: String] = [
            "q": "created:>\(dateStartString)",
            "sort": "stars",
            "order": "desc",
            "per_page": "\(numberOfReposPerPage)",
            "page": "\(pageNumber)"
        ]

        var urlComponents = URLComponents(string: BaseGitHubUrl + GetAllReposEndpoint)
        urlComponents?.queryItems = queryParams.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = urlComponents?.url else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        
        let session = URLSession.shared
        
        return session.dataTaskPublisher(for: url)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: RepositoryResponse.self, decoder: makeSnakeToCamelDecoder())
            .map { $0.items }
            .eraseToAnyPublisher()
    }
}


fileprivate func makeSnakeToCamelDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
}
