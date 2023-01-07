//
//  APIConstants.swift
//  RickAndMorty
//
//  Created by Robert Shrestha on 1/7/23.
//

import Foundation
class URLBuilder {
    enum QueryItems: String {
        case page = "page"
        var value: String {
            return self.rawValue
        }
    }
    enum Paths:String {
        case character = "api/character"
        var value: String {
            return self.rawValue
        }
    }
    private var components: URLComponents
    var url = URL(string: "https://rickandmortyapi.com")!
    init() {
        self.components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
    }
    func setPath(paths: Paths) -> URLBuilder {
        var path = paths.value
        if !path.hasPrefix("/") {
            path = "/" + path
        }
        self.components.path = path
        return self
    }
    func addPageCount(withPage page:Int) -> URLBuilder {
        if self.components.queryItems == nil {
            self.components.queryItems = []
        }
        self.components.queryItems?.append(URLQueryItem(name: Self.QueryItems.page.value, value: String(page)))
        return self
    }
    func setIdPath(id: String) -> URLBuilder {
        var path = id
        if !path.hasPrefix("/") {
            path = "/" + path
        }
        let newPath = self.components.path + "/\(id)"
        self.components.path = newPath
        return self
    }

    func build() -> URL? {
        return components.url
    }

}
