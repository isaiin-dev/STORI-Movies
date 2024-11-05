//
//  MovieDetailView.swift
//  StoriAppTest
//
//  Created by Alejandro Isai Acosta Martinez on 05/11/24.
//

import UIKit

class MovieDetailView: UIView {
    
    private let posterImageView = UIImageView()
    private let stackView = UIStackView()
    var delegate: MovieDetailViewControllerDelegate?
    
    private let movie: Home.TopRatedMoviesUseCase.Result
    
    init(movie: Home.TopRatedMoviesUseCase.Result) {
        self.movie = movie
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) no está implementado")
    }
}

extension MovieDetailView {
    
    private func setupViews() {
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 16
        
        addSubview(posterImageView)
        addSubview(stackView)
    }
    
    private func setupConstraints() {
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor, multiplier: 1.5),
            
            stackView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    private func configureView() {
        let imageUrlString = "https://image.tmdb.org/t/p/w500\(movie.posterPath)"
        if let url = URL(string: imageUrlString) {
            // Usa tu ImageLoader o similar para cargar la imagen
            ImageLoader.shared.loadImage(from: url) { [weak self] result in
                switch result {
                case .success(let image):
                    self?.posterImageView.image = image
                    //self?.delegate?.downloaded(image: image)
                case .failure:
                    self?.posterImageView.image = UIImage(named: "placeholder")
                }
            }
        }
        
        let properties = [
            ("Título", movie.title),
            ("Título Original", movie.originalTitle),
            ("Resumen", movie.overview),
            ("Fecha de Lanzamiento", movie.releaseDate),
            ("Calificación", "\(movie.voteAverage) (\(movie.voteCount) votos)"),
            ("Idioma Original", movie.originalLanguage),
            ("Popularidad", "\(movie.popularity)"),
            ("Adulto", movie.adult ? "Sí" : "No"),
            ("Video", movie.video ? "Sí" : "No")
        ]
        
        for (title, value) in properties {
            let propertyStack = createPropertyLabel(title: title, value: value)
            stackView.addArrangedSubview(propertyStack)
        }
    }
    
    private func createPropertyLabel(title: String, value: String) -> UIStackView {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.text = "\(title):"
        titleLabel.textColor = .smDeepTeal
        
        let valueLabel = UILabel()
        valueLabel.font = UIFont.systemFont(ofSize: 16)
        valueLabel.text = value
        valueLabel.numberOfLines = 0
        valueLabel.textColor = .smDarkSlate
        
        let propertyStack = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        propertyStack.axis = .vertical
        propertyStack.spacing = 4
        
        return propertyStack
    }
}
