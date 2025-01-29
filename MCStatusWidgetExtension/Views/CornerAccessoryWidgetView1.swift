import SwiftUI
import Intents
import WidgetKit

struct CornerAccessoryWidgetView1 : View {
    var entry: LockscreenProvider.Entry
    
    var iconSize = 27.0
    
    var body: some View {
#if !targetEnvironment(macCatalyst)
        ZStack {
            if let statusIcon = entry.viewModel.statusIcon {
                Image(systemName: statusIcon)
                    .fontSize(iconSize)
                    .widgetAccentable()
                
            } else if entry.viewModel.viewType == .Unconfigured {
                Text("...")
            } else {
                if #available(iOSApplicationExtension 18, watchOS 11, *) {
                    Image(uiImage: entry.viewModel.icon)
                        .resizable()
                        .widgetAccentedRenderingMode(WidgetAccentedRenderingMode.accentedDesaturated)
                        .scaledToFit().frame(width: iconSize, height: iconSize)
                        .padding(0)
                        .widgetAccentable()
                } else {
                    Image(uiImage: entry.viewModel.icon)
                        .resizable()
                        .scaledToFit().frame(width: iconSize, height: iconSize)
                        .padding(0)
                        .widgetAccentable()
                }
            }
            
            Button(intent: RefreshWidgetIntent()) {
                Color.clear
            }
            .buttonStyle(.plain)
        }
        .padding(0)
        .widgetLabel {
            Gauge(value: entry.viewModel.progressValue) {
                Text("")
            } currentValueLabel: {
                Text("")
            } minimumValueLabel: {
                Text(String(entry.viewModel.playersOnline)) // Watch out for clipping)
            } maximumValueLabel: {
                Text(String(entry.viewModel.playersMax)) // Watch out for clipping
            }
            .tint(Color(hex: "#2159ad"))
            .gaugeStyle(.accessoryLinearCapacity).widgetAccentable()
        }
#endif
    }
}
