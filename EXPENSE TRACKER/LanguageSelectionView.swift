import SwiftUI

struct LanguageSelectionView: View {
    
    @EnvironmentObject var languageManager: LanguageManager
    
    var body: some View {
        
        ZStack {
            
            // MARK: - Black Background
            Color.black
                .ignoresSafeArea()
            
            ScrollView {
                
                VStack(spacing: 22) {
                    
                    Spacer(minLength: 25)
                    
                    // MARK: - Decorative Globe
                    ZStack {
                        
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [
                                        Color.blue.opacity(0.25),
                                        Color.purple.opacity(0.18),
                                        Color.cyan.opacity(0.12)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(
                                width: 175,
                                height: 175
                            )
                        
                        Circle()
                            .stroke(
                                LinearGradient(
                                    colors: [
                                        .cyan,
                                        .blue,
                                        .purple
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 2
                            )
                            .frame(
                                width: 155,
                                height: 155
                            )
                        
                        Image(systemName: "globe.americas.fill")
                            .font(
                                .system(
                                    size: 105,
                                    weight: .medium
                                )
                            )
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [
                                        .cyan,
                                        .blue,
                                        .purple
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                        
                        // Decorative bubbles
                        Text("Aa")
                            .font(
                                .system(
                                    size: 17,
                                    weight: .bold
                                )
                            )
                            .foregroundStyle(.white)
                            .padding(10)
                            .background(
                                RoundedRectangle(
                                    cornerRadius: 12
                                )
                                .fill(.purple)
                            )
                            .rotationEffect(.degrees(-10))
                            .offset(
                                x: -82,
                                y: -48
                            )
                        
                        Text("अ")
                            .font(
                                .system(
                                    size: 19,
                                    weight: .bold
                                )
                            )
                            .foregroundStyle(.white)
                            .frame(
                                width: 42,
                                height: 42
                            )
                            .background(
                                Circle()
                                    .fill(.pink)
                            )
                            .offset(
                                x: 82,
                                y: -43
                            )
                        
                        Text("اردو")
                            .font(
                                .system(
                                    size: 12,
                                    weight: .bold
                                )
                            )
                            .foregroundStyle(.white)
                            .padding(9)
                            .background(
                                RoundedRectangle(
                                    cornerRadius: 12
                                )
                                .fill(.orange)
                            )
                            .rotationEffect(.degrees(8))
                            .offset(
                                x: 82,
                                y: 48
                            )
                        
                        Text("अ")
                            .font(
                                .system(
                                    size: 18,
                                    weight: .bold
                                )
                            )
                            .foregroundStyle(.white)
                            .frame(
                                width: 40,
                                height: 40
                            )
                            .background(
                                Circle()
                                    .fill(.green)
                            )
                            .offset(
                                x: -78,
                                y: 45
                            )
                    }
                    
                    // MARK: - Title
                    VStack(spacing: 8) {
                        
                        Text("Choose Your Language")
                            .font(
                                .system(
                                    size: 30,
                                    weight: .bold,
                                    design: .rounded
                                )
                            )
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                        
                        Text("अपनी भाषा चुनें")
                            .font(
                                .system(
                                    size: 17,
                                    weight: .medium
                                )
                            )
                            .foregroundStyle(
                                Color.white.opacity(0.65)
                            )
                        
                        Text(
                            "Select your preferred language to get started."
                        )
                        .font(.subheadline)
                        .foregroundStyle(
                            Color.white.opacity(0.45)
                        )
                        .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal, 20)
                    
                    
                    // MARK: - Language Options
                    VStack(spacing: 12) {
                        
                        ForEach(
                            AppLanguage.allCases
                        ) { language in
                            
                            Button {
                                withAnimation(
                                    .spring(
                                        response: 0.3,
                                        dampingFraction: 0.75
                                    )
                                ) {
                                    languageManager.selectedLanguage =
                                        language
                                }
                            } label: {
                                
                                HStack(spacing: 15) {
                                    
                                    // Flag
                                    Text(language.flag)
                                        .font(.system(size: 25))
                                        .frame(
                                            width: 42,
                                            height: 42
                                        )
                                        .background(
                                            Circle()
                                                .fill(
                                                    Color.white.opacity(
                                                        0.08
                                                    )
                                                )
                                        )
                                    
                                    // Language name
                                    Text(language.rawValue)
                                        .font(
                                            .system(
                                                size: 17,
                                                weight: .semibold,
                                                design: .rounded
                                            )
                                        )
                                        .foregroundStyle(.white)
                                    
                                    Spacer()
                                    
                                    // Selection
                                    if languageManager.selectedLanguage
                                        == language {
                                        
                                        Image(
                                            systemName:
                                                "checkmark"
                                        )
                                        .font(
                                            .system(
                                                size: 13,
                                                weight: .bold
                                            )
                                        )
                                        .foregroundStyle(.white)
                                        .frame(
                                            width: 30,
                                            height: 30
                                        )
                                        .background(
                                            Circle()
                                                .fill(
                                                    LinearGradient(
                                                        colors: [
                                                            .cyan,
                                                            .blue
                                                        ],
                                                        startPoint:
                                                            .topLeading,
                                                        endPoint:
                                                            .bottomTrailing
                                                    )
                                                )
                                        )
                                        
                                    } else {
                                        
                                        Circle()
                                            .stroke(
                                                Color.white.opacity(
                                                    0.25
                                                ),
                                                lineWidth: 1.5
                                            )
                                            .frame(
                                                width: 25,
                                                height: 25
                                            )
                                    }
                                }
                                .padding(.horizontal, 16)
                                .frame(
                                    maxWidth: .infinity,
                                    minHeight: 64
                                )
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: 20
                                    )
                                    .fill(
                                        languageManager.selectedLanguage
                                        == language
                                        ? LinearGradient(
                                            colors: [
                                                Color.blue.opacity(
                                                    0.30
                                                ),
                                                Color.purple.opacity(
                                                    0.22
                                                )
                                            ],
                                            startPoint:
                                                .topLeading,
                                            endPoint:
                                                .bottomTrailing
                                        )
                                        : LinearGradient(
                                            colors: [
                                                Color.white.opacity(
                                                    0.07
                                                ),
                                                Color.white.opacity(
                                                    0.04
                                                )
                                            ],
                                            startPoint:
                                                .topLeading,
                                            endPoint:
                                                .bottomTrailing
                                        )
                                    )
                                )
                                .overlay(
                                    RoundedRectangle(
                                        cornerRadius: 20
                                    )
                                    .stroke(
                                        languageManager.selectedLanguage
                                        == language
                                        ? LinearGradient(
                                            colors: [
                                                .cyan,
                                                .blue,
                                                .purple
                                            ],
                                            startPoint:
                                                .topLeading,
                                            endPoint:
                                                .bottomTrailing
                                        )
                                        : LinearGradient(
                                            colors: [
                                                Color.white.opacity(
                                                    0.12
                                                ),
                                                Color.white.opacity(
                                                    0.05
                                                )
                                            ],
                                            startPoint:
                                                .topLeading,
                                            endPoint:
                                                .bottomTrailing
                                        ),
                                        lineWidth:
                                            languageManager.selectedLanguage
                                            == language
                                            ? 1.5
                                            : 1
                                    )
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    
                    // MARK: - Continue Button
                    NavigationLink {
                        
                        FeatureIntroView()
                            .environmentObject(
                                languageManager
                            )
                        
                    } label: {
                        
                        HStack(spacing: 10) {
                            
                            Text("Continue")
                                .font(
                                    .system(
                                        size: 17,
                                        weight: .bold,
                                        design: .rounded
                                    )
                                )
                            
                            Image(
                                systemName:
                                    "arrow.right"
                            )
                            .font(
                                .system(
                                    size: 15,
                                    weight: .bold
                                )
                            )
                        }
                        .foregroundStyle(.white)
                        .frame(
                            maxWidth: .infinity,
                            minHeight: 58
                        )
                        .background(
                            LinearGradient(
                                colors: [
                                    .cyan,
                                    .blue,
                                    .purple
                                ],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .clipShape(
                            RoundedRectangle(
                                cornerRadius: 20
                            )
                        )
                        .shadow(
                            color: Color.blue.opacity(0.40),
                            radius: 12,
                            y: 6
                        )
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 5)
                    
                    Spacer(minLength: 20)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .preferredColorScheme(.dark)
    }
}


// MARK: - Preview

#Preview {
    NavigationStack {
        LanguageSelectionView()
            .environmentObject(
                LanguageManager()
            )
    }
}
