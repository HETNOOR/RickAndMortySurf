//
//  CharacterListViewModel.swift
//  RickandMortySurf
//
//  Created by Максим Герасимов on 18.07.2024.
//

//import Foundation
//import Combine
//

import Combine
import SwiftUI

class CharacterListViewModel: ObservableObject {
    @Published var characters = [Character]()
    @Published var isLoading = false
    @Published var noMorePages = false
    private var currentPage = 1
    
    
    @Published var searchName: String? = nil
    @Published var status: String? = nil
    @Published var species: String? = nil
    @Published var type: String? = nil
    @Published var gender: String? = nil

    func fetchCharacters(reset: Bool = false) {
        if reset {
            currentPage = 1
            characters.removeAll()
            noMorePages = false
        }
        
        guard !isLoading && !noMorePages else { return }
        
        isLoading = true
        
        NetworkService.shared.fetchCharacterList(
            page: currentPage,
            name: searchName,
            status: status,
            species: species,
            type: type,
            gender: gender
        ) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success(let newCharacters):
                    self.characters.append(contentsOf: newCharacters)
                    print(self.characters.capacity)
                    if newCharacters.isEmpty {
                        self.noMorePages = true
                    } else {
                        self.currentPage += 1
                    }
                case .failure(let error):
                    switch error {
                    case .noMorePages:
                        self.noMorePages = true
                    case .other(let error):
                        print("Error fetching characters: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    
    func search() {
        fetchCharacters(reset: true)
    }
}

