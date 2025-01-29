import SwiftUI
import WidgetKit

struct CustomProgressView: View {
    var progress: CGFloat
    var bgOpactiy = 1.0
    var bgColor = Color.gray
    var filledColor = Color.green
    
    var body: some View {
        GeometryReader { geometry in
            let height = geometry.size.height
            let width = geometry.size.width
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(bgColor)
                    .frame(width: width, height: height)
                    .cornerRadius(height / 2)
                    .opacity(bgOpactiy)
                
                Rectangle()
                    .foregroundColor(filledColor)
                    .frame(width: width * self.progress, height: height)
                    .cornerRadius(height / 2)
                    .animation(.easeInOut(duration: 0.5), value: progress)
                    .widgetAccentable()
                
            }
        }
    }
}
