import SwiftUI
import AVFoundation
import Foundation
import Introspect

struct VideoCamView: View {
    @Binding var isPhotoMode: Bool
    
    @StateObject var camera = CameraModel()
    
    
    var body: some View {
        ZStack {
            
            VStack {
                HStack {
                    Spacer()
                    BtnPhotoVideoSwitcher(isPhotoMode: $isPhotoMode)
                }
                
                TeleprompterView()
                    .background(Color(red: 0.5, green: 0.5, blue: 0.5, opacity: 0.2))
                
                Spacer()
            }
        }
    }
}

struct TeleprompterView: View {
    @ObservedObject var telepVm = TeleprompterViewModel()
    
    @State var displaySettings = false
    @State var editMode = false
    
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    TeleprompterView()
                }
                
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        
                        Button(action: { displaySettings.toggle() }) {
                            Image(systemName: "gear")
                        }
                        .padding( 5)
                    }
                }
            }
            
            if displaySettings {
                SettingsView()
                    .padding(.vertical)
                    .padding(.horizontal, 15)
            }
        }
        .frame(height: 350, alignment: .top)
        .onAppear(){
            autoScroll()
        }
    }
    
    func TeleprompterView() -> some View {
        VStack {
            if editMode {
                VStack {
                    TextEditor(text: $telepVm.text)
                    
                    HStack (spacing: 20){
                        Button(action: { editMode.toggle(); telepVm.position.y = Globals.teleprompterSafeArea } ) { Text("Close") }
                        Button(action: { telepVm.text = "" } ) { Text("Clear") }
                        //Button(action: { telepVm.text = "" } ) { Text("Paste") }
                    }
                }
            } else {
                Text(telepVm.text)
                    .font(.system(size: telepVm.textSize))
                    .frame(width: UIScreen.screenWidth - 7)
                    .foregroundColor(telepVm.color)
                    .padding(.top, Globals.teleprompterSafeArea)
                    .padding(.bottom, 500)
                    .background(Color(red: 0.1, green: 0.1, blue: 0.1, opacity: 0.1))
                    .fixedSize(horizontal: false, vertical: true)
                    .offset( x: 0, y: telepVm.position.y + telepVm.dragOffset.y )
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                telepVm.userDragging = true
                                telepVm.dragOffset.y = gesture.translation.height
                            }
                            .onEnded { gesture in
                                telepVm.userDragging = false
                                telepVm.position.y = telepVm.position.y + gesture.translation.height
                                
                                if telepVm.position.y > Globals.teleprompterSafeArea {
                                    telepVm.position.y = Globals.teleprompterSafeArea
                                }
                                
                                telepVm.dragOffset = .zero
                            }
                    )
                    .padding(.horizontal, 7)
            }
        }
        .frame(height: 350, alignment: .top)
        .clipShape(Rectangle())
        .background(Color(red: 0.1, green: 0.1, blue: 0.1, opacity: 0.1))
        .onTapGesture(count: 2) { editMode.toggle() }
    }
    
    func SettingsView() -> some View {
        VStack {
            VStack {
                SpeedSlider()
                
                HStack {
                    ColorPicker(selection: $telepVm.color) { EmptyView() }
                        .frame(width: 25)
                        .padding(.trailing, 5)
                    
                    TextSizeSlider()
                }
            }
        }
    }
}

extension TeleprompterView {
    func autoScroll() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation{
                if telepVm.position.y < Globals.teleprompterSafeArea/2 && !telepVm.userDragging {
                    telepVm.position.y -= telepVm.speed
                }
            }
            
            autoScroll()
        }
    }
}

extension TeleprompterView {
    func SpeedSlider() -> some View {
        HStack {
            Text(Image(systemName: "tortoise"))
            
            BoundsSlider(min: 0.7, max: 5, value: $telepVm.speed)
            
            Text(Image(systemName: "hare"))
        }
        
    }
    
    func TextSizeSlider() -> some View {
        HStack {
            Text("a")
                .font(.system(size: 20))
            
            BoundsSlider(min: 15, max: 45, value: $telepVm.textSize)
            
            Text("A")
                .font(.system(size: 20))
        }
    }
    
}

class TeleprompterViewModel: ObservableObject {
    @Published var dragOffset: CGPoint = .zero
    @Published var position: CGPoint = CGPoint(x: 0, y: 60)
    
    @Published var textSize: CGFloat = 20
    @Published var color: Color = .yellow
    
    @Published var text: String = Globals.defaultText
    
    @Published var speed: CGFloat = 0.7
    //@Published var lastSpeed: CGFloat = 0.7
    
    @Published var userDragging: Bool = false
}

public class Globals {
    static var teleprompterSafeArea: CGFloat = 40
    
    static var defaultText =
"""
Цей текст написаний спеціально з тестовою ціллю, що би ти, мій любий друже, міг перевірити на скільки добре працює програма.

Тобі здається що цей текст безсенсовний, але насправді цей текст переповнений сенсом, адже ти його не просто так вирішив прочитати до кінця

Значить він, таки, тебе чимось чіпляє. Ніби то як тут переливання з пустого у порожнє, але, все таки, щось в цьому є, чи не так?

Щось мені підказує що тобі вже набридло, але ж тобі все ще цікаво читати, адже ти читаєш. Ти справді надієшся на те що далі щось зміниться?

НЕ ЗМІНИТЬСЯ.

Все буде рівно так же як було завжди до цього.

Хіба що смайлики додадуться. Чи емодзі, чи як там говориться у поріджів. 😄

Здавалося б, це тупо безсенсовна трата часу, але ти для чогось це продовжуєш читати. Ти просто псих. Ти довбаний псих. І я довбаний псих.

Ми підходимо один одному. З нас вийшла б чудова пара, мені здається. Я молов би безсенсовну чуш, а ти б її читав би або слухав би. Сімейна ідилія.

Ну от і все... Настав час прощатися....

*наспівую* Оообійми мене, обійми мене, обійми....

Чому ти не хочеш обійматися?

Ізвращуга.

Ну все, па-па.
"""
}


extension UIScreen {
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}
