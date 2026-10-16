import SwiftUI
import SwiftData

struct BudgetView: View {

    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var languageManager: LanguageManager

    @Query private var budgets: [Budget]
    @Query private var expenses: [Expense]

    @State private var budgetAmount = ""

    // MARK: - Calculations

    var totalSpent: Double {
        expenses.reduce(0) { $0 + $1.amount }
    }

    var currentBudget: Budget? {
        budgets.first
    }

    var remainingAmount: Double {
        (currentBudget?.amount ?? 0) - totalSpent
    }

    var budgetPercentage: Double {
        guard let budget = currentBudget,
              budget.amount > 0 else {
            return 0
        }

        return (totalSpent / budget.amount) * 100
    }

    var progressValue: Double {
        min(max(budgetPercentage / 100, 0), 1)
    }

    // MARK: - Body

    var body: some View {

        ZStack {

            Color.black
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {

                VStack(alignment: .leading, spacing: 0) {

                    // MARK: Header

                    HStack {

                        Text(languageManager.text(
                            english: "Budget",
                            hindi: "बजट",
                            marathi: "बजेट",
                            urdu: "بجٹ"
                        ))
                        .font(.system(
                            size: 34,
                            weight: .bold,
                            design: .rounded
                        ))
                        .foregroundStyle(.white)

                        Spacer()

                        Image(systemName: "calendar")
                            .font(.system(
                                size: 20,
                                weight: .semibold
                            ))
                            .foregroundStyle(.purple)
                            .frame(width: 48, height: 48)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.purple.opacity(0.12))
                            )
                            .overlay {
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(
                                        Color.purple.opacity(0.25),
                                        lineWidth: 1
                                    )
                            }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 18)

                    // MARK: Budget Ring

                    budgetRing
                        .frame(maxWidth: .infinity)
                        .padding(.top, 22)

                    // MARK: Status

                    if currentBudget != nil {
                        statusCard
                            .padding(.horizontal, 20)
                            .padding(.top, 18)
                    }

                    // MARK: Set Budget

                    setBudgetCard
                        .padding(.horizontal, 20)
                        .padding(.top, 22)

                    // MARK: Category Header

                    HStack {

                        Text(languageManager.text(
                            english: "Category Spending",
                            hindi: "श्रेणी के अनुसार खर्च",
                            marathi: "श्रेणीनुसार खर्च",
                            urdu: "زمرے کے لحاظ سے اخراجات"
                        ))
                        .font(.system(
                            size: 24,
                            weight: .bold,
                            design: .rounded
                        ))
                        .foregroundStyle(.white)

                        Spacer()

                        NavigationLink {
                            CategorySpendingView()
                        } label: {

                            HStack(spacing: 5) {

                                Text(languageManager.text(
                                    english: "See All",
                                    hindi: "सभी देखें",
                                    marathi: "सर्व पहा",
                                    urdu: "سب دیکھیں"
                                ))
                                .font(.system(
                                    size: 14,
                                    weight: .semibold
                                ))

                                Image(systemName: "chevron.right")
                                    .font(.system(
                                        size: 12,
                                        weight: .bold
                                    ))
                            }
                            .foregroundStyle(.purple)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 28)

                    // MARK: Category Cards

                    VStack(spacing: 12) {

                        categoryCard(
                            category: "Food",
                            icon: "fork.knife",
                            colors: [.green, .mint]
                        )

                        categoryCard(
                            category: "Travel",
                            icon: "car.fill",
                            colors: [.purple, .blue]
                        )

                        categoryCard(
                            category: "Shopping",
                            icon: "bag.fill",
                            colors: [.pink, .purple]
                        )

                        categoryCard(
                            category: "Education",
                            icon: "book.fill",
                            colors: [.orange, .yellow]
                        )

                        categoryCard(
                            category: "Others",
                            icon: "ellipsis",
                            colors: [.blue, .cyan]
                        )
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 12)

                    Spacer()
                        .frame(height: 30)
                }
            }
        }
        .navigationBarHidden(true)
        .preferredColorScheme(.dark)
        .onAppear {

            if let budget = currentBudget {
                budgetAmount = String(budget.amount)
            }
        }
    }

    // MARK: - Budget Ring

    private var budgetRing: some View {

        ZStack {

            Circle()
                .stroke(
                    Color.white.opacity(0.08),
                    lineWidth: 20
                )
                .frame(
                    width: 260,
                    height: 260
                )

            Circle()
                .trim(
                    from: 0,
                    to: progressValue
                )
                .stroke(
                    AngularGradient(
                        colors: [
                            .cyan,
                            .blue,
                            .pink,
                            .purple,
                            .mint,
                            .cyan
                        ],
                        center: .center
                    ),
                    style: StrokeStyle(
                        lineWidth: 20,
                        lineCap: .round
                    )
                )
                .frame(
                    width: 260,
                    height: 260
                )
                .rotationEffect(
                    .degrees(-90)
                )
                .shadow(
                    color: Color.purple.opacity(0.35),
                    radius: 10
                )

            Image(systemName: "sparkle")
                .font(.system(
                    size: 18,
                    weight: .bold
                ))
                .foregroundStyle(.yellow)
                .offset(
                    x: -145,
                    y: -75
                )

            Image(systemName: "sparkles")
                .font(.system(
                    size: 20,
                    weight: .bold
                ))
                .foregroundStyle(.purple)
                .offset(
                    x: 145,
                    y: -55
                )

            Image(systemName: "sparkle")
                .font(.system(
                    size: 15,
                    weight: .bold
                ))
                .foregroundStyle(.yellow)
                .offset(
                    x: 130,
                    y: 90
                )

            Image(systemName: "sparkle")
                .font(.system(
                    size: 16,
                    weight: .bold
                ))
                .foregroundStyle(.cyan)
                .offset(
                    x: -135,
                    y: 85
                )

            VStack(spacing: 5) {

                Text(languageManager.text(
                    english: "Monthly Budget",
                    hindi: "मासिक बजट",
                    marathi: "मासिक बजेट",
                    urdu: "ماہانہ بجٹ"
                ))
                .font(.system(
                    size: 14,
                    weight: .medium
                ))
                .foregroundStyle(
                    .white.opacity(0.55)
                )

                Text(
                    "₹\(currentBudget?.amount ?? 0, specifier: "%.0f")"
                )
                .font(.system(
                    size: 27,
                    weight: .bold,
                    design: .rounded
                ))
                .foregroundStyle(.white)

                Rectangle()
                    .fill(.white.opacity(0.12))
                    .frame(
                        width: 110,
                        height: 1
                    )
                    .padding(.vertical, 4)

                Text(languageManager.text(
                    english: "Total Spent",
                    hindi: "कुल खर्च",
                    marathi: "एकूण खर्च",
                    urdu: "کل خرچ"
                ))
                .font(.system(
                    size: 13,
                    weight: .medium
                ))
                .foregroundStyle(
                    .white.opacity(0.55)
                )

                Text(
                    "₹\(totalSpent, specifier: "%.0f")"
                )
                .font(.system(
                    size: 21,
                    weight: .bold,
                    design: .rounded
                ))
                .foregroundStyle(.pink)

                Rectangle()
                    .fill(.white.opacity(0.12))
                    .frame(
                        width: 110,
                        height: 1
                    )
                    .padding(.vertical, 4)

                Text(languageManager.text(
                    english: "Remaining",
                    hindi: "बाकी",
                    marathi: "शिल्लक",
                    urdu: "باقی"
                ))
                .font(.system(
                    size: 13,
                    weight: .medium
                ))
                .foregroundStyle(
                    .white.opacity(0.55)
                )

                Text(
                    "₹\(remainingAmount, specifier: "%.0f")"
                )
                .font(.system(
                    size: 22,
                    weight: .bold,
                    design: .rounded
                ))
                .foregroundStyle(
                    remainingAmount < 0
                    ? .red
                    : .mint
                )
            }
        }
    }

    // MARK: - Status Card

    private var statusCard: some View {

        HStack(spacing: 12) {

            // Icon

            Image(
                systemName:
                    budgetPercentage > 100
                    ? "exclamationmark.triangle.fill"
                    : budgetPercentage >= 100
                    ? "checkmark.circle.fill"
                    : budgetPercentage >= 80
                    ? "exclamationmark.circle.fill"
                    : "heart.fill"
            )
            .font(.system(
                size: 20,
                weight: .bold
            ))
            .foregroundStyle(
                budgetPercentage > 100
                ? .red
                : budgetPercentage >= 100
                ? .green
                : budgetPercentage >= 80
                ? .orange
                : .pink
            )
            .frame(
                width: 44,
                height: 44
            )
            .background(
                Circle()
                    .fill(
                        budgetPercentage > 100
                        ? Color.red.opacity(0.12)
                        : budgetPercentage >= 100
                        ? Color.green.opacity(0.12)
                        : budgetPercentage >= 80
                        ? Color.orange.opacity(0.12)
                        : Color.pink.opacity(0.12)
                    )
            )

            VStack(
                alignment: .leading,
                spacing: 4
            ) {

                // MARK: Status Title

                Text(
                    budgetPercentage > 100
                    ? languageManager.text(
                        english: "Budget Exceeded",
                        hindi: "बजट पार हो गया",
                        marathi: "बजेट ओलांडले",
                        urdu: "بجٹ سے تجاوز ہو گیا"
                    )
                    : budgetPercentage >= 100
                    ? languageManager.text(
                        english: "Budget Reached",
                        hindi: "बजट पूरा हो गया",
                        marathi: "बजेट पूर्ण झाले",
                        urdu: "بجٹ مکمل ہو گیا"
                    )
                    : budgetPercentage >= 80
                    ? languageManager.text(
                        english: "Budget Warning",
                        hindi: "बजट चेतावनी",
                        marathi: "बजेट चेतावणी",
                        urdu: "بجٹ کی وارننگ"
                    )
                    : languageManager.text(
                        english: "Stay on track!",
                        hindi: "सही रास्ते पर रहें!",
                        marathi: "योग्य मार्गावर रहा!",
                        urdu: "درست راستے پر رہیں!"
                    )
                )
                .font(.system(
                    size: 15,
                    weight: .bold,
                    design: .rounded
                ))
                .foregroundStyle(.white)

                // MARK: Status Message

                Text(
                    budgetPercentage > 100
                    ? languageManager.text(
                        english: "You have exceeded your monthly budget.",
                        hindi: "आपने अपना मासिक बजट पार कर लिया है।",
                        marathi: "तुम्ही तुमचे मासिक बजेट ओलांडले आहे.",
                        urdu: "آپ نے اپنا ماہانہ بجٹ پار کر لیا ہے۔"
                    )
                    : budgetPercentage >= 100
                    ? languageManager.text(
                        english: "You have reached your monthly budget.",
                        hindi: "आप अपने मासिक बजट तक पहुँच गए हैं।",
                        marathi: "तुम्ही तुमच्या मासिक बजेटपर्यंत पोहोचला आहात.",
                        urdu: "آپ اپنے ماہانہ بجٹ تک پہنچ گئے ہیں۔"
                    )
                    : budgetPercentage >= 80
                    ? languageManager.text(
                        english: "You have used 80% or more of your budget.",
                        hindi: "आपने अपने बजट का 80% या उससे अधिक उपयोग कर लिया है।",
                        marathi: "तुम्ही तुमच्या बजेटपैकी 80% किंवा त्याहून अधिक वापरले आहे.",
                        urdu: "آپ نے اپنے بجٹ کا 80٪ یا اس سے زیادہ استعمال کر لیا ہے۔"
                    )
                    : languageManager.text(
                        english: "Keep going and manage your spending wisely.",
                        hindi: "आगे बढ़ते रहें और समझदारी से खर्च करें।",
                        marathi: "पुढे चला आणि शहाणपणाने खर्च करा.",
                        urdu: "آگے بڑھیں اور سمجھداری سے خرچ کریں۔"
                    )
                )
                .font(.caption)
                .foregroundStyle(
                    Color.white.opacity(0.5)
                )
                .lineLimit(2)
            }

            Spacer()
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    Color.white.opacity(0.055)
                )
        )
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(
                    Color.white.opacity(0.08),
                    lineWidth: 1
                )
        }
    }

    // MARK: - Set Budget Card

    private var setBudgetCard: some View {

        VStack(
            alignment: .leading,
            spacing: 12
        ) {

            Text(languageManager.text(
                english: "Set Monthly Budget",
                hindi: "मासिक बजट सेट करें",
                marathi: "मासिक बजेट सेट करा",
                urdu: "ماہانہ بجٹ مقرر کریں"
            ))
            .font(.system(
                size: 14,
                weight: .semibold
            ))
            .foregroundStyle(
                Color.white.opacity(0.65)
            )

            HStack(spacing: 12) {

                Text("₹")
                    .font(.system(
                        size: 21,
                        weight: .bold
                    ))
                    .foregroundStyle(.cyan)

                TextField(
                    languageManager.text(
                        english: "Enter budget amount",
                        hindi: "बजट राशि दर्ज करें",
                        marathi: "बजेट रक्कम प्रविष्ट करा",
                        urdu: "بجٹ کی رقم درج کریں"
                    ),
                    text: $budgetAmount
                )
                .keyboardType(.decimalPad)
                .font(.system(
                    size: 17,
                    weight: .medium
                ))
                .foregroundStyle(.white)

                Button {

                    setBudget()

                } label: {

                    Text(languageManager.text(
                        english: "Set",
                        hindi: "सेट",
                        marathi: "सेट",
                        urdu: "سیٹ"
                    ))
                    .font(.system(
                        size: 15,
                        weight: .bold
                    ))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 18)
                    .padding(.vertical, 10)
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
                            cornerRadius: 13
                        )
                    )
                }
            }
            .padding(14)
            .background(
                RoundedRectangle(cornerRadius: 17)
                    .fill(
                        Color.white.opacity(0.07)
                    )
            )
            .overlay {
                RoundedRectangle(cornerRadius: 17)
                    .stroke(
                        Color.white.opacity(0.08),
                        lineWidth: 1
                    )
            }
        }
    }

    // MARK: - Category Card

    private func categoryCard(
        category: String,
        icon: String,
        colors: [Color]
    ) -> some View {

        let categoryTotal = expenses
            .filter {
                $0.category == category
            }
            .reduce(0) {
                $0 + $1.amount
            }

        let percentage: Double = {

            guard let budget = currentBudget,
                  budget.amount > 0 else {
                return 0
            }

            return min(
                (categoryTotal / budget.amount) * 100,
                100
            )

        }()

        return HStack(spacing: 14) {

            ZStack {

                Circle()
                    .fill(
                        LinearGradient(
                            colors: colors,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )

                Image(systemName: icon)
                    .font(.system(
                        size: 22,
                        weight: .bold
                    ))
                    .foregroundStyle(.white)
            }
            .frame(
                width: 58,
                height: 58
            )

            VStack(
                alignment: .leading,
                spacing: 7
            ) {

                HStack {

                    Text(
                        translatedCategory(category)
                    )
                    .font(.system(
                        size: 16,
                        weight: .bold,
                        design: .rounded
                    ))
                    .foregroundStyle(.white)

                    Spacer()

                    Text(
                        "\(Int(percentage))%"
                    )
                    .font(.system(
                        size: 13,
                        weight: .bold
                    ))
                    .foregroundStyle(colors[0])
                    .padding(.horizontal, 11)
                    .padding(.vertical, 6)
                    .background(
                        Capsule()
                            .fill(
                                colors[0].opacity(0.12)
                            )
                    )
                }

                Text(
                    "₹\(categoryTotal, specifier: "%.0f")"
                )
                .font(.system(
                    size: 13,
                    weight: .medium
                ))
                .foregroundStyle(
                    Color.white.opacity(0.55)
                )

                GeometryReader { geometry in

                    ZStack(
                        alignment: .leading
                    ) {

                        Capsule()
                            .fill(
                                Color.white.opacity(0.10)
                            )

                        Capsule()
                            .fill(
                                LinearGradient(
                                    colors: colors,
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(
                                width:
                                    geometry.size.width
                                    * CGFloat(percentage / 100)
                            )
                    }
                }
                .frame(height: 7)
            }

            Image(systemName: "chevron.right")
                .font(.system(
                    size: 13,
                    weight: .bold
                ))
                .foregroundStyle(
                    Color.white.opacity(0.35)
                )
        }
        .padding(13)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    Color.white.opacity(0.055)
                )
        )
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(
                    Color.white.opacity(0.07),
                    lineWidth: 1
                )
        }
    }

    // MARK: - Category Translation

    private func translatedCategory(
        _ category: String
    ) -> String {

        switch category {

        case "Food":

            return languageManager.text(
                english: "Food",
                hindi: "भोजन",
                marathi: "अन्न",
                urdu: "کھانا"
            )

        case "Travel":

            return languageManager.text(
                english: "Travel",
                hindi: "यात्रा",
                marathi: "प्रवास",
                urdu: "سفر"
            )

        case "Shopping":

            return languageManager.text(
                english: "Shopping",
                hindi: "खरीदारी",
                marathi: "खरेदी",
                urdu: "خریداری"
            )

        case "Education":

            return languageManager.text(
                english: "Education",
                hindi: "शिक्षा",
                marathi: "शिक्षण",
                urdu: "تعلیم"
            )

        default:

            return languageManager.text(
                english: "Others",
                hindi: "अन्य",
                marathi: "इतर",
                urdu: "دیگر"
            )
        }
    }

    // MARK: - Set Budget

    private func setBudget() {

        guard let amount = Double(budgetAmount),
              amount > 0 else {
            return
        }

        if let existingBudget = currentBudget {

            existingBudget.amount = amount

        } else {

            let newBudget = Budget(
                amount: amount,
                month: "Current Month"
            )

            modelContext.insert(newBudget)
        }

        try? modelContext.save()
    }
}

// MARK: - Preview

#Preview {

    NavigationStack {

        BudgetView()
            .environmentObject(
                LanguageManager()
            )
    }
}
