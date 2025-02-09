//
//  TableRow.swift
//  RickandMortySurf
//
//  Created by Максим Герасимов on 19.07.2024.
//

import SwiftUI

struct TableRow: View {
    let character: Character
   
    var body: some View {
        GroupBox {
            HStack {
                AsyncImage(url: URL(string: character.image)) {
                    ProgressView()
                } image: { image in
                    image
                        .resizable()
                }
                .frame(width: 64, height: 64)
                .cornerRadius(10)

                VStack(alignment: .leading) {
                    Text(character.name)
                        .font(.headline)
                    HStack {
                        Text("\(character.status.rawValue)")
                            .foregroundColor(colorForStatus(character.status))
                            .font(.subheadline)
                        Text("• \(character.species)")
                            .font(.subheadline)
                    }
                    Text(character.gender.rawValue)
                        .font(.subheadline)
                    
                }

                Spacer()
                
            }
            
            
        }
        .cornerRadius(24)
        .foregroundColor(.primary)
        .padding(.horizontal, 20)
        
    }

    private func colorForStatus(_ status: Status) -> Color {
        switch status {
        case .alive:
            return .green
        case .dead:
            return .red
        case .unknown:
            return .primary
        }
    }
}


