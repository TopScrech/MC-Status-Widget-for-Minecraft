import SwiftUI
import Intents
import WidgetKit

struct InlineAccessoryWidgetView2 : View {
    var entry: LockscreenProvider.Entry
    
    var body: some View {
#if !targetEnvironment(macCatalyst)
        HStack(spacing: 3) {
            Button(intent: RefreshWidgetIntent()) {
                if entry.vm.viewType == .Unconfigured {
#if os(watchOS)
                    Text("...")
#else
                    Text("Edit Widget")
#endif
                } else {
                    Text(entry.vm.progressString)
                }
            }
            .buttonStyle(.plain)
            
            if let statusIcon = entry.vm.statusIcon {
                Image(systemName: statusIcon)
                    .fontSize(18)
                    .widgetAccentable()
            } else if entry.vm.viewType != .Unconfigured {
                let imageNumber = 50// min(100, max(0, Int((entry.vm.progressValue * 100).rounded(.towardZero))))
                let imageName = "ProgressBar\(imageNumber)"
                
                if let uiImage = UIImage(named: imageName) {
                    Image(uiImage:  uiImage).padding().widgetAccentable()
                }
            }
        }
#endif
    }
}
