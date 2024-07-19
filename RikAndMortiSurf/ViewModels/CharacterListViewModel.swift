//
//  CharacterListViewModel.swift
//  RickandMortySurf
//
//  Created by Максим Герасимов on 18.07.2024.
//

import Foundation
import Combine

class CharacterListViewModel: ObservableObject {
    @Published var characters: [Result] = []
    @Published var isLoading = false
    @Published var error: Error?

    private var cancellables = Set<AnyCancellable>()

    func fetchCharacters() {
        isLoading = true
        NetworkService.shared.fetchCharacterList { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let characters):
                    self?.characters = characters
                case .failure(let error):
                    self?.error = error
                }
            }
        }
    }
}

