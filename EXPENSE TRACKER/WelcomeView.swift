import SwiftUI

struct WelcomeView: View {
    
    @EnvironmentObject var languageManager: LanguageManager
    
    var body: some View {
        ZStack {
            
            // MARK: - Background
            Color.black
                .ignoresSafeArea()
            
            // MARK: - Decorative Curves
            GeometryReader { geometry in
                Path { path in
                    path.move(to: CGPoint(x: -20, y: 150))
                    path.addCurve(
                        to: CGPoint(x: 130, y: 40),
                        control1: CGPoint(x: 20, y: 100),
                        control2: CGPoint(x: 100, y: 100)
                    )
                }
                .stroke(
                    Color.blue.opacity(0.8),
                    style: StrokeStyle(lineWidth: 2)
                )
                
                Path { path in
                    path.move(
                        to: CGPoint(
                            x: geometry.size.width - 80,
                            y: geometry.size.height
                        )
                    )
                    path.addCurve(
                        to: CGPoint(
                            x: geometry.size.width + 20,
                            y: geometry.size.height - 170
                        ),
                        control1: CGPoint(
                            x: geometry.size.width - 30,
                            y: geometry.size.height - 60
                        ),
                        control2: CGPoint(
                            x: geometry.size.width + 10,
                            y: geometry.size.height - 120
                        )
                    )
                }
                .stroke(
                    Color.pink.opacity(0.8),
                    style: StrokeStyle(lineWidth: 2)
                )
            }
            .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                
                VStack(spacing: 0) {
                    
                    // MARK: - Illustration
                    ZStack {
                        
                        // Glow
                        Circle()
                            .fill(
                                RadialGradient(
                                    colors: [
                                        Color.blue.opacity(0.28),
                                        Color.purple.opacity(0.15),
                                        Color.clear
                                    ],
                                    center: .center,
                                    startRadius: 20,
                                    endRadius: 180
                                )
                            )
                            .frame(width: 350, height: 350)
                        
                        // Sparkles
                        Image(systemName: "sparkle")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundStyle(.yellow)
                            .offset(x: -135, y: -105)
                        
                        Image(systemName: "sparkles")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(.orange)
                            .offset(x: 135, y: -70)
                        
                        Image(systemName: "sparkle")
                            .font(.system(size: 17, weight: .bold))
                            .foregroundStyle(.pink)
                            .offset(x: 150, y: 60)
                        
                        Image(systemName: "sparkle")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(.yellow)
                            .offset(x: -145, y: 105)
                        
                        // Pie chart
                        ZStack {
                            Circle()
                                .trim(from: 0, to: 0.33)
                                .fill(Color.pink)
                            
                            Circle()
                                .trim(from: 0.33, to: 0.67)
                                .fill(Color.purple)
                            
                            Circle()
                                .trim(from: 0.67, to: 1)
                                .fill(Color.mint)
                        }
                        .frame(width: 105, height: 105)
                        .rotationEffect(.degrees(-90))
                        .overlay {
                            Circle()
                                .stroke(Color.black.opacity(0.3), lineWidth: 1)
                        }
                        .offset(x: -105, y: 70)
                        
                        // Wallet
                        ZStack {
                            
                            // Wallet body
                            RoundedRectangle(cornerRadius: 22)
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            Color.blue,
                                            Color.blue.opacity(0.85),
                                            Color.purple
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 190, height: 130)
                                .shadow(
                                    color: Color.blue.opacity(0.5),
                                    radius: 18,
                                    y: 8
                                )
                            
                            // Wallet inner
                            RoundedRectangle(cornerRadius: 15)
                                .fill(
                                    Color.blue.opacity(0.75)
                                )
                                .frame(width: 165, height: 82)
                                .offset(y: -18)
                            
                            // Button
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [.pink, .white.opacity(0.8)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 22, height: 22)
                                .overlay {
                                    Circle()
                                        .stroke(
                                            Color.white.opacity(0.5),
                                            lineWidth: 1
                                        )
                                }
                                .offset(x: 65, y: 8)
                            
                            // Wallet shine
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.white.opacity(0.18))
                                .frame(width: 90, height: 5)
                                .offset(x: -25, y: 28)
                        }
                        .offset(x: 15, y: 45)
                        
                        // Rupee coin
                        ZStack {
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            Color.pink,
                                            Color.pink.opacity(0.65)
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 72, height: 72)
                                .shadow(
                                    color: Color.pink.opacity(0.5),
                                    radius: 12
                                )
                            
                            Text("₹")
                                .font(
                                    .system(
                                        size: 39,
                                        weight: .bold,
                                        design: .rounded
                                    )
                                )
                                .foregroundStyle(.white)
                        }
                        .offset(x: -110, y: -5)
                        
                        // Expense card
                        ZStack {
                            RoundedRectangle(cornerRadius: 9)
                                .fill(Color.white)
                                .frame(width: 105, height: 135)
                                .rotationEffect(.degrees(-8))
                                .shadow(
                                    color: .black.opacity(0.3),
                                    radius: 8
                                )
                            
                            VStack(spacing: 10) {
                                Text("EXPENSE")
                                    .font(
                                        .system(
                                            size: 12,
                                            weight: .bold
                                        )
                                    )
                                    .foregroundStyle(
                                        Color.blue.opacity(0.75)
                                    )
                                
                                RoundedRectangle(cornerRadius: 3)
                                    .fill(Color.purple.opacity(0.25))
                                    .frame(width: 62, height: 7)
                                
                                HStack(spacing: 7) {
                                    RoundedRectangle(cornerRadius: 3)
                                        .fill(Color.purple.opacity(0.2))
                                        .frame(width: 45, height: 6)
                                    
                                    RoundedRectangle(cornerRadius: 3)
                                        .fill(Color.purple.opacity(0.2))
                                        .frame(width: 15, height: 6)
                                }
                                
                                HStack(spacing: 7) {
                                    RoundedRectangle(cornerRadius: 3)
                                        .fill(Color.purple.opacity(0.2))
                                        .frame(width: 38, height: 6)
                                    
                                    RoundedRectangle(cornerRadius: 3)
                                        .fill(Color.purple.opacity(0.2))
                                        .frame(width: 20, height: 6)
                                }
                            }
                            .rotationEffect(.degrees(-8))
                        }
                        .offset(x: 35, y: -40)
                        
                        // Bar chart
                        HStack(alignment: .bottom, spacing: 7) {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.pink)
                                .frame(width: 14, height: 35)
                            
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.purple)
                                .frame(width: 14, height: 55)
                            
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.mint)
                                .frame(width: 14, height: 75)
                            
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.cyan)
                                .frame(width: 14, height: 62)
                        }
                        .offset(x: 120, y: 60)
                    }
                    .frame(height: 335)
                    .padding(.top, 25)
                    
                    // MARK: - Welcome Title
                    VStack(spacing: 5) {
                        
                        Text(
                            languageManager.text(
                                english: "Welcome to",
                                hindi: "स्वागत है",
                                marathi: "स्वागत आहे",
                                urdu: "خوش آمدید"
                            )
                        )
                        .font(
                            .system(
                                size: 31,
                                weight: .bold,
                                design: .rounded
                            )
                        )
                        .foregroundStyle(.white)
                        
                        Text(
                            languageManager.text(
                                english: "Smart Expense Tracker",
                                hindi: "स्मार्ट एक्सपेंस ट्रैकर",
                                marathi: "स्मार्ट एक्सपेंस ट्रॅकर",
                                urdu: "اسمارٹ ایکسپنس ٹریکر"
                            )
                        )
                        .font(
                            .system(
                                size: 29,
                                weight: .bold,
                                design: .rounded
                            )
                        )
                        .foregroundStyle(
                            LinearGradient(
                                colors: [
                                    .blue,
                                    .pink,
                                    .mint
                                ],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                    }
                    .multilineTextAlignment(.center)
                    
                    // MARK: - Description
                    Text(
                        languageManager.text(
                            english: "Manage your expenses easily, track your spending, and stay within your budget.",
                            hindi: "अपने खर्चों को आसानी से प्रबंधित करें, खर्च पर नज़र रखें और अपने बजट के अंदर रहें।",
                            marathi: "तुमचे खर्च सहजपणे व्यवस्थापित करा, खर्चावर लक्ष ठेवा आणि तुमच्या बजेटमध्ये रहा.",
                            urdu: "اپنے اخراجات آسانی سے منظم کریں، اپنے خرچ پر نظر رکھیں اور اپنے بجٹ کے اندر رہیں۔"
                        )
                    )
                    .font(.system(size: 15))
                    .foregroundStyle(Color.white.opacity(0.65))
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .padding(.horizontal, 28)
                    .padding(.top, 14)
                    
                    // MARK: - Feature Cards
                    HStack(spacing: 10) {
                        
                        WelcomeFeatureCard(
                            icon: "chart.bar.fill",
                            iconColor: .pink,
                            title: languageManager.text(
                                english: "Track\nSpending",
                                hindi: "खर्च\nट्रैक करें",
                                marathi: "खर्च\nट्रॅक करा",
                                urdu: "اخراجات\nدیکھیں"
                            )
                        )
                        
                        WelcomeFeatureCard(
                            icon: "wallet.pass.fill",
                            iconColor: .mint,
                            title: languageManager.text(
                                english: "Manage\nExpenses",
                                hindi: "खर्च\nप्रबंधित करें",
                                marathi: "खर्च\nव्यवस्थापित करा",
                                urdu: "اخراجات\nمنظم کریں"
                            )
                        )
                        
                        WelcomeFeatureCard(
                            icon: "target",
                            iconColor: .yellow,
                            title: languageManager.text(
                                english: "Stay Within\nBudget",
                                hindi: "बजट के अंदर\nरहें",
                                marathi: "बजेटमध्ये\nरहा",
                                urdu: "بجٹ کے اندر\nرہیں"
                            )
                        )
                    }
                    .padding(.horizontal, 15)
                    .padding(.top, 25)
                    
                    // MARK: - Get Started Button
                    NavigationLink {
                        LanguageSelectionView()
                    } label: {
                        HStack(spacing: 12) {
                            
                            Text(
                                languageManager.text(
                                    english: "Let's Get Started",
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
                                .font(
                                    .system(
                                        size: 17,
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
                                    .blue,
                                    Color.blue.opacity(0.9)
                                ],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .clipShape(
                            RoundedRectangle(cornerRadius: 30)
                        )
                        .shadow(
                            color: Color.blue.opacity(0.45),
                            radius: 14,
                            y: 6
                        )
                    }
                    .padding(.horizontal, 22)
                    .padding(.top, 25)
                    
                    // MARK: - Page Indicators
                    HStack(spacing: 10) {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 10, height: 10)
                        
                        Circle()
                            .fill(Color.white.opacity(0.18))
                            .frame(width: 10, height: 10)
                        
                        Circle()
                            .fill(Color.white.opacity(0.18))
                            .frame(width: 10, height: 10)
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 25)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .preferredColorScheme(.dark)
    }
}

// MARK: - Feature Card

struct WelcomeFeatureCard: View {
    
    let icon: String
    let iconColor: Color
    let title: String
    
    var body: some View {
        VStack(spacing: 10) {
            
            ZStack {
                Circle()
                    .fill(iconColor.opacity(0.12))
                    .frame(width: 58, height: 58)
                
                Image(systemName: icon)
                    .font(
                        .system(
                            size: 25,
                            weight: .bold
                        )
                    )
                    .foregroundStyle(iconColor)
            }
            
            Text(title)
                .font(
                    .system(
                        size: 13,
                        weight: .semibold,
                        design: .rounded
                    )
                )
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .lineSpacing(2)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 125)
        .background(
            RoundedRectangle(cornerRadius: 22)
                .fill(Color.white.opacity(0.055))
        )
        .overlay {
            RoundedRectangle(cornerRadius: 22)
                .stroke(
                    Color.white.opacity(0.08),
                    lineWidth: 1
                )
        }
    }
}

#Preview {
    NavigationStack {
        WelcomeView()
            .environmentObject(LanguageManager())
    }
}
