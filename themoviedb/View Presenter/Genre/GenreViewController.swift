//
//  GenreViewController.swift
//  FastShop
//
//  Created by William Alvelos on 21/01/18.
//  Copyright © 2018 WilliamAlvelos. All rights reserved.
//

import UIKit

class GenreViewController: BaseViewController {
    
    //MARK:- Vars and Lets
    private let genrePresenter: GenrePresenter  = GenrePresenter()
    private let refreshControl = UIRefreshControl()
    private var genres : [Genre] = [Genre]() {
        didSet{
            self.genresTableViewController.reloadData()
        }
    }
    
    
    //MARK:- IBOutlets
    @IBOutlet var genresTableViewController: UITableView!
    @IBOutlet var errorView: UIView!
    @IBOutlet var errorLabel: UILabel!
    
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTitle(title: "Movies")
        
        genrePresenter.attachView(delegate: self)
        genrePresenter.getGenres()
        
        addRefreshControlAtTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- Methods
    
    private func addRefreshControlAtTableView() {
        refreshControl.tintColor = UIColor.awesome
        
        refreshControl.addTarget(self, action: #selector(refreshGenresData), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            genresTableViewController.refreshControl = refreshControl
        } else {
            genresTableViewController.addSubview(refreshControl)
        }
    }
    
    @objc private func refreshGenresData() {
        genrePresenter.getGenres()
    }


    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let movieViewController = segue.destination as? MovieViewController {
            movieViewController.movie = sender as? Movie ?? Movie()
        }
    }
}

extension GenreViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.genres.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let genreCell = genresTableViewController.dequeueReusableCell(withIdentifier: "GenreReuseIdentifier") as! GenreTableViewCell
            
        let genre = self.genres[indexPath.row]

        genreCell.delegate = self
        
        genreCell.configCellWith(genre)
        
        return genreCell
    }
    
}

extension GenreViewController : GenreTableViewCellProtocol {
    func showMovieWith(movie: Movie){
        self.performSegue(withIdentifier: "showMovieViewControllerIdentifier", sender: movie)
    }
    
}


//MARK:- Presenter
extension GenreViewController : GenrePresenterProtocol {

    func stopRefreshControl() {
        self.refreshControl.endRefreshing()
    }
    
    func setEmptyGenres() {
        UIView.animate(withDuration: 0.5) {
            self.errorView.isHidden = false
            self.errorLabel.text = "Nao Encontramos o resultado"
        }
    }
    
    func setErrorWith(error: Error) {
        
        UIView.animate(withDuration: 0.5) {
            self.errorView.isHidden = false
            self.errorLabel.text = Errors.validade(error: error as NSError)
        }
    }
    
    func setGenres(genres: [Genre]) {
        self.genres = genres
    }
}


