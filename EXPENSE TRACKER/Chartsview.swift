import SwiftUI
import SwiftData
import Charts

struct ChartsView: View {
    
    @EnvironmentObject var languageManager: LanguageManager
    @Query private var expenses: [Expense]
    
    @State private var selectedPeriod: SpendingPeriod = .thisMonth
    
    let categories = [
        "Food",
        "Travel",
        "Shopping",
        "Education",
        "Others"
    ]
    
    // MARK: - Spending Period
    
    enum SpendingPeriod: CaseIterable {
        case thisMonth
        case lastMonth
        case allTime
        
        var titleEnglish: String {
            switch self {
            case .thisMonth:
                return "This Month"
            case .lastMonth:
                return "Last Month"
            case .allTime:
                return "All Time"
            }
        }
        
        var titleHindi: String {
            switch self {
            case .thisMonth:
                return "इस महीने"
            case .lastMonth:
                return "पिछले महीने"
            case .allTime:
                return "सभी"
            }
        }
        
        var titleMarathi: String {
            switch self {
            case .thisMonth:
                return "या महिन्यात"
            case .lastMonth:
                return "मागील महिना"
            case .allTime:
                return "सर्व"
            }
        }
        
        var titleUrdu: String {
            switch self {
            case .thisMonth:
                return "اس ماہ"
            case .lastMonth:
                return "پچھلے ماہ"
            case .allTime:
                return "تمام"
            }
        }
    }
    
    // MARK: - Filtered Expenses
    
    var filteredExpenses: [Expense] {
        let calendar = Calendar.current
        let now = Date()
        
        switch selectedPeriod {
            
        case .thisMonth:
            guard let startOfMonth = calendar.date(
                from: calendar.dateComponents(
                    [.year, .month],
                    from: now
                )
            ) else {
                return expenses
            }
            
            return expenses.filter {
                $0.date >= startOfMonth && $0.date <= now
            }
            
        case .lastMonth:
            guard
                let currentMonthStart = calendar.date(
                    from: calendar.dateComponents(
                        [.year, .month],
                        from: now
                    )
                ),
                let lastMonthStart = calendar.date(
                    byAdding: .month,
                    value: -1,
                    to: currentMonthStart
                )
            else {
                return expenses
            }
            
            return expenses.filter {
                $0.date >= lastMonthStart &&
                $0.date < currentMonthStart
            }
            
        case .allTime:
            return expenses
        }
    }
    
    // MARK: - Category Totals
    
    var categoryTotals: [(category: String, amount: Double)] {
        categories.map { category in
            
            let total = filteredExpenses
                .filter { $0.category == category }
                .reduce(0) { $0 + $1.amount }
            
            return (category, total)
        }
    }
    
    // MARK: - Maximum Value
    
    var maximumAmount: Double {
        max(
            categoryTotals.map { $0.amount }.max() ?? 0,
            10
        )
    }
    
    // MARK: - Body
    
    var body: some View {
        
        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    // MARK: Header
                    
                    HStack(spacing: 10) {
                        
                        (
                            Text(
                                languageManager.text(
                                    english: "Spending ",
                                    hindi: "खर्च ",
                                    marathi: "खर्च ",
                                    urdu: "اخراجات "
                                )
                            )
                            .foregroundStyle(.white)
                            +
                            Text(
                                languageManager.text(
                                    english: "Chart",
                                    hindi: "चार्ट",
                                    marathi: "चार्ट",
                                    urdu: "چارٹ"
                                )
                            )
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.cyan, .blue],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                        )
                        .font(
                            .system(
                                size: 31,
                                weight: .bold,
                                design: .rounded
                            )
                        )
                        .lineLimit(1)
                        .minimumScaleFactor(0.65)
                        .fixedSize(
                            horizontal: false,
                            vertical: true
                        )
                        
                        Spacer(minLength: 5)
                        
                        // MARK: Period Menu
                        
                        Menu {
                            
                            Button {
                                selectedPeriod = .thisMonth
                            } label: {
                                HStack {
                                    Text(
                                        languageManager.text(
                                            english: "This Month",
                                            hindi: "इस महीने",
                                            marathi: "या महिन्यात",
                                            urdu: "اس ماہ"
                                        )
                                    )
                                    
                                    if selectedPeriod == .thisMonth {
                                        Image(systemName: "checkmark")
                                    }
                                }
                            }
                            
                            Button {
                                selectedPeriod = .lastMonth
                            } label: {
                                HStack {
                                    Text(
                                        languageManager.text(
                                            english: "Last Month",
                                            hindi: "पिछले महीने",
                                            marathi: "मागील महिना",
                                            urdu: "پچھلے ماہ"
                                        )
                                    )
                                    
                                    if selectedPeriod == .lastMonth {
                                        Image(systemName: "checkmark")
                                    }
                                }
                            }
                            
                            Button {
                                selectedPeriod = .allTime
                            } label: {
                                HStack {
                                    Text(
                                        languageManager.text(
                                            english: "All Time",
                                            hindi: "सभी",
                                            marathi: "सर्व",
                                            urdu: "تمام"
                                        )
                                    )
                                    
                                    if selectedPeriod == .allTime {
                                        Image(systemName: "checkmark")
                                    }
                                }
                            }
                            
                        } label: {
                            
                            HStack(spacing: 6) {
                                
                                Text(
                                    languageManager.text(
                                        english: selectedPeriod.titleEnglish,
                                        hindi: selectedPeriod.titleHindi,
                                        marathi: selectedPeriod.titleMarathi,
                                        urdu: selectedPeriod.titleUrdu
                                    )
                                )
                                .font(
                                    .system(
                                        size: 12,
                                        weight: .medium
                                    )
                                )
                                .foregroundStyle(
                                    Color.white.opacity(0.65)
                                )
                                .lineLimit(1)
                                
                                Image(
                                    systemName: "chevron.down"
                                )
                                .font(
                                    .system(
                                        size: 10,
                                        weight: .bold
                                    )
                                )
                                .foregroundStyle(
                                    Color.white.opacity(0.5)
                                )
                            }
                            .padding(.horizontal, 13)
                            .padding(.vertical, 11)
                            .background(
                                Capsule()
                                    .fill(
                                        Color.white.opacity(0.07)
                                    )
                            )
                            .overlay {
                                Capsule()
                                    .stroke(
                                        Color.white.opacity(0.08),
                                        lineWidth: 1
                                    )
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    // MARK: Decorative Line
                    
                    RoundedRectangle(cornerRadius: 10)
                        .fill(
                            LinearGradient(
                                colors: [
                                    .blue,
                                    .cyan,
                                    .clear
                                ],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(
                            width: 105,
                            height: 3
                        )
                        .padding(.leading, 20)
                        .padding(.top, 10)
                    
                    // MARK: Section Title
                    
                    Text(
                        languageManager.text(
                            english: "Spending by Category",
                            hindi: "श्रेणी के अनुसार खर्च",
                            marathi: "श्रेणीनुसार खर्च",
                            urdu: "زمرے کے لحاظ سے اخراجات"
                        )
                    )
                    .font(
                        .system(
                            size: 21,
                            weight: .bold,
                            design: .rounded
                        )
                    )
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.top, 28)
                    
                    // MARK: Chart
                    
                    if filteredExpenses.isEmpty {
                        
                        emptyChartView
                            .padding(.horizontal, 20)
                            .padding(.top, 25)
                        
                    } else {
                        
                        spendingChart
                            .padding(.horizontal, 14)
                            .padding(.top, 15)
                    }
                    
                    // MARK: Spending List
                    
                    if !filteredExpenses.isEmpty {
                        
                        spendingList
                            .padding(.horizontal, 20)
                            .padding(.top, 22)
                    }
                    
                    Spacer()
                        .frame(height: 35)
                }
            }
        }
        .navigationBarHidden(true)
        .preferredColorScheme(.dark)
    }
    
    // MARK: - Spending Chart
    
    private var spendingChart: some View {
        
        Chart {
            
            ForEach(
                Array(categoryTotals.enumerated()),
                id: \.element.category
            ) { index, item in
                
                // Bar
                
                BarMark(
                    x: .value(
                        "Category",
                        translatedCategory(item.category)
                    ),
                    y: .value(
                        "Amount",
                        item.amount
                    )
                )
                .foregroundStyle(
                    barGradient(for: index)
                )
                .cornerRadius(10)
                .annotation(
                    position: .top,
                    spacing: 7
                ) {
                    
                    Text("\(Int(item.amount))")
                        .font(
                            .system(
                                size: 12,
                                weight: .bold
                            )
                        )
                        .foregroundStyle(
                            barColor(for: index)
                        )
                }
                
                // Curved Line
                
                LineMark(
                    x: .value(
                        "Category",
                        translatedCategory(item.category)
                    ),
                    y: .value(
                        "Amount",
                        item.amount
                    )
                )
                .interpolationMethod(.catmullRom)
                .foregroundStyle(
                    Color.white.opacity(0.35)
                )
                .lineStyle(
                    StrokeStyle(
                        lineWidth: 1.5
                    )
                )
                
                // Point
                
                PointMark(
                    x: .value(
                        "Category",
                        translatedCategory(item.category)
                    ),
                    y: .value(
                        "Amount",
                        item.amount
                    )
                )
                .foregroundStyle(
                    barColor(for: index)
                )
                .symbolSize(45)
            }
        }
        .chartYScale(
            domain: 0...(maximumAmount * 1.18)
        )
        .chartYAxis {
            
            AxisMarks(position: .trailing) { _ in
                
                AxisGridLine()
                    .foregroundStyle(
                        Color.white.opacity(0.07)
                    )
                
                AxisValueLabel()
                    .foregroundStyle(
                        Color.white.opacity(0.35)
                    )
            }
        }
        .chartXAxis {
            
            AxisMarks { _ in
                
                AxisGridLine(
                    stroke: StrokeStyle(
                        lineWidth: 0
                    )
                )
                
                AxisValueLabel()
                    .foregroundStyle(
                        Color.white.opacity(0.55)
                    )
                    .font(
                        .system(
                            size: 11,
                            weight: .medium
                        )
                    )
            }
        }
        .frame(height: 330)
        .padding(.top, 5)
    }
    
    // MARK: - Empty Chart
    
    private var emptyChartView: some View {
        
        VStack(spacing: 15) {
            
            Image(systemName: "chart.bar.xaxis")
                .font(.system(size: 45))
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
            
            Text(
                languageManager.text(
                    english: emptyTitleEnglish,
                    hindi: emptyTitleHindi,
                    marathi: emptyTitleMarathi,
                    urdu: emptyTitleUrdu
                )
            )
            .font(
                .system(
                    size: 18,
                    weight: .bold
                )
            )
            .foregroundStyle(.white)
            
            Text(
                languageManager.text(
                    english: "Add some expenses to see your chart.",
                    hindi: "चार्ट देखने के लिए कुछ खर्च जोड़ें।",
                    marathi: "चार्ट पाहण्यासाठी काही खर्च जोडा.",
                    urdu: "اپنا چارٹ دیکھنے کے لیے کچھ اخراجات شامل کریں۔"
                )
            )
            .font(.caption)
            .foregroundStyle(
                Color.white.opacity(0.45)
            )
            .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 70)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(
                    Color.white.opacity(0.045)
                )
        )
        .overlay {
            RoundedRectangle(cornerRadius: 24)
                .stroke(
                    Color.white.opacity(0.08),
                    lineWidth: 1
                )
        }
    }
    
    // MARK: - Empty State Titles
    
    private var emptyTitleEnglish: String {
        switch selectedPeriod {
        case .thisMonth:
            return "No spending this month"
        case .lastMonth:
            return "No spending last month"
        case .allTime:
            return "No spending data yet"
        }
    }
    
    private var emptyTitleHindi: String {
        switch selectedPeriod {
        case .thisMonth:
            return "इस महीने कोई खर्च नहीं"
        case .lastMonth:
            return "पिछले महीने कोई खर्च नहीं"
        case .allTime:
            return "अभी कोई खर्च डेटा नहीं है"
        }
    }
    
    private var emptyTitleMarathi: String {
        switch selectedPeriod {
        case .thisMonth:
            return "या महिन्यात कोणताही खर्च नाही"
        case .lastMonth:
            return "मागील महिन्यात कोणताही खर्च नाही"
        case .allTime:
            return "अजून खर्चाचा डेटा नाही"
        }
    }
    
    private var emptyTitleUrdu: String {
        switch selectedPeriod {
        case .thisMonth:
            return "اس ماہ کوئی اخراجات نہیں"
        case .lastMonth:
            return "پچھلے ماہ کوئی اخراجات نہیں"
        case .allTime:
            return "ابھی اخراجات کا کوئی ڈیٹا نہیں ہے"
        }
    }
    
    // MARK: - Spending List
    
    private var spendingList: some View {
        
        let visibleCategories = categoryTotals.filter {
            $0.amount > 0
        }
        
        return VStack(spacing: 0) {
            
            ForEach(
                Array(visibleCategories.enumerated()),
                id: \.element.category
            ) { index, item in
                
                HStack(spacing: 14) {
                    
                    // Category Emoji
                    
                    Text(
                        categoryEmoji(item.category)
                    )
                    .font(.system(size: 22))
                    .frame(
                        width: 35,
                        height: 35
                    )
                    .background(
                        Circle()
                            .fill(
                                barColor(for: index)
                                    .opacity(0.13)
                            )
                    )
                    
                    // Category Name
                    
                    Text(
                        translatedCategory(
                            item.category
                        )
                    )
                    .font(
                        .system(
                            size: 17,
                            weight: .medium,
                            design: .rounded
                        )
                    )
                    .foregroundStyle(.white)
                    
                    Spacer()
                    
                    // Amount
                    
                    Text(
                        "₹\(item.amount, specifier: "%.2f")"
                    )
                    .font(
                        .system(
                            size: 17,
                            weight: .bold,
                            design: .rounded
                        )
                    )
                    .foregroundStyle(.white)
                    
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
                        Color.white.opacity(0.35)
                    )
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
                
                if index < visibleCategories.count - 1 {
                    
                    Divider()
                        .overlay(
                            Color.white.opacity(0.07)
                        )
                }
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 22)
                .fill(
                    Color.white.opacity(0.045)
                )
        )
        .overlay {
            RoundedRectangle(cornerRadius: 22)
                .stroke(
                    Color.white.opacity(0.07),
                    lineWidth: 1
                )
        }
    }
    
    // MARK: - Category Emoji
    
    private func categoryEmoji(
        _ category: String
    ) -> String {
        
        switch category {
            
        case "Food":
            return "🍔"
            
        case "Travel":
            return "✈️"
            
        case "Shopping":
            return "🛍️"
            
        case "Education":
            return "📚"
            
        default:
            return "✨"
        }
    }
    
    // MARK: - Colors
    
    private func barColor(
        for index: Int
    ) -> Color {
        
        let colors: [Color] = [
            .cyan,
            .blue,
            .pink,
            .purple,
            .indigo
        ]
        
        return colors[
            index % colors.count
        ]
    }
    
    private func barGradient(
        for index: Int
    ) -> LinearGradient {
        
        let gradients: [[Color]] = [
            [.cyan, .blue],
            [.blue, .purple],
            [.pink, .purple],
            [.blue, .cyan],
            [.purple, .blue]
        ]
        
        let selected =
            gradients[
                index % gradients.count
            ]
        
        return LinearGradient(
            colors: selected,
            startPoint: .top,
            endPoint: .bottom
        )
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
}

#Preview {
    
    NavigationStack {
        
        ChartsView()
            .environmentObject(
                LanguageManager()
            )
    }
}
