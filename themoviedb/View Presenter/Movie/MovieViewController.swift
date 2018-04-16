//
//  ViewController.swift
//  FastShop
//
//  Created by William Alvelos on 21/01/18.
//  Copyright © 2018 WilliamAlvelos. All rights reserved.
//

import UIKit
import XCDYouTubeKit

class MovieViewController: BaseViewController {

    //MARK:- Vars and Lets
    private let moviePresenter: MoviePresenter  = MoviePresenter()
    private var headerHeight = CGFloat(0)
    var movie : Movie = Movie()
    var video : Video = Video()
    
    var credits : Credits = Credits() {
        didSet{
            self.crewCollectionView.reloadData()
            self.castCollectionView.reloadData()
        }
    }
    
    //MARK:- IBOutlets
    @IBOutlet var crewCollectionView: UICollectionView!
    @IBOutlet var castCollectionView: UICollectionView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var headerImageView: UIImageView!
    @IBOutlet var imageHeightLayoutConstraint: NSLayoutConstraint!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var circularProgressView: CircularProgressView!
    @IBOutlet var movieOverviewLabel: UILabel!
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var playTrailerButton: UIButton!
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        moviePresenter.attachView(delegate: self)
        moviePresenter.getMovieTrailer(id: movie.id)
        
        configTitle(title: movie.title)
        navigationItem.largeTitleDisplayMode = .never
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configLayout()
    }
    
    func configLayout(){
        headerHeight = (CGFloat(282.66666665/500)) * view.frame.width
        
        updateHeaderHeight()
        
        APIManager.downloadImage(url: "https://image.tmdb.org/t/p/w500" + (movie.backdrop_path ?? "")) { (result) in
            if let image = result as? UIImage {
                self.headerImageView.image = image
            }
        }
        
        APIManager.downloadImage(url: "https://image.tmdb.org/t/p/w500" + (movie.poster_path ?? "")) { (result) in
            if let image = result as? UIImage {
                self.posterImageView.image = image
            }
        }
        
        circularProgressView.progress = CGFloat(movie.vote_average)
        
        movieOverviewLabel.text = movie.overview
        var title = NSMutableAttributedString()
        title = title.normalWhite(movie.title)
        title = title.normalGray("(" + (movie.release_date.components(separatedBy: "-").first ?? "") + ")")
        
        movieTitleLabel.attributedText = title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        moviePresenter.getMovieCredits(id: movie.id)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateHeaderHeight()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //MARK:- Methods
    
    @IBAction func actionPlayTrailer(_ sender: UIButton) {
        let videoPlayerViewController = XCDYouTubeVideoPlayerViewController(videoIdentifier: self.video.key)
        videoPlayerViewController.moviePlayer.play()

        self.present(videoPlayerViewController, animated: true, completion: nil)
    }
    
    private func updateHeaderHeight(){
        
        var heightRect = CGRect(x: -scrollView.bounds.width, y: 0, width: scrollView.bounds.width*3, height: headerHeight)
        
        if CGFloat(scrollView.contentOffset.y) < 0 {
            heightRect.origin.y = scrollView.contentOffset.y
            heightRect.size.height = headerHeight - scrollView.contentOffset.y
        }
    
        headerImageView.frame = heightRect
        
        imageHeightLayoutConstraint.constant = heightRect.maxY
    }
    
}

extension MovieViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderHeight()
    }
}

extension MovieViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.crewCollectionView {
            return self.credits.crew.count
        }else if collectionView == self.castCollectionView {
            return self.credits.cast.count
        }
        
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.crewCollectionView {
            let cell = crewCollectionView.dequeueReusableCell(withReuseIdentifier: "CrewReuseIdentifier", for: indexPath) as! CrewCollectionViewCell
            
            let crew = self.credits.crew[indexPath.row]
            
            cell.configCell(crew: crew)
            
            return cell
        }
        else {
            let cell = castCollectionView.dequeueReusableCell(withReuseIdentifier: "CastReuseIdentifier", for: indexPath) as! CastCollectionViewCell
            
            let cast = self.credits.cast[indexPath.row]
            
            cell.configCell(cast: cast)
            
            return cell
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        cell.alpha = 0
        cell.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5)
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            cell.alpha = 1
            cell.layer.transform = CATransform3DScale(CATransform3DIdentity, 1, 1, 1)
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.castCollectionView {
            return CGSize(width: 155, height: 255)
        }
        
        return CGSize(width: 75, height: 176)
    }
}

extension MovieViewController : MoviePresenterProtocol {
    
    func setErrorWith(error: Error) {
        self.present(Alert.show(error: (error as? Errors) ?? .Unknown), animated: true, completion: nil)
    }
    
    func setCredits(credits: Credits) {
        self.credits = credits
    }
    
    func setVideo(video: Video?) {
        if video == nil {
            playTrailerButton.isHidden = true
        }
        else {
            self.video = video!
            playTrailerButton.isHidden = false
        }
    }
}

