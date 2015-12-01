//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Samson Brock on 11/30/15.
//  Copyright © 2015 Samson Brock. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer = try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)
    }

    @IBAction func stopAudio(sender: UIButton) {
        resetAudio()
    }
    
    @IBAction func playSlow(sender: UIButton) {
        playAudioWithRateOf(0.5)
    }
    
    @IBAction func playFast(sender: UIButton) {
        playAudioWithRateOf(1.5)
    }
    
    @IBAction func playChipmunk(sender: UIButton) {
        playAudioWithPitchOf(1000)
    }
    
    @IBAction func playVader(sender: UIButton) {
        playAudioWithPitchOf(-500)
    }
    
    func playAudioWithRateOf(rate: Float) {
        resetAudio()
        
        audioPlayer.rate = rate
        audioPlayer.play()
    }
    
    func playAudioWithPitchOf(pitch: Float) {
        resetAudio()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        
        audioPlayerNode.play()
    }
    
    func resetAudio() {
        audioPlayer.stop()
        audioPlayer.currentTime = 0.0
        audioEngine.stop()
        audioEngine.reset()
    }
}
