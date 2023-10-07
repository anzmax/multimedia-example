import UIKit
import AVFoundation

final class MusicViewController: UIViewController {
    
    var tracks = ["Dorian Marko - Cornfield Chase", "Kate Bush - Running Up That Hill", "Kyle Dixon & Michael Stein - Stranger Things", "The XX - Intro", "Korsi - Our Names"]
    
    var urls: [URL] = []
    var currentIndex = 0
    
    private var audioPlayer: AVAudioPlayer!
    
    lazy var playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.tintColor = .lightGray
        button.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var forwardButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "forward.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .lightGray
        button.addTarget(self, action: #selector(forwardTrack), for: .touchUpInside)
        return button
    }()
    
    lazy var backwardButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "backward.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .lightGray
        button.addTarget(self, action: #selector(backwardTrack), for: .touchUpInside)
        return button
    }()
    
    var trackLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.text = "Your track name"
        return label
    }()
    
    var videoLayer: UIView = {
        let layer = UIView()
        return layer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupAudioPlayer()
        playVideo()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(videoLayer)
        view.addSubview(playButton)
        view.addSubview(forwardButton)
        view.addSubview(backwardButton)
        view.addSubview(trackLabel)
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 50),
            playButton.heightAnchor.constraint(equalToConstant: 50),
            
            forwardButton.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 16),
            forwardButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            forwardButton.heightAnchor.constraint(equalToConstant: 50),
            forwardButton.widthAnchor.constraint(equalToConstant: 50),
            
            backwardButton.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -16),
            backwardButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            backwardButton.heightAnchor.constraint(equalToConstant: 50),
            backwardButton.widthAnchor.constraint(equalToConstant: 50),
            
            trackLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            trackLabel.bottomAnchor.constraint(equalTo: playButton.topAnchor, constant: -42),
            
            videoLayer.topAnchor.constraint(equalTo: view.topAnchor),
            videoLayer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            videoLayer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            videoLayer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ])
    }
    
    private func setupAudioPlayer() {
        
        for track in tracks {
            guard let url = Bundle.main.url(forResource: track, withExtension: "mp3") else { return }
            urls.append(url)
        }
        
        do {
            trackLabel.text = tracks[currentIndex]
            try audioPlayer = AVAudioPlayer(contentsOf: urls[currentIndex])
            setupAudioSession()
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    @objc func forwardTrack() {
        
        currentIndex += 1
        
        if currentIndex > 4 {
            currentIndex = 0
        }
        
        trackLabel.text = tracks[currentIndex]
        let url = urls[currentIndex]
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: url)
            audioPlayer.play()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @objc func backwardTrack() {
        
        currentIndex -= 1
        
        if currentIndex < 0 {
            currentIndex = 0
        }
        
        trackLabel.text = tracks[currentIndex]
        let url = urls[currentIndex]
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: url)
            audioPlayer.play()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func setupAudioSession() {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(.soloAmbient)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @objc func playButtonTapped() {
        if audioPlayer.isPlaying {
            audioPlayer.stop()
            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        } else {
            audioPlayer.play()
            audioPlayer.currentTime = 0
            playButton.setImage(UIImage(systemName: "stop.fill"), for: .normal)
            
        }
    }
    
    func playVideo() {
        guard let path = Bundle.main.path(forResource: "Black-Abstract", ofType: "MP4") else { return }
        
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.bounds
        playerLayer.videoGravity = .resizeAspectFill
        self.videoLayer.layer.addSublayer(playerLayer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(videoDidEnd), name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        
        player.play()
    }
    
    @objc func videoDidEnd() {
        if let player = videoLayer.layer.sublayers?.first as? AVPlayerLayer {
            player.player?.seek(to: CMTime.zero)
            player.player?.play()
        }
    }
}

