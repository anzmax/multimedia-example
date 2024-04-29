import UIKit

final class VideoViewController: UIViewController {
    
    var videoData: [(title: String, videoURL: URL)] = [
        ("ARC", URL(string: "https://www.youtube.com/watch?v=VcoZJ88d-vM")!),
        ("How to build a UICollectionView", URL(string: "https://www.youtube.com/watch?v=SR7DtcT61tA")!),
        ("Generic Networking Layer in iOS apps", URL(string: "https://www.youtube.com/watch?v=Eo3WkbUV-fU")!),
        ("SwiftUI: Build macOS App", URL(string: "https://www.youtube.com/watch?v=6Qa-SspgRMM")!),
        ("Solving Problems", URL(string: "https://www.youtube.com/watch?v=Emfz7eOUqaQ")!),
    ]
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGray5
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
        view.backgroundColor = .systemGray5
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





