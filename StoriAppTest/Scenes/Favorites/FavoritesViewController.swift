//
//  FavoritesViewController.swift
//  StoriAppTest
//
//  Created by Alejandro Isai Acosta Martinez on 04/11/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This layer contains the UI logic (display, update, animate…) and 
//  responsible for intercepting the user’s action and send it to the 
//  presenter. Most importantly, it has no business logic.
//
//  This file was generated by the IsaiinDev's iOS Templates so
//  you can apply clean architecture to your iOS projects.
//

import UIKit

protocol FavoritesDisplayLogic: ViewLayer {
    func display(movies: [Home.TopRatedMoviesUseCase.Result])
	func displayFailure(message: String)
}

protocol FavoritesViewControllerDelegate {
    func needsToUpdateTable()
}

class FavoritesViewController: UIViewController {
	// MARK: - Properties
	
	lazy var interactor: FavoritesBusinessLogic = {
		return self._interactor as! FavoritesBusinessLogic
	}()
    
    private var movies = [Home.TopRatedMoviesUseCase.Result]() {
        didSet {
            DispatchQueue.mainAsync {
                self.moviesTable.reloadData()
            }
        }
    }

	// MARK: - SubViews
    
    lazy var moviesTable: UITableView = {
        let table = UITableView()
        table.backgroundColor = .smLightMist
        table.showsVerticalScrollIndicator = false
        table.showsHorizontalScrollIndicator = false
        table.separatorStyle = .singleLine
        table.separatorColor = .smDustyTeal
        table.allowsSelection = true
        table.register(TopRatedMovieTableViewCell.self, forCellReuseIdentifier: TopRatedMovieTableViewCell.IDENTIFIER)
        table.delegate = self
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

	// MARK: - Object Lifecycle

	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		setup()
	}
  
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}	

	// MARK: - View Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		self.setupView()
        view.addSubview(moviesTable)
		self.setupConstraints()
	}
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.interactor.fetchFavorites()
    }

	// MARK: - Setup

	private func setup() {
		self.setup(
			interactor: FavoritesInteractor(),
			router: FavoritesRouter(),
			presenter: FavoritesPresenter()
		)
	}

	private func setupView() {
        view.backgroundColor = .smLightMist
        configureNavigationBarAppearance(title: "Favorites")
	}

	private func setupConstraints() {
		NSLayoutConstraint.activate([
            moviesTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moviesTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            moviesTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moviesTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
	}

	// MARK: - Actions 
}

extension FavoritesViewController: FavoritesDisplayLogic {
    func display(movies: [Home.TopRatedMoviesUseCase.Result]) {
        self.movies = movies
    }

	func displayFailure(message: String) {
		print("Something went wrong: \(message)")
	}
}

extension FavoritesViewController: FavoritesViewControllerDelegate {
    func needsToUpdateTable() {
        DispatchQueue.mainAsync {
            self.interactor.fetchFavorites()
        }
    }
}

// MARK: - MoviesTable delegates

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TopRatedMovieTableViewCell.IDENTIFIER, for: indexPath) as! TopRatedMovieTableViewCell
        var movie = movies[indexPath.row]
        movie.isFavorite = FavoritesManager.shared.isFavorite(movie: movie)
        cell.controllerDelegate = self
        cell.setup(movie: movie, type: .Horizontal)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TopRatedMovieTableViewCell.ESTIMATED_HEIGHT / 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = self.movies[indexPath.row]
        self.interactor.goToMovieDetail(movie: movie)
    }
}
