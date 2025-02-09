//
//  CharacterDetailViewModel.swift
//  RickandMortySurf
//
//  Created by Максим Герасимов on 18.07.2024.
//

import Foundation
import Combine

class CharacterDetailViewModel: ObservableObject {
    @Published var character: Character?
    @Published var isLoading = false
    @Published var error: Error?

    private var cancellables = Set<AnyCancellable>()

    func fetchCharacterDetails(id: Int) {
        isLoading = true
        NetworkService.shared.fetchCharacterDetails(id: id) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let character):
                    self?.character = character
                case .failure(let error):
                    self?.error = error
                }
            }
        }
    }
}
