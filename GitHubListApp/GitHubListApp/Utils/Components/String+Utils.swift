//
//  String+Utils.swift
//  GitHubListApp
//
//  Created by petrut alexandra on 03.05.2023.
//

import Foundation

let ISO8601dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

extension String {
    
    func date(usingFormat: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = usingFormat
        return dateFormatter.date(from: self)
    }
}
