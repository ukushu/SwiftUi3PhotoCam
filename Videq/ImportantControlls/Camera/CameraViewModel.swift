import SwiftUI
import Foundation
import AVFoundation

class CameraModel: NSObject, ObservableObject, AVCaptureFileOutputRecordingDelegate {
    @Published var session = AVCaptureSession()
    
    @Published var alert = false
    
    @Published var output = AVCaptureMovieFileOutput()
    
    @Published var preview: AVCaptureVideoPreviewLayer!
    
    // MARK: Video Recorder Properties
    @Published var isRecording: Bool = false
    @Published var recordedURLs: [URL] = []
    @Published var previewURL: URL?
    @Published var showPreview: Bool = false
    
    //Top Progress Bar
    @Published var recordedDuration: CFloat = 0
    // YOUR OWN TIMING
    @Published var maxDuration: CGFloat = 20
    
    func checkPermission() {
        print ("checkPermission()...")
        
        // first checking camera has got permission...
        switch AVCaptureDevice.authorizationStatus (for: .video) {
        
        case .authorized:
            self.setUp()
            return
            // Setting Up Session...
        case .notDetermined:
            AVCaptureDevice.requestAccess (for: .video) { (status) in
                if status {
                    self.setUp()
                }
            }
        case .denied:
            self.alert.toggle()
            return
        default:
            return
        }
    }
    
    func setUp() {
        print ("setUp()...")
        
        do {
            self.session.beginConfiguration ( )
            
            let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position : .back)
            let videoInput = try AVCaptureDeviceInput (device: videoDevice!)
            
            let audioDevice = AVCaptureDevice.default(for: .audio)
            let audioInput = try AVCaptureDeviceInput (device: audioDevice!)
            
            // checking and adding to session .. .
            if self.session.canAddInput(videoInput) && self.session.canAddInput(audioInput)  {
                self.session.addInput(videoInput)
                self.session.addInput(audioInput)
            }
            
            // same for output. ...
            if self.session.canAddOutput(self.output) {
                self.session.addOutput(self.output)
            }
            
            self.session.commitConfiguration()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func startRecording() {
        let tempURL = NSTemporaryDirectory() + "\(Date() ).mov"
        output.startRecording(to: URL(fileURLWithPath: tempURL) , recordingDelegate: self)
        
        isRecording = true
    }
    
    func stopRecording() {
        output.stopRecording()
        isRecording = false
    }
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        if let error = error {
            print (error.localizedDescription)
            return
        }
        
        //CREATED SUCCESSFULLY
        print(outputFileURL)
        
        self.recordedURLs.append(outputFileURL)
        
        if recordedURLs.count == 1 {
            self.previewURL = outputFileURL
            return
        }
        
        // Converting URLS to assets
        let assets = recordedURLs.compactMap{ url -> AVURLAsset in
            return AVURLAsset(url: url)
        }
        
        //self.previewURL = nil
        
//        mergeVideos(assets: assets) { exporter in
//            exporter.exportAsynchronously {
//                if exporter.status == .failed {
//                    // HANDLE error
//                    print(exporter.error!)
//                } else {
//                    if let finalURL = exporter.outputURL {
//                        print("EXPORT SUCCESS: \(finalURL)")
//                        
//                        DispatchQueue.main.async {
//                            self.previewURL = finalURL
//                        }
//                    }
//                }
//            }
//            
//        }
    }
    
    func mergeVideos(assets: [AVURLAsset], completion: @escaping (_ exporter: AVAssetExportSession) -> () ) {
        let composition = AVMutableComposition()
        var lastTime: CMTime = .zero
        
        guard let videoTrack = composition.addMutableTrack(withMediaType: .video, preferredTrackID: Int32(kCMPersistentTrackID_Invalid)),
              let audioTrack = composition.addMutableTrack(withMediaType: .audio, preferredTrackID: Int32(kCMPersistentTrackID_Invalid))
        else { return }
        
        for asset in assets {
            do {
                try videoTrack.insertTimeRange(
                    CMTimeRange(start: .zero, duration: asset.duration),
                    of: asset.tracks(withMediaType: .video)[0],
                    at: lastTime
                )
                if !asset.tracks(withMediaType: .audio).isEmpty {
                    try audioTrack.insertTimeRange(
                        CMTimeRange(start: .zero, duration: asset.duration),
                        of: asset.tracks(withMediaType: .video)[0],
                        at: lastTime
                    )
                }
            } catch {
                print(error.localizedDescription)
            }
            
            lastTime = CMTimeAdd(lastTime, asset.duration)
        }
        
        let tempURL = URL(fileURLWithPath: NSTemporaryDirectory()+"Reel-\(UUID().uuidString)-\(Date()).mp4")
        
        //Video is rotated
        // bringing back to original transform
        let layerInstructions = AVMutableVideoCompositionLayerInstruction(assetTrack: videoTrack)
        
        // transform
        var transform = CGAffineTransform.identity
        transform = transform.rotated(by: 90 * (.pi / 180) )
        transform = transform.translatedBy(x: 0, y: -videoTrack.naturalSize.height)
        layerInstructions.setTransform(transform, at: .zero)
        
        let instructions = AVMutableVideoCompositionInstruction()
        instructions.timeRange = CMTimeRange(start: .zero, duration: lastTime)
        instructions.layerInstructions = [layerInstructions]
        
        let videoComposition = AVMutableVideoComposition()
        videoComposition.renderSize = CGSize(width: videoTrack.naturalSize.height, height: videoTrack.naturalSize.width)
        videoComposition.instructions = [instructions]
        videoComposition.frameDuration = CMTimeMake(value: 1, timescale: 30)
        
        guard let exporter = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetHighestQuality)
        else { return }
        
        exporter.outputFileType = .mp4
        exporter.outputURL = tempURL
        exporter.videoComposition = videoComposition
        completion(exporter)
    }
}
