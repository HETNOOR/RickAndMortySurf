//
//  NoConnectionView.swift
//  RickandMortySurf
//
//  Created by Максим Герасимов on 20.07.2024.
//

import SwiftUI

struct NoConnectionView: View {
    let retryAction: () -> Void
    
    var body: some View {
        VStack {
            Image("connection-error-rick-morty (1) 1")
            Text("Network Error")
                .font(.title)
                .bold()
               
            Text("There was an error connecting.\n Please check your internet.")
                .font(.subheadline)
                .padding(.bottom)
            Button(action: retryAction) {
                Text("Retry")
                    .frame(width: 200)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(16)
                    .bold()
            }
            
        }
        .padding()
    }
}

struct NoConnectionView_Previews: PreviewProvider {
    static var previews: some View {
        NoConnectionView(retryAction: {})
    }
}
