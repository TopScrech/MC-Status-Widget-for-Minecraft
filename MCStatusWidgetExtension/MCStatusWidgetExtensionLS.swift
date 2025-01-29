import WidgetKit
import SwiftUI
import MCStatusDataLayer

struct MinecraftServerStatusLSWidget1: Widget {
    let kind = "MinecraftServerStatusLSWidget1"
    
    private let supportedFamilies:[WidgetFamily] = {
        
#if targetEnvironment(macCatalyst)
        return []
#elseif os(watchOS)
        return [.accessoryCircular, .accessoryRectangular, .accessoryInline, .accessoryCorner]
#else
        return [.accessoryCircular, .accessoryRectangular, .accessoryInline]
#endif
    }()
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ServerSelectNoThemeWidgetIntent.self, provider: LockscreenProvider(widgetType: .ImageAndText)) { entry in
            MinecraftServerStatusLSWidgetEntryView(entry: entry, widgetType: .ImageAndText)
                .containerBackground(for: .widget) {}
                .widgetURL(URL(string: entry.configuration.Server?.id ?? ""))
        }
        
        .configurationDisplayName("Lockscreen Widget 1")
        .description("Widget to show the status of Minecraft Server")
        .supportedFamilies(supportedFamilies)
    }
}

struct MinecraftServerStatusLSWidget2: Widget {
    let kind = "MinecraftServerStatusLSWidget2"
    
    private let supportedFamilies: [WidgetFamily] = {
#if targetEnvironment(macCatalyst)
        []
#elseif os(watchOS)
        [.accessoryCircular]
#else
        [.accessoryCircular, .accessoryInline]
#endif
    }()
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ServerSelectNoThemeWidgetIntent.self, provider: LockscreenProvider(widgetType: .OnlyImage)) { entry in
            MinecraftServerStatusLSWidgetEntryView(entry: entry, widgetType: .OnlyImage).containerBackground(for: .widget) {}
        }
        .configurationDisplayName("Lockscreen Widget 2")
        .description("Widget to show the status of Minecraft Server")
        .supportedFamilies(supportedFamilies)
    }
}

enum LSWidgetType {
    case ImageAndText, OnlyImage
}

struct MinecraftServerStatusLSWidgetEntryView : View {
    var entry: LockscreenProvider.Entry
    var widgetType: LSWidgetType = .ImageAndText //defult
    
    @Environment(\.widgetFamily) var family
    
    @ViewBuilder
    var body: some View {
        switch family {
#if !targetEnvironment(macCatalyst)
            
        case .accessoryCircular:
            switch widgetType {
            case .ImageAndText:
                CircularAccessoryWidgetView1(entry: entry)
                
            case .OnlyImage:
                CircularAccessoryWidgetView2(entry: entry)
            }
            
        case .accessoryRectangular:
            RectangularAccessoryWidgetView(entry: entry)
            
        case .accessoryInline:
            switch widgetType {
            case .ImageAndText:
                InlineAccessoryWidgetView(entry: entry)
                
            case .OnlyImage:
                InlineAccessoryWidgetView2(entry: entry)
            }
            
        case .accessoryCorner:
            CornerAccessoryWidgetView1(entry: entry)
#endif
        @unknown default:
            Text("Not implemented")
        }
    }
}

struct ServerStatusLSSnapshotEntry: TimelineEntry {
    let date: Date
    let configuration: ServerSelectNoThemeWidgetIntent
    let vm: WidgetEntryViewModel
}
