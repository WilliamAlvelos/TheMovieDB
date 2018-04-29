//
//  GenreTableViewCell.swift
//  themoviedb
//
//  Created by William Alvelos on 21/01/18.
//  Copyright © 2018 WilliamAlvelos. All rights reserved.
//

import UIKit

protocol GenreTableViewCellProtocol {
    func showMovieWith(movie: Movie)
}

class GenreTableViewCell: UITableViewCell {

    //MARK:- Vars and Lets
    let reuseId = "MoviesCollectionReuseIdentifier"
    private var page = 0
    private var hasMorePages = true
    private var baseMovie: Movies?
    private var baseGenre: Genre?
    
    var movies : [Movie] = [Movie]() {
        didSet{
            self.moviesCollectionView.reloadData()
        }
    }
    
    var delegate : GenreTableViewCellProtocol?
    
    //MARK:- IBOutlets
    @IBOutlet var genreTitleLabel: UILabel!
    @IBOutlet var moviesCollectionView: UICollectionView!
    @IBOutlet var moviesHeightLayoutConstraint: NSLayoutConstraint!
    
    //MARK:- Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configCellWith(_ genre: Genre){
        self.baseGenre = genre
        self.genreTitleLabel.text = genre.name
        
        loadMoreData()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.movies = []
        page = 0
        hasMorePages = true
        baseMovie = nil
    }
    
    private func loadMoreData() {
        page += 1
        
        guard baseMovie?.total_pages ?? 1 >= page else {
            hasMorePages = false
            return
        }
        
        MovieManager.getMovies(genreId: baseGenre?.id ?? 0, page: page, completion: { (movies) in
            self.baseMovie = movies
            self.movies += movies.results ?? []
        }, error: { (error) in
            print(error.domain)
        })
    }
}

extension GenreTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as! MovieCollectionViewCell
        
        cell.activityIndicator.startAnimating()
        
        cell.movieImageView.image = nil
        
        cell.configureCell(with: "https://image.tmdb.org/t/p/w500/" + (self.movies[indexPath.row].poster_path ?? ""))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.showMovieWith(movie: movies[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == self.movies.count - 1 && hasMorePages {
            self.loadMoreData()
        }
    }
    
}
