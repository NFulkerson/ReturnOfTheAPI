//
//  Endpoint.swift
//  ReturnOfTheAPI
//
//  Created by Nathan on 11/1/17.
//  Copyright © 2017 Nathan. All rights reserved.
//

import Foundation

protocol Endpoint {
    var base: String { get }
    var path: String { get }
}

extension Endpoint {
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        return components
    }

    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }
}

enum Swapi {
    case request(resource: SwapiResource, id: Int)
    case list(resource: SwapiResource)
}

enum SwapiResource {
    case character
    case starship
    case vehicle
    case film
    case planet
    case species
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
            switch resource {
            case .character: return "/api/people/"
            case .starship: return "/api/starships/"
            case .vehicle: return "/api/vehicles/"
            case .film: return "/api/films/"
            case .planet: return "/api/planets/"
            case .species: return "/api/species/"
            }
        }
    }

}
