import SwiftUI
import AVFoundation

struct ContentView: View {
    var body: some View {
        MainAppView()
    }
}

struct MainAppView: View {
    @StateObject var camera = CameraModel()
    
    var body: some View {
        ZStack{
            CameraView(camera: camera)
                .ignoresSafeArea(.all, edges: .all)
            
            VStack {
                Spacer()
                
                HStack {
                    if camera.isTaken {
                        BtnSave() { camera.savePhoto() }
                        
                        Spacer()
                        
                        BtnDiscard() { camera.discardPhoto() }
                    } else {
                        BtnTakePhoto() { camera.takePhoto() }
                    }
                }
                .frame (height: 75)
            }
        }
        .onAppear { camera.check() }
    }
}

///////////////////
// HELPERS
//////////////////
fileprivate struct BtnDiscard: View {
    var action: () -> ()
    
    var body: some View {
        Button (action : { action() } ){
            Text ("Discard")
                .foregroundColor(.black)
                .fontWeight (.semibold)
                .padding (.vertical, 10)
                .padding (.horizontal, 20)
                .background (Color.white)
                .clipShape (Capsule())
                .padding (.leading)
        }
    }
}

fileprivate struct BtnSave: View {
    var action: () -> ()
    
    var body: some View {
        Button (action : { action() } ){
            Text ("Save")
                .foregroundColor(.black)
                .fontWeight (.semibold)
                .padding (.vertical, 10)
                .padding (.horizontal, 20)
                .background (Color.white)
                .clipShape (Capsule())
                .padding (.leading)
        }
    }
}

fileprivate struct BtnTakePhoto: View {
    var action: () -> ()
    
    var body: some View {
        Button (action : { action() }, label: { MakeShotButtonLabel() })
    }
                
    func MakeShotButtonLabel() -> some View {
        ZStack{
            Circle ()
                .fill (Color . white)
                .frame (width: 65, height: 65)
            
            Circle()
                .stroke(Color.white, lineWidth: 2)
                .frame (width: 75, height: 75)
        }
    }
}
