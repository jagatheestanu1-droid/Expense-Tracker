import SwiftUI

struct SplashView: View {
    
    @EnvironmentObject var languageManager: LanguageManager
    @State private var showNextScreen = false
    
    var body: some View {
        
        Group {
            
            // MARK: - Next Screen
            
            if showNextScreen {
                
                if languageManager.hasCompletedOnboarding {
                    ContentView()
                    
                } else {
                    NavigationStack {
                        WelcomeView()
                    }
                }
                
            } else {
                
                // MARK: - Splash Screen
                
                ZStack {
                    
                    // MARK: Black Background
                    
                    Color.black
                        .ignoresSafeArea()
                    
                    GeometryReader { geometry in
                        
                        ZStack {
                            
                            // MARK: Top Left Blue Shape
                            
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            Color.blue.opacity(0.75),
                                            Color.blue.opacity(0.35)
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(
                                    width: 310,
                                    height: 310
                                )
                                .position(
                                    x: -10,
                                    y: 5
                                )
                            
                            // MARK: Top Blue Dot
                            
                            Circle()
                                .fill(
                                    Color.blue.opacity(0.85)
                                )
                                .frame(
                                    width: 26,
                                    height: 26
                                )
                                .position(
                                    x: geometry.size.width * 0.67,
                                    y: geometry.size.height * 0.22
                                )
                            
                            // MARK: Right Blue Circle
                            
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            Color.blue.opacity(0.45),
                                            Color.blue.opacity(0.15)
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(
                                    width: 115,
                                    height: 115
                                )
                                .position(
                                    x: geometry.size.width + 5,
                                    y: geometry.size.height * 0.34
                                )
                            
                            // MARK: Bottom Left Dot
                            
                            Circle()
                                .fill(
                                    Color.blue.opacity(0.85)
                                )
                                .frame(
                                    width: 44,
                                    height: 44
                                )
                                .position(
                                    x: geometry.size.width * 0.14,
                                    y: geometry.size.height * 0.67
                                )
                            
                            // MARK: Bottom Right Large Circle
                            
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            Color.blue.opacity(0.8),
                                            Color.blue.opacity(0.18)
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(
                                    width: 390,
                                    height: 390
                                )
                                .position(
                                    x: geometry.size.width * 1.02,
                                    y: geometry.size.height * 1.03
                                )
                            
                            // MARK: Bottom Right Inner Circle
                            
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            Color.blue.opacity(0.55),
                                            Color.blue.opacity(0.12)
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(
                                    width: 270,
                                    height: 270
                                )
                                .position(
                                    x: geometry.size.width * 1.02,
                                    y: geometry.size.height * 1.04
                                )
                            
                            // MARK: Upper Curved Line
                            
                            CurvedLine()
                                .stroke(
                                    Color.blue.opacity(0.65),
                                    lineWidth: 2
                                )
                                .frame(
                                    width: geometry.size.width * 0.95,
                                    height: 260
                                )
                                .position(
                                    x: geometry.size.width * 0.66,
                                    y: geometry.size.height * 0.22
                                )
                            
                            // MARK: Lower Curved Line
                            
                            CurvedLine()
                                .stroke(
                                    Color.blue.opacity(0.55),
                                    lineWidth: 2
                                )
                                .frame(
                                    width: geometry.size.width * 0.95,
                                    height: 260
                                )
                                .rotationEffect(.degrees(180))
                                .position(
                                    x: geometry.size.width * 0.35,
                                    y: geometry.size.height * 0.72
                                )
                        }
                    }
                    
                    // MARK: - Main Content
                    
                    VStack(spacing: 0) {
                        
                        Spacer()
                        
                        // MARK: Logo
                        
                        Image("Image")
                            .resizable()
                            .scaledToFit()
                            .frame(
                                width: 190,
                                height: 190
                            )
                            .shadow(
                                color: Color.blue.opacity(0.4),
                                radius: 20
                            )
                        
                        // MARK: App Name
                        
                        (
                            Text("Smart ")
                                .foregroundStyle(.white)
                            +
                            Text("Expense")
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [
                                            Color.cyan,
                                            Color.blue
                                        ],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                            +
                            Text(" Tracker")
                                .foregroundStyle(.white)
                        )
                        .font(
                            .system(
                                size: 30,
                                weight: .bold,
                                design: .rounded
                            )
                        )
                        .multilineTextAlignment(.center)
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)
                        .padding(.horizontal, 10)
                        .padding(.top, 18)
                        
                        // MARK: Subtitle
                        
                        Text(
                            languageManager.text(
                                english: "Manage your expenses easily",
                                hindi: "अपने खर्चों को आसानी से प्रबंधित करें",
                                marathi: "तुमचे खर्च सहज व्यवस्थापित करा",
                                urdu: "اپنے اخراجات آسانی سے منظم کریں"
                            )
                        )
                        .font(
                            .system(
                                size: 17,
                                weight: .regular,
                                design: .rounded
                            )
                        )
                        .foregroundStyle(
                            Color.white.opacity(0.7)
                        )
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                        .padding(.top, 12)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                }
                .ignoresSafeArea()
            }
        }
        
        // MARK: - Existing 2 Second Navigation
        
        .onAppear {
            DispatchQueue.main.asyncAfter(
                deadline: .now() + 2
            ) {
                withAnimation {
                    showNextScreen = true
                }
            }
        }
    }
}

// MARK: - Decorative Curved Line

struct CurvedLine: Shape {
    
    func path(in rect: CGRect) -> Path {
        
        var path = Path()
        
        path.move(
            to: CGPoint(
                x: rect.minX,
                y: rect.maxY * 0.85
            )
        )
        
        path.addCurve(
            to: CGPoint(
                x: rect.maxX,
                y: rect.minY
            ),
            control1: CGPoint(
                x: rect.width * 0.25,
                y: rect.height * 0.2
            ),
            control2: CGPoint(
                x: rect.width * 0.65,
                y: rect.height * 0.15
            )
        )
        
        return path
    }
}

#Preview {
    SplashView()
        .environmentObject(LanguageManager())
}
