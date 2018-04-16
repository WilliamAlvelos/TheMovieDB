//
//  GenrePresenter.swift
//  themoviedb
//
//  Created by William Alvelos on 21/01/18.
//  Copyright © 2018 WilliamAlvelos. All rights reserved.
//

import Foundation

protocol GenrePresenterProtocol: NSObjectProtocol {
    func stopRefreshControl()
    func setEmptyGenres()
    func setErrorWith(error: Error)
    func setGenres(genres: [Genre])
}

class GenrePresenter {
    weak private var delegate : GenrePresenterProtocol?
    
    func attachView(delegate: GenrePresenterProtocol) {
        self.delegate = delegate
    }
    
    func detachView() {
        delegate = nil
    }
    
    func getGenres() {
        MovieManager.getGenres(completion: { (genres) in
            genres?.count != 0 ? self.delegate?.setGenres(genres: genres ?? []) : self.delegate?.setEmptyGenres()
            self.delegate?.stopRefreshControl()
        }) { (error) in
            self.delegate?.setErrorWith(error: error)
            self.delegate?.stopRefreshControl()
        }
    }
}
