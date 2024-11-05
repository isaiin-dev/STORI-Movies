//
//  TopRatedMovieUITableViewCell.swift
//  StoriAppTest
//
//  Created by Alejandro Isai Acosta Martinez on 04/11/24.
//
import UIKit

enum TopRatedMovieTableViewCellType {
    case Horizontal
    case Vertical
}

class TopRatedMovieTableViewCell: UITableViewCell {
    // MARK: - Helpers
    
    public static let IDENTIFIER                = "TopRatedMovieTableViewCell"
    public static let ESTIMATED_HEIGHT: CGFloat = 250
    
    private var type: TopRatedMovieTableViewCellType = .Vertical
    
    private var imageURL: URL?
    var movie: Home.TopRatedMoviesUseCase.Result? {
        didSet {
            guard let movie = self.movie else { return }
            self.voteAverageLabel.text = movie.voteAverage.toTwoDecimalString
            self.titleLabel.text = "\(movie.releaseDate.split(separator: "-")[0]), \(movie.title)"
            self.generesLabel.text = "Horror, Comedy"
            self.favoriteButton.isFavorite = movie.isFavorite ?? false
            
            let imageUrlString = "https://image.tmdb.org/t/p/w500\(movie.backdropPath)"
            guard let url = URL(string: imageUrlString) else {
                return
            }

            imageURL = url

            ImageLoader.shared.loadImage(from: url) { [weak self] result in
                guard let self = self else { return }

                if self.imageURL != url {
                    return
                }

                switch result {
                case .success(let image):
                    self.movieImageView.image = image
                case .failure:
                    self.movieImageView.image = nil
                }
            }
        }
    }
    
    var controllerDelegate: FavoritesViewControllerDelegate?
    
    // MARK: - Custom content view
    
    private let customContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .tealGray
        view.setCornerRadius(radius: 12)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - SubViews
    
    lazy var movieImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "imagePlaceholder"))
        imageView.contentMode = .scaleAspectFill
        imageView.setCornerRadius(radius: 12)
        imageView.addTopGradientLayer(height: 150)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var voteAverageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .smDustyTeal
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 29, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .smMutedBlue
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var generesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .smMutedBlue
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 11, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var favoriteButton: FavoriteButton = {
        let button = FavoriteButton()
        button.addTarget(self, action: #selector(self.favoritesButtonAction(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Setup
    
    func setup(movie: Home.TopRatedMoviesUseCase.Result, type: TopRatedMovieTableViewCellType = .Vertical) {
        self.type = type
        self.movie = movie
        self.contentView.backgroundColor = .smLightMist
        self.contentView.addSubview(customContentView)
        self.customContentView.addSubview(movieImageView)
        self.contentView.addSubview(voteAverageLabel)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(generesLabel)
        self.contentView.addSubview(favoriteButton)
        self.setupConstraints()
    }
    
    private func setupConstraints() {
        switch type {
        case .Horizontal:
            NSLayoutConstraint.activate([
                customContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
                customContentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
                customContentView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4),
                customContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
                
                movieImageView.leadingAnchor.constraint(equalTo: customContentView.leadingAnchor),
                movieImageView.topAnchor.constraint(equalTo: customContentView.topAnchor),
                movieImageView.trailingAnchor.constraint(equalTo: customContentView.trailingAnchor),
                movieImageView.bottomAnchor.constraint(equalTo: customContentView.bottomAnchor),
                
                voteAverageLabel.leadingAnchor.constraint(equalTo: customContentView.trailingAnchor, constant: 6),
                voteAverageLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
                voteAverageLabel.widthAnchor.constraint(equalToConstant: 70),
                voteAverageLabel.heightAnchor.constraint(equalToConstant: 30),
                
                titleLabel.leadingAnchor.constraint(equalTo: customContentView.trailingAnchor, constant: 6),
                titleLabel.topAnchor.constraint(equalTo: voteAverageLabel.bottomAnchor, constant: 6),
                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -70),
                titleLabel.heightAnchor.constraint(equalToConstant: 15),
                
                generesLabel.leadingAnchor.constraint(equalTo: customContentView.trailingAnchor, constant: 6),
                generesLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
                generesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -70),
                generesLabel.heightAnchor.constraint(equalToConstant: 15),
                
                favoriteButton.widthAnchor.constraint(equalToConstant: 40),
                favoriteButton.heightAnchor.constraint(equalToConstant: 40),
                favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
                favoriteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        case .Vertical:
            NSLayoutConstraint.activate([
                customContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
                customContentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
                customContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
                customContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -49),
                
                movieImageView.leadingAnchor.constraint(equalTo: customContentView.leadingAnchor),
                movieImageView.topAnchor.constraint(equalTo: customContentView.topAnchor),
                movieImageView.trailingAnchor.constraint(equalTo: customContentView.trailingAnchor),
                movieImageView.bottomAnchor.constraint(equalTo: customContentView.bottomAnchor),
                
                voteAverageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
                voteAverageLabel.topAnchor.constraint(equalTo: customContentView.bottomAnchor, constant: 3),
                voteAverageLabel.widthAnchor.constraint(equalToConstant: 70),
                voteAverageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
                
                titleLabel.leadingAnchor.constraint(equalTo: voteAverageLabel.trailingAnchor, constant: 0),
                titleLabel.topAnchor.constraint(equalTo: customContentView.bottomAnchor, constant: 3),
                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -70),
                titleLabel.heightAnchor.constraint(equalToConstant: 25),
                
                generesLabel.leadingAnchor.constraint(equalTo: voteAverageLabel.trailingAnchor, constant: 0),
                generesLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -6),
                generesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -70),
                generesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
                
                favoriteButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 18),
                favoriteButton.topAnchor.constraint(equalTo: customContentView.bottomAnchor, constant: 9),
                favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
                favoriteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -9)
            ])
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieImageView.image = nil
        imageURL = nil
        voteAverageLabel.text = nil
        titleLabel.text = nil
        generesLabel.text = nil
        favoriteButton.isFavorite = false
        self.type = .Vertical
    }
    
    // MARK: - Actions
    
    @objc func favoritesButtonAction(_ sender: FavoriteButton) {
        guard let movie = movie else { return }
        FavoritesManager.shared.toggleFavorite(movie: movie)
        sender.isFavorite = FavoritesManager.shared.isFavorite(movie: movie)
        sender.animateButtonPress()
        controllerDelegate?.needsToUpdateTable()
    }
}
