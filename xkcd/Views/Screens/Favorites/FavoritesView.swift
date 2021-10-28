//
//  FavoritesView.swift
//  xkcd
//
//  Created by Sina Rabiei on 10/26/21.
//

import SwiftUI

struct FavoritesView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Favorite.title, ascending: true)], animation: .default)
    private var favorites: FetchedResults<Favorite>
    
    var body: some View {
        NavigationView {
            if favorites.isEmpty {
                Text("No Favorites?\nAdd one on the home screen.")
                    .multilineTextAlignment(.center)
                    .font(.custom(CustomFont.xkcd, size: 28))
                    .foregroundColor(.secondary)
                    .navigationTitle("Favorites")
            } else {
                List {
                    ForEach(favorites) { item in
                        NavigationLink(destination: FavoritesDetailView(favorite: item)) {
                            FavoriteCell(comic: item)
                        }
                    }
                    .onDelete(perform: deleteItem)
                    .listRowBackground(Color(UIColor.secondarySystemBackground))
                }
                .listStyle(InsetGroupedListStyle())
                .onAppear {
                    UITableView.appearance().backgroundColor = UIColor.systemBackground
                }
                .toolbar {
                    EditButton()
                }
                .navigationTitle("Favorites")
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func deleteItem(index: IndexSet) {
        withAnimation {
            index.map { favorites[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
                HapticGenerator.shared.success()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
