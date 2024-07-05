import UIKit
import AVFoundation

class ViewController: UIViewController {
    var player : AVAudioPlayer!
    let eggTimes : [String : Int] = ["Soft": 300, "Medium" : 420, "Hard" : 720]
    var timer : Timer?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var timePassed : Int = 0
    var timeTotal : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer?.invalidate()
        timePassed = 0
        progressBar.progress = 0.0
        
        let hardness = sender.currentTitle
        timeTotal = eggTimes[hardness!]!
        startTimer()
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        if timePassed < timeTotal {
            timePassed += 1
            progressBar.progress = Float(timePassed)/Float(timeTotal)
            titleLabel.text = "Time remained: \(timeTotal-timePassed) seconds"
        } else {
            playSound()
            timer?.invalidate()
            titleLabel.text = "Time is up!"
        }
    }
    
    func playSound() {
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
            }

}

