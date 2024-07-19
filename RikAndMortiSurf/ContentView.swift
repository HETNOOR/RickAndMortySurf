//
//  ContentView.swift
//  RickandMortySurf
//
//  Created by Максим Герасимов on 17.07.2024.
//

//import SwiftUI
//
//struct ContentView: View {
//    var body: some View {
//        
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
//        }
//        .padding()
//    }
//}




import SwiftUI

struct ContentView: View {
    
//    @StateObject private var viewModel:RickAndMortyViewModel=RickAndMortyViewModel()
    
    var body: some View {
        
        NavigationView {
            VStack{
//                switch viewModel.charactersState{
                    
//                case .initial:
//                    ProgressView()
//                case .loading:
//                    ProgressView()
//                case .error(let error):
//                    Text(error)
//                case .loaded(let data):
                    ScrollView{
//                        ForEach(data.results){ results in
                            
                            HStack {
//                                AsyncImage(url: URL(string: results.image)){ image in
//                                    image.resizable()
//                                        .cornerRadius(25)
                                    
//                                }
                                Image(systemName: "globe")
//                                placeholder: {
//                                    ProgressView()
//                                }
//                                .frame(width: 50, height: 50)
                                VStack(alignment:.leading) {
//                                    Text(results.name)
                                    Text("name")
                                        .font(.headline)
                                        .fontWeight(.medium)
//                                    Text(results.gender)
                                    Text("gender")
                                        .font(.subheadline)
                                        .fontWeight(.regular)
                                }
                                .frame(maxWidth:.infinity,maxHeight:.infinity,alignment:.leading)
//                                Text(results.species)
                        Text("species")
                                    .font(.footnote)
                                    .fontWeight(.light)
                            }
                            .padding()
                            
                        }
            } .navigationTitle("Rick & Morty Characters")
        }
      
    }
        
}

//    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 12 mini")
    }
}
#Preview {
    ContentView()
}
