//
//  ApiManager.swift
//  RickandMortySurf
//
//  Created by Максим Герасимов on 17.07.2024.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()
    private let baseURL = "https://rickandmortyapi.com/api"

    func fetchCharacterList(completion: @escaping (Result<[Result], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/character") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let characterListResponse = try JSONDecoder().decode(CharacterListResponse.self, from: data)
                completion(.success(characterListResponse.results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchCharacterDetails(id: Int, completion: @escaping (Result<Result, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/character/\(id)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let character = try JSONDecoder().decode(Result.self, from: data)
                completion(.success(character))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
