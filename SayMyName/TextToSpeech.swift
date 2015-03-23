//
//  TextToSpeech.swift
//  SayMyName
//
//  Created by David Attarzadeh on 3/22/15.
//  Copyright (c) 2015 DavidAttarzadeh. All rights reserved.
//

import UIKit
import AVFoundation

class TextToSpeech: NSObject {
    class func SayText(input: String) {
        var synth: AVSpeechSynthesizer = AVSpeechSynthesizer()
        var utterance: AVSpeechUtterance = AVSpeechUtterance(string: input)
        utterance.rate = (AVSpeechUtteranceMinimumSpeechRate) * 0.25
        utterance.volume = 1
        utterance.pitchMultiplier = 1
        synth.speakUtterance(utterance)
    }
}
