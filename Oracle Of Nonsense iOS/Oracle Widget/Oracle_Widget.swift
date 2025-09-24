//
//  Oracle_Widget.swift
//  Oracle Widget
//
//  Created by Dillon Butler on 9/4/25.
//

import WidgetKit
import SwiftUI
import OracleSharedFramework

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> OracleEntry {
        OracleEntry(date: Date(), phrase: "The oracle is silent today.")
    }

    func getSnapshot(in context: Context, completion: @escaping (OracleEntry) -> ()) {
        let entry = OracleEntry(date: Date(), phrase: PhraseGenerator.shared.generateWidgetPhrase())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [OracleEntry] = []

        // Generate a timeline with entries every 15 minutes, starting from the current date.
        let currentDate = Date()
        for minuteOffset in 0 ..< 96 { // 24 hours worth of entries (24 * 4 = 96 entries)
            let entryDate = Calendar.current.date(byAdding: .minute, value: minuteOffset * 15, to: currentDate)!
            let entry = OracleEntry(date: entryDate, phrase: PhraseGenerator.shared.generateWidgetPhrase())
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct OracleEntry: TimelineEntry {
    let date: Date
    let phrase: String
}

struct Oracle_WidgetEntryView : View {
    var entry: Provider.Entry
    @State private var stars: [WidgetStar] = []
    @Environment(\.widgetFamily) var family

    var body: some View {
        ZStack {
            // Starry background
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.06, green: 0.07, blue: 0.19), // --bg-1
                    Color(red: 0.03, green: 0.04, blue: 0.11)  // --bg-2
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            // Static stars - positioned behind everything
            ForEach(stars, id: \.id) { star in
                Circle()
                    .fill(Color.white)
                    .frame(width: star.size, height: star.size)
                    .position(star.position)
                    .opacity(star.opacity)
            }
            
            
            // Geometry reader to get dimensions for star generation
            GeometryReader { geometry in
                Color.clear
                    .onAppear {
                        generateStars(geometry: geometry)
                    }
                    .onChange(of: geometry.size) { _, newSize in
                        generateStars(geometry: geometry)
                    }
            }
            
            // Main content varies by widget family
            Group {
                switch family {
                case .systemSmall:
                    VStack(spacing: 6) {
                        Image("crystal-ball")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 56, height: 56)
                            .shadow(color: .white.opacity(0.25), radius: 8, x: 0, y: 0)
                            .shadow(color: .black, radius: 0, x: 1, y: 1)
                            .background(Color.clear)

                        Text(entry.phrase)
                            .font(.system(size: 11, weight: .regular, design: .monospaced))
                            .foregroundColor(Color(red: 0.91, green: 0.95, blue: 1.0))
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .shadow(color: .black, radius: 0, x: 1, y: 1)
                            .background(Color.clear)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(8)
                    .background(Color.clear)

                case .systemLarge:
                    HStack(spacing: 12) {
                        // Crystal Ball on the left (larger)
                        Image("crystal-ball")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 120, height: 120)
                            .shadow(color: .white.opacity(0.25), radius: 12, x: 0, y: 0)
                            .shadow(color: .black, radius: 0, x: 1, y: 1)
                            .background(Color.clear)

                        // Phrase content on the right (more space and lines)
                        VStack(alignment: .leading, spacing: 8) {
                            Text(entry.phrase)
                                .font(.system(size: 19, weight: .regular, design: .monospaced))
                                .foregroundColor(Color(red: 0.91, green: 0.95, blue: 1.0))
                                .multilineTextAlignment(.leading)
                                .lineLimit(6)
                                .shadow(color: .black, radius: 0, x: 1, y: 1)
                                .background(Color.clear)

                            Text("and I'm always saying that...")
                                .font(.system(size: 12, weight: .regular, design: .monospaced))
                                .foregroundColor(Color(red: 0.62, green: 0.68, blue: 0.82))
                                .shadow(color: .black, radius: 0, x: 1, y: 1)
                                .background(Color.clear)
                        }
                        .background(Color.clear)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 14)
                    .background(Color.clear)

                default:
                    HStack(spacing: 8) {
                        // Crystal Ball on the left
                        Image("crystal-ball")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .shadow(color: .white.opacity(0.25), radius: 10, x: 0, y: 0)
                            .shadow(color: .black, radius: 0, x: 1, y: 1)
                            .background(Color.clear)

                        // Phrase content on the right
                        VStack(alignment: .leading, spacing: 4) {
                            Text(entry.phrase)
                                .font(.system(size: 15, weight: .regular, design: .monospaced))
                                .foregroundColor(Color(red: 0.91, green: 0.95, blue: 1.0))
                                .multilineTextAlignment(.leading)
                                .lineLimit(3)
                                .shadow(color: .black, radius: 0, x: 1, y: 1)
                                .background(Color.clear)

                            Text("and I'm always saying that...")
                                .font(.system(size: 11, weight: .regular, design: .monospaced))
                                .foregroundColor(Color(red: 0.62, green: 0.68, blue: 0.82))
                                .shadow(color: .black, radius: 0, x: 1, y: 1)
                                .background(Color.clear)
                        }
                        .background(Color.clear)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 8)
                    .background(Color.clear)
                }
            }
        }
    }
    
    private func generateStars(geometry: GeometryProxy) {
        let screenWidth = geometry.size.width
        let screenHeight = geometry.size.height
        
        stars = (0..<60).map { _ in
            WidgetStar(
                id: UUID(),
                position: CGPoint(
                    x: CGFloat.random(in: 0...screenWidth),
                    y: CGFloat.random(in: 0...screenHeight)
                ),
                size: CGFloat.random(in: 1.0...2.5),
                opacity: Double.random(in: 0.3...0.8)
            )
        }
    }
}


struct Oracle_Widget: Widget {
    let kind: String = "Oracle_Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                Oracle_WidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                Oracle_WidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Oracle of Nonsense")
        .description("Get mystical wisdom from the oracle.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
        .contentMarginsDisabled()
    }
}

#Preview(as: .systemSmall) {
    Oracle_Widget()
} timeline: {
    OracleEntry(date: .now, phrase: "Stars hum while the kettle boils.")
}

#Preview(as: .systemMedium) {
    Oracle_Widget()
} timeline: {
    OracleEntry(date: .now, phrase: "The moon forgot its shoes last night.")
    OracleEntry(date: .now, phrase: "A whisper can be heavier than a stone.")
}

#Preview(as: .systemLarge) {
    Oracle_Widget()
} timeline: {
    OracleEntry(date: .now, phrase: "Candles argue with the wind in polite whispers.")
}