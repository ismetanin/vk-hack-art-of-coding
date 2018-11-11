//
//  AppleSpeechKitManager.swift
//  ARLocatorTest
//
//  Created by Gregory Berngardt on 10/11/2018.
//  Copyright © 2018 gregoryvit. All rights reserved.
//

import Foundation
import Speech

class AppleSpeechKitManager {
    
    let audioEngine = AVAudioEngine()
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer(locale: Locale(identifier: "ru_RU"))
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    var isRecording = false
    
    public func start(_ textHandler: ((String) -> Void)?) {
        if isRecording {
            request.endAudio()
            audioEngine.stop()
            
            let node = audioEngine.inputNode
            node.removeTap(onBus: 0)
            recognitionTask?.cancel()
            
            isRecording = false
            
        } else {
            self.recordAndRecognizeSpeech(textHandler)
            isRecording = true
        }
    }
    
    public func stop() {
        isRecording = false

        request.endAudio()
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionTask?.cancel()
    }
    
    public func requestSpeechAuthorization(_ result: @escaping (Bool) -> Void) {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    result(true)
                case .denied:
                    result(false)
                    print("User denied access to speech recognition")
                case .restricted:
                    result(false)
                    print("Speech recognition restricted on this device")
                case .notDetermined:
                    result(false)
                    print("Speech recognition not yet authorized")
                }
            }
        }
    }
    
    private func recordAndRecognizeSpeech(_ textChangeHandler: ((String) -> Void)?) {
        let node = audioEngine.inputNode
        
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self.request.append(buffer)
        }
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            print("ERROR: There has been an audio engine error.")
            return print(error)
        }
        guard let myRecognizer = SFSpeechRecognizer() else {
            print("ERROR: Speech recognition is not supported for your current locale.")
            return
        }
        if !myRecognizer.isAvailable {
            print("ERROR: Speech recognition is not currently available. Check back at a later time.")
            return
        }

        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { result, error in
            if result != nil {
                if let result = result {
                    let bestString = result.bestTranscription.formattedString
//                    print("Identified text: \(bestString)")
                    if self.isRecording {
                        textChangeHandler?(bestString)
                    }
                } else if let error = error {
                    print("ERROR: There has been a speech recognition error.")
                    print(error)
                }
            }
        })
    }
}
