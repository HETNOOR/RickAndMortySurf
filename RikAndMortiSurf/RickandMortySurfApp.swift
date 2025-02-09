//
//  RickandMortySurfApp.swift
//  RickandMortySurf
//
//  Created by Максим Герасимов on 17.07.2024.
//

import SwiftUI

@main
struct RikAndMortiSurfApp: App {
    var body: some Scene {
        WindowGroup {
            CharacterListView()
                .preferredColorScheme(.dark)
        }
    }
}
