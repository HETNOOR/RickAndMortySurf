//
//  ApiManager.swift
//  RickandMortySurf
//
//  Created by Максим Герасимов on 17.07.2024.
//


import Foundation

enum NetworkError: Error {
    case noMorePages
    case other(Error)
}

class NetworkService {
    static let shared = NetworkService()
    private let baseURL = "https://rickandmortyapi.com/api"

    func fetchCharacterList(page: Int, name: String? = nil, status: String? = nil, species: String? = nil, type: String? = nil, gender: String? = nil, completion: @escaping (Result<[Character], NetworkError>) -> Void) {
        var urlString = "\(baseURL)/character?page=\(page)"
        
        // Append filters to the URL if provided
        var filters = [String]()
        if let name = name { filters.append("name=\(name)") }
        if let status = status { filters.append("status=\(status)") }
        if let species = species { filters.append("species=\(species)") }
        if let type = type { filters.append("type=\(type)") }
        if let gender = gender { filters.append("gender=\(gender)") }
        
        if !filters.isEmpty {
            urlString += "&" + filters.joined(separator: "&")
        }
        
        guard let url = URL(string: urlString) else { return }
        print(url)
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.other(error)))
                return
            }
            
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let errorMessage = json["error"] as? String,
                   errorMessage == "There is nothing here" {
                    completion(.failure(.noMorePages))
                } else {
                    let characterListResponse = try JSONDecoder().decode(CharacterListResponse.self, from: data)
                    completion(.success(characterListResponse.results))
                    print("dataSuccess")
                }
            } catch {
                completion(.failure(.other(error)))
                print("dataERROR")
            }
        }.resume()
    }
    
    func fetchCharacterDetails(id: Int, completion: @escaping (Result<Character, NetworkError>) -> Void) {
        guard let url = URL(string: "\(baseURL)/character/\(id)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.other(error)))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let character = try JSONDecoder().decode(Character.self, from: data)
                completion(.success(character))
            } catch {
                completion(.failure(.other(error)))
            }
        }.resume()
    }
}

