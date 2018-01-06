//
//  ViewController.swift
//  TheVoice
//
//  Created by Kimaya Desai on 1/6/18.
//  Copyright © 2018 SDSU. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate{

    @IBOutlet var textView: UITextView!
    @IBOutlet var spinner: UIActivityIndicatorView!
    var audioPlayer: AVAudioPlayer!
    
    @IBAction func buttonPressed(_ sender: AnyObject) {
        spinner.isHidden = false
        spinner.startAnimating()
        requestSpeech()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.isHidden = true
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
        spinner.stopAnimating()
        spinner.isHidden = true
    }
    
    func requestSpeech(){
        SFSpeechRecognizer.requestAuthorization { authStatus in
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized {
                if let path = Bundle.main.url(forResource: "test", withExtension: "m4a"){
                    do {
                        let sound = try AVAudioPlayer(contentsOf : path)
                        self.audioPlayer = sound
                        self.audioPlayer.delegate = self
                        sound.play()
                    }
                    catch{
                        print("Error")
                    }
                    
                    // recognizer request and result
                    
                    let recognizer = SFSpeechRecognizer()
                    let request = SFSpeechURLRecognitionRequest(url:path)
                    recognizer?.recognitionTask(with: request){(result,error) in
                        if let error = error {
                            print("There was an error \(error)")
                        }
                        else{
                            self.textView.text = result?.bestTranscription.formattedString
                            print(result?.bestTranscription.formattedString)
                        }
                        
                    }
                }
                
            }
        }
    }
    
}

