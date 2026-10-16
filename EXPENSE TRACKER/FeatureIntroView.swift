import SwiftUI

struct FeatureIntroView: View {
    
    @EnvironmentObject var languageManager: LanguageManager
    
    var body: some View {
        
        ZStack {
            
            // MARK: - Black Background
            Color.black
                .ignoresSafeArea()
            
            // MARK: - Main Content
            VStack(spacing: 0) {
                
                ScrollView(showsIndicators: false) {
                    
                    VStack(spacing: 18) {
                        
                        // MARK: - Wallet Illustration
                        ZStack {
                            
                            // Glow
                            Circle()
                                .fill(
                                    RadialGradient(
                                        colors: [
                                            Color.blue.opacity(0.28),
                                            Color.purple.opacity(0.18),
                                            Color.clear
                                        ],
                                        center: .center,
                                        startRadius: 20,
                                        endRadius: 125
                                    )
                                )
                                .frame(
                                    width: 240,
                                    height: 240
                                )
                            
                            // Left leaves
                            Image(systemName: "leaf.fill")
                                .font(.system(size: 35))
                                .foregroundStyle(.cyan)
                                .rotationEffect(.degrees(-25))
                                .offset(x: -82, y: 38)
                            
                            Image(systemName: "leaf.fill")
                                .font(.system(size: 27))
                                .foregroundStyle(.green)
                                .rotationEffect(.degrees(35))
                                .offset(x: 83, y: 35)
                            
                            Image(systemName: "leaf.fill")
                                .font(.system(size: 22))
                                .foregroundStyle(.purple)
                                .rotationEffect(.degrees(-15))
                                .offset(x: -68, y: -45)
                            
                            // Sparkles
                            Image(systemName: "sparkle")
                                .font(.system(size: 19))
                                .foregroundStyle(.yellow)
                                .offset(x: -88, y: -55)
                            
                            Image(systemName: "sparkles")
                                .font(.system(size: 20))
                                .foregroundStyle(.orange)
                                .offset(x: 88, y: -45)
                            
                            Image(systemName: "sparkle")
                                .font(.system(size: 14))
                                .foregroundStyle(.cyan)
                                .offset(x: 105, y: 0)
                            
                            // MARK: - Coins
                            ZStack {
                                
                                Circle()
                                    .fill(
                                        LinearGradient(
                                            colors: [
                                                .yellow,
                                                .orange
                                            ],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(
                                        width: 48,
                                        height: 48
                                    )
                                    .overlay {
                                        Text("₹")
                                            .font(
                                                .system(
                                                    size: 25,
                                                    weight: .bold
                                                )
                                            )
                                            .foregroundStyle(.brown)
                                    }
                                    .offset(
                                        x: -37,
                                        y: -20
                                    )
                                
                                Circle()
                                    .fill(
                                        LinearGradient(
                                            colors: [
                                                Color.yellow.opacity(0.95),
                                                .orange
                                            ],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(
                                        width: 38,
                                        height: 38
                                    )
                                    .overlay {
                                        Text("₹")
                                            .font(
                                                .system(
                                                    size: 20,
                                                    weight: .bold
                                                )
                                            )
                                            .foregroundStyle(.brown)
                                    }
                                    .offset(
                                        x: -4,
                                        y: -42
                                    )
                                
                                // Money note
                                RoundedRectangle(
                                    cornerRadius: 5
                                )
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            .green,
                                            Color.green.opacity(0.7)
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(
                                    width: 70,
                                    height: 35
                                )
                                .rotationEffect(.degrees(12))
                                .offset(
                                    x: 40,
                                    y: -30
                                )
                            }
                            
                            // MARK: - Main Wallet
                            ZStack {
                                
                                RoundedRectangle(
                                    cornerRadius: 22
                                )
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            Color.blue,
                                            Color.blue.opacity(0.8),
                                            Color.purple
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(
                                    width: 145,
                                    height: 100
                                )
                                .shadow(
                                    color: Color.blue.opacity(0.45),
                                    radius: 15,
                                    y: 8
                                )
                                
                                // Wallet flap
                                RoundedRectangle(
                                    cornerRadius: 15
                                )
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            Color.blue.opacity(0.9),
                                            Color.purple.opacity(0.9)
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(
                                    width: 125,
                                    height: 62
                                )
                                .offset(y: -12)
                                
                                // Wallet button
                                Circle()
                                    .fill(
                                        Color.white.opacity(0.9)
                                    )
                                    .frame(
                                        width: 17,
                                        height: 17
                                    )
                                    .overlay {
                                        Circle()
                                            .stroke(
                                                Color.blue,
                                                lineWidth: 2
                                            )
                                    }
                                    .offset(
                                        x: 48,
                                        y: -3
                                    )
                            }
                        }
                        .frame(height: 225)
                        .padding(.top, 10)
                        
                        
                        // MARK: - Title
                        VStack(spacing: 7) {
                            
                            Text(
                                languageManager.text(
                                    english: "Track Your Spending",
                                    hindi: "अपने खर्च पर नज़र रखें",
                                    marathi: "तुमच्या खर्चाचा मागोवा घ्या",
                                    urdu: "اپنے اخراجات پر نظر رکھیں"
                                )
                            )
                            .font(
                                .system(
                                    size: 30,
                                    weight: .bold,
                                    design: .rounded
                                )
                            )
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                            
                            Text(
                                languageManager.text(
                                    english: "Keep all your expenses organized in one place.",
                                    hindi: "अपने सभी खर्चों को एक ही जगह व्यवस्थित रखें।",
                                    marathi: "तुमचे सर्व खर्च एकाच ठिकाणी व्यवस्थित ठेवा.",
                                    urdu: "اپنے تمام اخراجات کو ایک ہی جگہ منظم رکھیں۔"
                                )
                            )
                            .font(.subheadline)
                            .foregroundStyle(
                                Color.white.opacity(0.55)
                            )
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 25)
                        }
                        .padding(.bottom, 4)
                        
                        
                        // MARK: - Feature Cards
                        VStack(spacing: 10) {
                            
                            FeatureRow(
                                icon: "plus",
                                iconColors: [.pink, .red],
                                title: languageManager.text(
                                    english: "Add Expenses",
                                    hindi: "खर्च जोड़ें",
                                    marathi: "खर्च जोडा",
                                    urdu: "اخراجات شامل کریں"
                                ),
                                description: languageManager.text(
                                    english: "Record your daily expenses easily.",
                                    hindi: "अपने दैनिक खर्चों को आसानी से दर्ज करें।",
                                    marathi: "तुमचे दैनंदिन खर्च सहजपणे नोंदवा.",
                                    urdu: "اپنے روزانہ کے اخراجات آسانی سے درج کریں۔"
                                )
                            )
                            
                            FeatureRow(
                                icon: "chart.bar.fill",
                                iconColors: [.purple, .blue],
                                title: languageManager.text(
                                    english: "View Spending",
                                    hindi: "खर्च देखें",
                                    marathi: "खर्च पहा",
                                    urdu: "اخراجات دیکھیں"
                                ),
                                description: languageManager.text(
                                    english: "Understand where your money is going.",
                                    hindi: "समझें कि आपका पैसा कहाँ खर्च हो रहा है।",
                                    marathi: "तुमचे पैसे कुठे खर्च होत आहेत ते समजून घ्या.",
                                    urdu: "سمجھیں کہ آپ کا پیسہ کہاں خرچ ہو رہا ہے۔"
                                )
                            )
                            
                            FeatureRow(
                                icon: "indianrupeesign",
                                iconColors: [.green, .mint],
                                title: languageManager.text(
                                    english: "Set a Budget",
                                    hindi: "बजट सेट करें",
                                    marathi: "बजेट सेट करा",
                                    urdu: "بجٹ مقرر کریں"
                                ),
                                description: languageManager.text(
                                    english: "Set a monthly budget and track your remaining amount.",
                                    hindi: "मासिक बजट सेट करें और बची हुई राशि पर नज़र रखें।",
                                    marathi: "मासिक बजेट सेट करा आणि उरलेल्या रकमेचा मागोवा घ्या.",
                                    urdu: "ماہانہ بجٹ مقرر کریں اور باقی رقم پر نظر رکھیں۔"
                                )
                            )
                            
                            FeatureRow(
                                icon: "magnifyingglass",
                                iconColors: [.purple, .pink],
                                title: languageManager.text(
                                    english: "Search Expenses",
                                    hindi: "खर्च खोजें",
                                    marathi: "खर्च शोधा",
                                    urdu: "اخراجات تلاش کریں"
                                ),
                                description: languageManager.text(
                                    english: "Quickly find your previous expenses.",
                                    hindi: "अपने पिछले खर्चों को जल्दी खोजें।",
                                    marathi: "तुमचे मागील खर्च पटकन शोधा.",
                                    urdu: "اپنے پچھلے اخراجات جلدی تلاش کریں۔"
                                )
                            )
                        }
                        .padding(.horizontal, 18)
                        
                        // Extra bottom space so cards don't touch button
                        Spacer()
                            .frame(height: 15)
                    }
                    .padding(.bottom, 10)
                }
                
                // =====================================================
                // FIXED CONTINUE BUTTON
                // =====================================================
                
                NavigationLink {
                    GetStartedView()
                        .environmentObject(languageManager)
                } label: {
                    
                    HStack(spacing: 10) {
                        
                        Text(
                            languageManager.text(
                                english: "Continue",
                                hindi: "जारी रखें",
                                marathi: "पुढे जा",
                                urdu: "جاری رکھیں"
                            )
                        )
                        .font(
                            .system(
                                size: 17,
                                weight: .bold,
                                design: .rounded
                            )
                        )
                        
                        Image(
                            systemName: "arrow.right"
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
                        minHeight: 56
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
                        radius: 12,
                        y: 5
                    )
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
                .padding(.bottom, 8)
                .background(Color.black)
            }
        }
        .navigationBarBackButtonHidden(true)
        .preferredColorScheme(.dark)
    }
}


// MARK: - Feature Row

struct FeatureRow: View {
    
    let icon: String
    let iconColors: [Color]
    let title: String
    let description: String
    
    var body: some View {
        
        HStack(spacing: 14) {
            
            ZStack {
                
                RoundedRectangle(
                    cornerRadius: 16
                )
                .fill(
                    LinearGradient(
                        colors: iconColors,
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                
                Image(systemName: icon)
                    .font(
                        .system(
                            size: 21,
                            weight: .bold
                        )
                    )
                    .foregroundStyle(.white)
            }
            .frame(
                width: 50,
                height: 50
            )
            
            VStack(
                alignment: .leading,
                spacing: 3
            ) {
                
                Text(title)
                    .font(
                        .system(
                            size: 16,
                            weight: .bold,
                            design: .rounded
                        )
                    )
                    .foregroundStyle(.white)
                
                Text(description)
                    .font(.caption)
                    .foregroundStyle(
                        Color.white.opacity(0.52)
                    )
                    .lineLimit(2)
            }
            
            Spacer()
            
            Image(
                systemName: "chevron.right"
            )
            .font(
                .system(
                    size: 12,
                    weight: .bold
                )
            )
            .foregroundStyle(
                Color.white.opacity(0.30)
            )
        }
        .padding(12)
        .background(
            RoundedRectangle(
                cornerRadius: 19
            )
            .fill(
                Color.white.opacity(0.06)
            )
        )
        .overlay(
            RoundedRectangle(
                cornerRadius: 19
            )
            .stroke(
                Color.white.opacity(0.08),
                lineWidth: 1
            )
        )
    }
}


// MARK: - Preview

#Preview {
    NavigationStack {
        FeatureIntroView()
            .environmentObject(
                LanguageManager()
            )
    }
}
