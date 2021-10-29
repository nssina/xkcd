//
//  FavoritesDetailView.swift
//  xkcd
//
//  Created by Sina Rabiei on 10/28/21.
//

import SwiftUI

struct FavoritesDetailView: View {
    var favorite: Favorite
    @State private var isShowingSafari = false
    
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    Text(favorite.title!)
                        .font(.custom(CustomFont.xkcd, size: 20))
                    
                    Image(uiImage: UIImage(data: favorite.image!)!)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(8)
                    
                    HStack {
                        FavoriteButtonsView(comic: favorite, id: Int(favorite.id))
                        Spacer()
                        Button {
                            isShowingSafari.toggle()
                            HapticGenerator.shared.soft()
                        } label: {
                            HStack {
                                Text("Explanation")
                                    .font(.custom(CustomFont.xkcd, size: 17))
                                    .foregroundColor(.blue)
                                Image(systemName: SFSymbols.arrow)
                                    .font(Font.body.weight(.bold))
                                    .foregroundColor(.blue)
                            }
                        }.fullScreenCover(isPresented: $isShowingSafari) {
                            SafariView(url: favorite.explainURL!)
                                .ignoresSafeArea()
                        }
                    }
                    .padding()
                    
                    HStack {
                        Text("#\(favorite.id): ")
                            .foregroundColor(.orange)
                        +
                        Text(favorite.alt!)
                            .font(.custom(CustomFont.xkcd, size: 17))
                    }
                    .padding()
                    
                    Text(favorite.date!)
                        .font(.custom(CustomFont.xkcd, size: 13))
                        .foregroundColor(.secondary)
                    
                    Spacer()
                }
                .padding(.top, 30)
                
                Spacer()
            }
        }
        .navigationTitle("Comic")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { HapticGenerator.shared.light() }
    }
}

struct FavoritesDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let preview = PersistenceController.preview.container.viewContext
        FavoritesDetailView(favorite: Favorite(context: preview))
    }
}

struct FavoriteButtonsView: View {
    @State private var isShowingShareSheet = false
    private let network = NetworkManager.shared
    
    var comic: Favorite
    var id: Int
    
    var body: some View {
        HStack {
            Button {
                isShowingShareSheet.toggle()
                HapticGenerator.shared.soft()
            } label: {
                Image(systemName: SFSymbols.send)
                    .resizable()
                    .foregroundColor(.primary)
                    .frame(width: 25, height: 25)
            }
            .sheet(isPresented: $isShowingShareSheet) {
                ShareSheet(activityItems: [UIImage(data: comic.image!)!, comic.title!, comic.alt!])
            }
        }
    }
}
