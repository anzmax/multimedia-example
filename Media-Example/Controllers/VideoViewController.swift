import UIKit

final class VideoViewController: UIViewController {
    
    var videoData: [(title: String, videoURL: URL)] = [
        ("Основы управления памятью", URL(string: "https://www.youtube.com/watch?v=9oQ5lE9nH48")!),
        ("Swift Keywords", URL(string: "https://www.youtube.com/watch?v=bBXdXmUobMw&list=PL8seg1JPkqgHx8DgGsHB4Dh_H_78x8oQE")!),
        ("POST-запрос", URL(string: "https://www.youtube.com/watch?v=CD_bWZSUBxY")!),
        ("Mad Brains Техно", URL(string: "https://www.youtube.com/watch?v=uEeFqIUXJcE")!),
        ("Лайвкодинг: JMVC FTW! / Евгений Елчев", URL(string: "https://www.youtube.com/watch?v=sM-AaI32hTc&list=PLNSmyatBJig4ScUXL-iJh63tZr1DhTVuN&index=6")!),
    ]
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "VideoCell")
            
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(tableView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}

extension VideoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath)
        cell.textLabel?.text = videoData[indexPath.row].title
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedVideoURL = videoData[indexPath.row].videoURL
        let youtubePlayerVC = YouTubeViewController(videoURL: selectedVideoURL)
        navigationController?.pushViewController(youtubePlayerVC, animated: true)
    }
}





