import UIKit
import AVFoundation

final class RecordViewController: UIViewController {
    
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    
    lazy var recordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Record", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 40
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(recordButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var playRecordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        button.setTitleColor(.gray, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 30
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(playRecordButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupAudioSession()
        setupAudioRecorder()
    }
    
    private func setupViews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        
        let selectedColors: [CGColor] = [
            UIColor.lightGray.cgColor,
            UIColor.systemGray2.cgColor,
            UIColor.systemGray3.cgColor,
            UIColor.systemGray5.cgColor,
        ]
        
        gradientLayer.colors = selectedColors
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        view.layer.addSublayer(gradientLayer)
        
        view.addSubview(recordButton)
        view.addSubview(playRecordButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            recordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recordButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 330),
            recordButton.widthAnchor.constraint(equalToConstant: 80),
            recordButton.heightAnchor.constraint(equalToConstant: 80),
            
            playRecordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playRecordButton.topAnchor.constraint(equalTo: recordButton.bottomAnchor, constant: 16),
            playRecordButton.widthAnchor.constraint(equalToConstant: 60),
            playRecordButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    private func setupAudioSession() {
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playAndRecord, mode: .default)
            try session.setActive(true)
        } catch {
            print("Failed to configure audio session: \(error.localizedDescription)")
        }
    }
    
    private func setupAudioRecorder() {
        let audioSettings: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 2,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            let audioURL = getDocumentsDirectory().appendingPathComponent("audioRecording.m4a")
            audioRecorder = try AVAudioRecorder(url: audioURL, settings: audioSettings)
            audioRecorder?.prepareToRecord()
        } catch {
            print("Failed to initialize audio recorder: \(error.localizedDescription)")
        }
    }
    
    @objc func recordButtonTapped() {
        if let audioRecorder = audioRecorder {
            if !audioRecorder.isRecording {
                audioRecorder.record()
                recordButton.setTitle("Stop", for: .normal)
            } else {
                audioRecorder.stop()
                recordButton.setTitle("Record", for: .normal)
            }
        }
    }
    
    @objc func playRecordButtonTapped() {
        if let audioURL = audioRecorder?.url {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: audioURL)
                audioPlayer?.play()
            } catch {
                print("Failed to play audio: \(error.localizedDescription)")
            }
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
