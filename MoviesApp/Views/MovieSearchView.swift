//
//  MovieSearchView.swift
//  MoviesApp
//
//  Created by Hina on 2024/04/29.
//  Copyright © 2024 Mohammad Azam. All rights reserved.
//

import SwiftUI
// すべての映画を表示する役割を担います
struct MovieSearchView: View {
    @State var viewModel: MovieListViewModel

    init(viewModel: MovieListViewModel = MovieListViewModel()) {
        _viewModel = State(wrappedValue: viewModel)
    }

    var body: some View {
        List(viewModel.movies, id: \.self.imdbId) { movie in
            NavigationLink(
                destination: MovieDetailScreen(
                    imdbId: movie.imdbId
                )
            ) {
                MovieCell(movie: movie)
            }
        }
    }
}

struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView()
            .previewDisplayName("Default View")
    }
}
