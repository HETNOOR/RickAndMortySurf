import SwiftUI

struct CharacterListView: View {
    @StateObject private var viewModel = CharacterListViewModel()
    @StateObject private var networkMonitor = NetworkMonitor()
    
    @State private var searchText: String = ""
    @State private var selectedStatus: String? = nil
    @State private var selectedSpecies: String? = nil
    @State private var selectedType: String? = nil
    @State private var selectedGender: String? = nil
    
    @State private var showingSettings = false
    
    var body: some View {
        NavigationView {
            VStack {
                if networkMonitor.isConnected {
                    HStack {
                        TextField("\( Image(systemName: "magnifyingglass"))Search", text: $searchText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .onChange(of: searchText) { newValue in
                                viewModel.searchName = newValue.isEmpty ? nil : newValue
                                viewModel.search()
                            }
                        
                        Button(action: {
                            showingSettings.toggle()
                        }) {
                            Image(systemName: "slider.horizontal.3")
                                                       
                        }
                        .padding(.trailing)
                    }
                
                    
                    if viewModel.characters.isEmpty && !viewModel.isLoading {
                                                  Image("Group 2")
                                                  .resizable()
                                                  .scaledToFit()
                                                      .padding()
                                              
                                          }
                        
                    ScrollView {
                        LazyVStack {
                                ForEach(viewModel.characters, id: \.id) { character in
                                    NavigationLink(destination: CharacterDetailView(characterId: character.id)) {
                                        TableRow(character: character)
                                    }
                                }
                                
                                if viewModel.isLoading {
                                    ProgressView()
                                        .padding()
                                } else if viewModel.noMorePages && !viewModel.characters.isEmpty {
                                    Text("No more characters")
                                        .padding()
                                } else {
                                    Color.clear
                                        .onAppear {
                                            viewModel.fetchCharacters()
                                        }
                                }
                        
                        }
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                                           ToolbarItem(placement: .principal) {
                                               Text("Rick & Morty Characters")
                                                   .font(.system(size: 20, weight: .bold))
                                           }
                                       }
                    .onAppear {
                        if viewModel.characters.isEmpty {
                            viewModel.fetchCharacters()
                        }
                    }
                } else {
                    NoConnectionView {
                        networkMonitor.checkConnection()
                    }
                }
            }
            .padding(.top,0)
            .sheet(isPresented: $showingSettings) {
                FilterSettingsView(
                    viewModel: viewModel,
                    selectedStatus: $selectedStatus,
                    selectedGender: $selectedGender
                )
                .presentationDetents([.medium])
            }
        }
       
        .onAppear {
            networkMonitor.checkConnection()
        }
    }
}

struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView()
    }
}
