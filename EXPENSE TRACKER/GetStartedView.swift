import SwiftUI

struct GetStartedView: View {
    
    @EnvironmentObject var languageManager: LanguageManager
    
    var body: some View {
        ZStack {
            
            // MARK: - Black Background
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                Spacer()
                
                // MARK: - Main Illustration
                ZStack {
                    
                    // Glow
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [
                                    Color.cyan.opacity(0.25),
                                    Color.blue.opacity(0.18),
                                    Color.purple.opacity(0.12),
                                    Color.clear
                                ],
                                center: .center,
                                startRadius: 20,
                                endRadius: 150
                            )
                        )
                        .frame(width: 300, height: 300)
                    
                    // Decorative sparkles
                    Image(systemName: "sparkle")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.yellow)
                        .offset(x: -105, y: -70)
                    
                    Image(systemName: "sparkles")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(.orange)
                        .offset(x: 105, y: -50)
                    
                    Image(systemName: "sparkle")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundStyle(.cyan)
                        .offset(x: 110, y: 45)
                    
                    Image(systemName: "sparkle")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(.purple)
                        .offset(x: -105, y: 55)
                    
                    // Green leaves
                    Image(systemName: "leaf.fill")
                        .font(.system(size: 30))
                        .foregroundStyle(.green)
                        .rotationEffect(.degrees(-35))
                        .offset(x: -80, y: 25)
                    
                    Image(systemName: "leaf.fill")
                        .font(.system(size: 25))
                        .foregroundStyle(.mint)
                        .rotationEffect(.degrees(35))
                        .offset(x: 82, y: 28)
                    
                    // Checkmark circle
                    ZStack {
                        Circle()
                            .fill(
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
                            .frame(width: 145, height: 145)
                            .shadow(
                                color: Color.blue.opacity(0.5),
                                radius: 25,
                                y: 10
                            )
                        
                        Circle()
                            .fill(Color.black.opacity(0.18))
                            .frame(width: 115, height: 115)
                        
                        Image(systemName: "checkmark")
                            .font(.system(size: 58, weight: .bold))
                            .foregroundStyle(.white)
                    }
                }
                .frame(height: 300)
                
                Spacer()
                    .frame(height: 15)
                
                // MARK: - Title
                Text(
                    languageManager.text(
                        english: "You're All Set!",
                        hindi: "आप पूरी तरह तैयार हैं!",
                        marathi: "तुम्ही पूर्णपणे तयार आहात!",
                        urdu: "آپ بالکل تیار ہیں!"
                    )
                )
                .font(
                    .system(
                        size: 32,
                        weight: .bold,
                        design: .rounded
                    )
                )
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                
                // MARK: - Description
                Text(
                    languageManager.text(
                        english: "Start managing your expenses and take control of your spending.",
                        hindi: "अपने खर्चों को प्रबंधित करना शुरू करें और अपने खर्च पर नियंत्रण रखें।",
                        marathi: "तुमचे खर्च व्यवस्थापित करण्यास सुरुवात करा आणि तुमच्या खर्चावर नियंत्रण ठेवा.",
                        urdu: "اپنے اخراجات کا انتظام شروع کریں اور اپنے خرچ پر قابو رکھیں۔"
                    )
                )
                .font(.system(size: 16))
                .foregroundStyle(Color.white.opacity(0.55))
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .padding(.horizontal, 35)
                .padding(.top, 12)
                
                Spacer()
                
                // MARK: - Get Started Button
                Button {
                    languageManager.completeOnboarding()
                } label: {
                    HStack(spacing: 10) {
                        
                        Text(
                            languageManager.text(
                                english: "Get Started",
                                hindi: "शुरू करें",
                                marathi: "सुरुवात करा",
                                urdu: "شروع کریں"
                            )
                        )
                        .font(
                            .system(
                                size: 17,
                                weight: .bold,
                                design: .rounded
                            )
                        )
                        
                        Image(systemName: "arrow.right")
                            .font(.system(size: 15, weight: .bold))
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
                        color: Color.blue.opacity(0.4),
                        radius: 14,
                        y: 6
                    )
                }
                .padding(.horizontal, 20)
                
                Spacer()
                    .frame(height: 25)
            }
            .padding(.horizontal, 10)
        }
        .navigationBarBackButtonHidden(true)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    NavigationStack {
        GetStartedView()
            .environmentObject(LanguageManager())
    }
}
