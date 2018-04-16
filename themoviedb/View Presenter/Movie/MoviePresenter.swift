//
//  MoviePresenter.swift
//  themoviedb
//
//  Created by William Alvelos on 21/01/18.
//  Copyright © 2018 WilliamAlvelos. All rights reserved.
//

import Foundation

protocol MoviePresenterProtocol: NSObjectProtocol {
    func setErrorWith(error: Error)
    func setCredits(credits: Credits)
    func setVideo(video: Video?)

}

class MoviePresenter {
    weak private var delegate : MoviePresenterProtocol?
    
    func attachView(delegate: MoviePresenterProtocol){
        self.delegate = delegate
    }
    
    func detachView() {
        delegate = nil
    }
    
    func getMovieCredits(id: Int){
        MovieManager.getCredits(movieId: id, completion: { (credits) in
            self.delegate?.setCredits(credits: credits)
        }) { (error) in
            self.delegate?.setErrorWith(error: error)
        }
    }
    
    func getMovieTrailer(id: Int){
        MovieManager.getVideo(movieId: id, completion: { (video) in
            self.delegate?.setVideo(video: video.results.first)
        }) { (error) in
            self.delegate?.setErrorWith(error: error)
        }
    }
}
