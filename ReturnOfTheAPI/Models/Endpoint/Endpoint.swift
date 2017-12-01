//
//  Endpoint.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 11/1/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import Foundation
import RealmSwift

protocol Endpoint {
    var base: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
}

extension Endpoint {
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.queryItems = queryItems
        return components
    }

    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }

    var url: URL {
        return urlComponents.url!
    }

    var resource: SwapiResource {
        return SwapiResource(rawValue: urlComponents.path)!
    }
}

enum Swapi {
    case request(resource: SwapiResource, id: Int)
    case list(resource: SwapiResource)
    case pagedUrl(urlString: String)
}

enum SwapiResource: String {
    case character = "/api/people/"
    case starship = "/api/starships/"
    case vehicle = "/api/vehicles/"
    case film = "/api/films/"
    case planet = "/api/planets/"
    case species = "/api/species/"

    var model: Object.Type {
        switch self {
        case .character:
            return Character.self
        case .starship:
            return Starship.self
        case .vehicle:
            return Vehicle.self
        case .film:
            return Film.self
        case .planet:
            return Planet.self
        case .species:
            return Species.self
        }
    }

}

extension Swapi: Endpoint {
    var base: String {
        return "https://swapi.co"
    }

    var path: String {
        switch self {
        case .request(let resource, let id):
            var requestPath: String
            switch resource {
            case .character: requestPath = "people"
            case .starship: requestPath = "starships"
            case .vehicle: requestPath = "vehicles"
            case .film: requestPath = "films"
            case .planet: requestPath = "planets"
            case .species: requestPath = "species"
            }
            return "/api/\(requestPath)/\(id)/"
        case .list(let resource):
            return resource.rawValue
        case .pagedUrl(let urlString):
            guard let urlComponents = URLComponents(string: urlString) else {
                return "/"
            }
            return urlComponents.path
        }
    }

    var queryItems: [URLQueryItem] {
        switch self {
        case .pagedUrl(let urlString):
            guard let urlComponents = URLComponents(string: urlString), let queryItems = urlComponents.queryItems else {
                return []
            }
            return queryItems
        default:
            return []
        }
    }

}
