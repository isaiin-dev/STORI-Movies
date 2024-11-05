//
//  HomeInteractorTest.swift
//  StoriAppTest
//
//  Created by Alejandro Isai Acosta Martinez on 05/11/24.
//

import XCTest
@testable import STORI_Movies

class HomeInteractorTests: XCTestCase {
    var interactor: HomeInteractor!
    var presenterMock: PresenterMock!

    override func setUp() {
        super.setUp()
        presenterMock = PresenterMock()
        
        interactor = HomeInteractor()
        interactor.presenter = presenterMock
    }

    override func tearDown() {
        interactor = nil
        presenterMock = nil
        super.tearDown()
    }

    func testFetchTopRatedMoviesSuccess() {
        // Configura el mock para devolver una respuesta simulada exitosa
        let mockMovies = Home.TopRatedMoviesUseCase.Response(
            page: 1,
            results: [
                Home.TopRatedMoviesUseCase.Result(
                    adult: false,
                    backdropPath: "/zfbjgQE1uSd9wiPTX4VzsLi0rGG.jpg",
                    genreIDS: [18, 80],
                    id: 278,
                    originalLanguage: "en",
                    originalTitle: "The Shawshank Redemption",
                    overview: "Imprisoned in the 1940s for the double murder of his wife and his lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope.",
                    popularity: 215.543,
                    posterPath: "/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg",
                    releaseDate: "1994-09-23",
                    title: "The Shawshank Redemption",
                    video: false,
                    voteAverage: 8.7,
                    voteCount: 27053,
                    isFavorite: nil // Puedes asignar `true` o `false` según necesites
                ),
                Home.TopRatedMoviesUseCase.Result(
                    adult: false,
                    backdropPath: "/6xKCYgH16UuwEGAyroLU6p8HLIn.jpg",
                    genreIDS: [18, 80],
                    id: 238,
                    originalLanguage: "en",
                    originalTitle: "The Godfather",
                    overview: "Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch Vito Corleone barely survives an attempt on his life, his youngest son, Michael, steps in to take care of the would-be killers, launching a campaign of bloody revenge.",
                    popularity: 196.246,
                    posterPath: "/3bhkrj58Vtu7enYsRolD1fZdja1.jpg",
                    releaseDate: "1972-03-14",
                    title: "The Godfather",
                    video: false,
                    voteAverage: 8.7,
                    voteCount: 20461,
                    isFavorite: nil
                )
            ],
            totalPages: 1,
            totalResults: 2
        )

        interactor.worker.mockResponse = mockMovies
        workerMock.shouldReturnError = false

        // Llama al método de descarga
        interactor.fetchTopRatedMovies()

        // Verifica que el presenter haya recibido la respuesta correcta
        XCTAssertTrue(presenterMock.didCallPresentMoviesResponse, "El presenter debería haber llamado a presentMoviesResponse")
        XCTAssertEqual(presenterMock.receivedMovies, mockMovies, "El presenter debería haber recibido la respuesta correcta de películas")
        XCTAssertFalse(presenterMock.didCallPresentFailure, "El presenter no debería llamar a presentFailure en caso de éxito")
    }

    func testFetchTopRatedMoviesFailure() {
        // Configura el mock para simular un error de red
       workerMock.shouldReturnError = true

       // Llama al método de descarga
       interactor.fetchTopRatedMovies()

       // Verifica que el presenter haya recibido el mensaje de error
       XCTAssertTrue(presenterMock.didCallPresentFailure, "El presenter debería haber llamado a presentFailure en caso de error")
       XCTAssertNotNil(presenterMock.receivedErrorMessage, "El presenter debería haber recibido un mensaje de error")
       XCTAssertFalse(presenterMock.didCallPresentMoviesResponse, "El presenter no debería llamar a presentMoviesResponse en caso de error")
    }
}
