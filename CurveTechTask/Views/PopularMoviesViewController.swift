import UIKit

class PopularMoviesViewController: UIViewController {

    let popularMoviesView = PopularMoviesView()
    let dataProvider: DataProvider
    var sessionDataTask: SessionDataTask?

    var movies: [Movie] = []

    init(dataProvider: DataProvider = NetworkClient()) {
        self.dataProvider = dataProvider
        super.init(nibName: nil, bundle: nil)
    }

    deinit {
        sessionDataTask?.cancel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = popularMoviesView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Popular Movies"
        popularMoviesView.setTableView(delegate: self, dataSource: self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        fetchMovies()
    }

    func fetchMovies() {
        sessionDataTask = dataProvider.fetchData(with: .popularMoviesURL(at: 1)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                let popularMovies = try? JSONDecoder.popularMoviesDecoder.decode(PopularMovies.self, from: data)
                self.movies = popularMovies?.results ?? []
                DispatchQueue.main.async {
                    self.popularMoviesView.updateView()
                }
            case .failure:
                return
            }
        }
        sessionDataTask?.resume()
    }
}

extension PopularMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.reuseIdentifier) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        tableViewCell.updateView(.init(title: movies[indexPath.row].originalTitle, releaseDate: movies[indexPath.row].releaseDate, overview: movies[indexPath.row].overview))
        return tableViewCell
    }
}
