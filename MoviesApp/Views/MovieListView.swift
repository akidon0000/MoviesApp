//
//  MovieListScreen.swift
//  MoviesApp
//
//  Created by Hina on 2024/04/29.
//  Copyright © 2024 Mohammad Azam. All rights reserved.
//

import SwiftUI

struct MovieListView: View {
    @State private var movieName: String = ""
    @StateObject private var viewModel: MovieSearchViewModel

    init(viewModel: MovieSearchViewModel = MovieSearchViewModel()) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Search", text: $movieName) {
                    viewModel.fetchMoviesByTitleName(movieName)
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())

                Spacer()

                switch viewModel.loadingState {
                case .loading:
                    LoadingView()

                case .success:
                    List(viewModel.movies, id: \.self.imdbId) { movie in
                        NavigationLink(
                            destination: MovieDetailScreen(
                                imdbId: movie.imdbId
                            )
                        ) {
                            MovieCell(movie: movie)
                        }
                    }

                case .failed:
                    FailedView()

                case .none:
                    EmptyView()
                }
            }
            .navigationTitle("Movies")
            .padding()
        }
    }
}

#Preview {
    MovieListView()
}
