import SwiftUI
import SwiftData

struct ContentView: View {

    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var languageManager: LanguageManager

    @Query private var expenses: [Expense]

    @State private var searchText = ""
    @State private var showLanguagePicker = false

    // MARK: - Total Expense

    var totalExpense: Double {
        expenses.reduce(0) { $0 + $1.amount }
    }

    // MARK: - Filtered Expenses

    var filteredExpenses: [Expense] {

        if searchText.isEmpty {
            return expenses
        }

        return expenses.filter {
            $0.category.localizedCaseInsensitiveContains(searchText) ||
            $0.note.localizedCaseInsensitiveContains(searchText)
        }
    }

    // MARK: - Delete Expense

    private func deleteExpense(at offsets: IndexSet) {

        for index in offsets {
            let expense = filteredExpenses[index]
            modelContext.delete(expense)
        }

        try? modelContext.save()
    }

    // MARK: - Body

    var body: some View {

        TabView {

            // =====================================================
            // MARK: HOME
            // =====================================================

            NavigationStack {

                ZStack(alignment: .bottomTrailing) {

                    Color.black
                        .ignoresSafeArea()

                    VStack(spacing: 0) {

                        // MARK: Main Content

                        List {

                            // -------------------------------------------------
                            // HEADER
                            // -------------------------------------------------

                            VStack(spacing: 15) {

                                // MARK: Dashboard Header

                                HStack {

                                    HStack(spacing: 10) {

                                        cuteTitleDecoration

                                        Text(
                                            languageManager.dashboard
                                        )
                                        .font(
                                            .system(
                                                size: 34,
                                                weight: .bold,
                                                design: .rounded
                                            )
                                        )
                                        .foregroundStyle(.white)
                                    }

                                    Spacer()

                                    Button {
                                        showLanguagePicker = true
                                    } label: {

                                        Text("अA")
                                            .font(
                                                .system(
                                                    size: 19,
                                                    weight: .bold
                                                )
                                            )
                                            .foregroundStyle(.white)
                                            .frame(
                                                width: 49,
                                                height: 49
                                            )
                                            .background(
                                                Circle()
                                                    .fill(Color.black)
                                                    .overlay(
                                                        Circle()
                                                            .stroke(
                                                                LinearGradient(
                                                                    colors: [
                                                                        Color.purple,
                                                                        Color.blue,
                                                                        Color.cyan
                                                                    ],
                                                                    startPoint: .topLeading,
                                                                    endPoint: .bottomTrailing
                                                                ),
                                                                lineWidth: 1.5
                                                            )
                                                    )
                                            )
                                            .shadow(
                                                color: Color.purple.opacity(0.3),
                                                radius: 8
                                            )
                                    }
                                    .buttonStyle(.plain)
                                }

                                // MARK: Search Bar

                                HStack(spacing: 12) {

                                    Image(
                                        systemName: "magnifyingglass"
                                    )
                                    .font(.title3)
                                    .foregroundStyle(
                                        Color.white.opacity(0.65)
                                    )

                                    TextField(
                                        languageManager.searchExpenses,
                                        text: $searchText
                                    )
                                    .foregroundStyle(.white)
                                    .tint(.cyan)
                                }
                                .padding(.horizontal, 17)
                                .frame(height: 52)
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: 27
                                    )
                                    .fill(
                                        Color.white.opacity(0.08)
                                    )
                                    .overlay(
                                        RoundedRectangle(
                                            cornerRadius: 27
                                        )
                                        .stroke(
                                            Color.white.opacity(0.08),
                                            lineWidth: 1
                                        )
                                    )
                                )

                                // MARK: Total Spent

                                totalSpentCard
                            }
                            .listRowBackground(Color.clear)
                            .listRowInsets(
                                EdgeInsets(
                                    top: 5,
                                    leading: 0,
                                    bottom: 5,
                                    trailing: 0
                                )
                            )

                            // -------------------------------------------------
                            // RECENT EXPENSES HEADER
                            // -------------------------------------------------

                            HStack {

                                Text(
                                    languageManager.recentExpenses
                                )
                                .font(
                                    .system(
                                        size: 24,
                                        weight: .bold,
                                        design: .rounded
                                    )
                                )
                                .foregroundStyle(.white)

                                Spacer()

                                if !filteredExpenses.isEmpty {

                                    Text(
                                        languageManager.text(
                                            english: "View all",
                                            hindi: "सभी देखें",
                                            marathi: "सर्व पहा",
                                            urdu: "سب دیکھیں"
                                        )
                                    )
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.cyan)
                                }
                            }
                            .listRowBackground(Color.clear)
                            .listRowInsets(
                                EdgeInsets(
                                    top: 6,
                                    leading: 0,
                                    bottom: 5,
                                    trailing: 0
                                )
                            )

                            // -------------------------------------------------
                            // EXPENSES
                            // -------------------------------------------------

                            if filteredExpenses.isEmpty {

                                VStack(spacing: 14) {

                                    Image(
                                        systemName: "tray.fill"
                                    )
                                    .font(
                                        .system(
                                            size: 45
                                        )
                                    )
                                    .foregroundStyle(
                                        Color.purple.opacity(0.8)
                                    )

                                    Text(
                                        searchText.isEmpty
                                        ? languageManager.noExpenses
                                        : languageManager.noMatchingExpenses
                                    )
                                    .foregroundStyle(
                                        Color.white.opacity(0.6)
                                    )
                                }
                                .frame(
                                    maxWidth: .infinity
                                )
                                .padding(.vertical, 60)
                                .listRowBackground(Color.clear)

                            } else {

                                ForEach(
                                    filteredExpenses
                                ) { expense in

                                    NavigationLink {

                                        EditExpenseView(
                                            expense: expense
                                        )

                                    } label: {

                                        expenseCard(
                                            expense: expense
                                        )
                                    }
                                    .buttonStyle(.plain)
                                    .listRowBackground(
                                        Color.clear
                                    )
                                    .listRowInsets(
                                        EdgeInsets(
                                            top: 5,
                                            leading: 0,
                                            bottom: 5,
                                            trailing: 0
                                        )
                                    )
                                }
                                .onDelete(
                                    perform: deleteExpense
                                )
                            }

                            // -------------------------------------------------
                            // BOTTOM WAVES
                            // -------------------------------------------------

                            decorativeWaves
                                .listRowBackground(Color.clear)
                                .listRowInsets(
                                    EdgeInsets(
                                        top: 5,
                                        leading: 0,
                                        bottom: 10,
                                        trailing: 0
                                    )
                                )
                        }
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                        .background(Color.black)
                    }

                    // =====================================================
                    // MARK: FLOATING PLUS BUTTON
                    // =====================================================

                    ZStack {

                        Image(systemName: "sparkle")
                            .font(.system(size: 15))
                            .foregroundStyle(
                                Color.purple
                            )
                            .offset(
                                x: 28,
                                y: -31
                            )

                        Image(systemName: "sparkle")
                            .font(.system(size: 9))
                            .foregroundStyle(
                                Color.cyan
                            )
                            .offset(
                                x: 38,
                                y: -18
                            )

                        Image(systemName: "leaf.fill")
                            .font(.system(size: 13))
                            .foregroundStyle(
                                Color.purple
                            )
                            .rotationEffect(
                                .degrees(30)
                            )
                            .offset(
                                x: 29,
                                y: -18
                            )

                        Image(systemName: "leaf.fill")
                            .font(.system(size: 10))
                            .foregroundStyle(
                                Color.cyan
                            )
                            .rotationEffect(
                                .degrees(-25)
                            )
                            .offset(
                                x: 35,
                                y: -5
                            )

                        NavigationLink {
                            AddExpenseView()
                        } label: {

                            ZStack {

                                Circle()
                                    .fill(
                                        LinearGradient(
                                            colors: [
                                                Color.cyan,
                                                Color.blue,
                                                Color.purple
                                            ],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )

                                Circle()
                                    .stroke(
                                        Color.white.opacity(0.20),
                                        lineWidth: 1
                                    )

                                Image(
                                    systemName: "plus"
                                )
                                .font(
                                    .system(
                                        size: 29,
                                        weight: .medium
                                    )
                                )
                                .foregroundStyle(.white)
                            }
                            .frame(
                                width: 66,
                                height: 66
                            )
                            .shadow(
                                color: Color.blue.opacity(0.55),
                                radius: 15,
                                y: 6
                            )
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(
                        .trailing,
                        22
                    )
                    .padding(
                        .bottom,
                        24
                    )
                }
                .toolbar(.hidden, for: .navigationBar)
                .sheet(
                    isPresented: $showLanguagePicker
                ) {
                    LanguagePickerView()
                }
            }
            .tabItem {
                Label(
                    languageManager.text(
                        english: "Home",
                        hindi: "होम",
                        marathi: "होम",
                        urdu: "ہوم"
                    ),
                    systemImage: "house.fill"
                )
            }

            // =====================================================
            // MARK: CHART
            // =====================================================

            NavigationStack {
                ChartsView()
            }
            .preferredColorScheme(.dark)
            .tabItem {
                Label(
                    languageManager.text(
                        english: "Chart",
                        hindi: "चार्ट",
                        marathi: "चार्ट",
                        urdu: "چارٹ"
                    ),
                    systemImage: "chart.bar.fill"
                )
            }

            // =====================================================
            // MARK: BUDGET
            // =====================================================

            NavigationStack {
                BudgetView()
            }
            .preferredColorScheme(.dark)
            .tabItem {
                Label(
                    languageManager.text(
                        english: "Budget",
                        hindi: "बजट",
                        marathi: "बजेट",
                        urdu: "بجٹ"
                    ),
                    systemImage: "indianrupeesign.circle"
                )
            }

            // =====================================================
            // MARK: SETTINGS
            // =====================================================

            NavigationStack {
                SettingsView()
            }
            .preferredColorScheme(.dark)
            .tabItem {
                Label(
                    languageManager.text(
                        english: "Settings",
                        hindi: "सेटिंग्स",
                        marathi: "सेटिंग्ज",
                        urdu: "ترتیبات"
                    ),
                    systemImage: "gearshape.fill"
                )
            }
        }
        .preferredColorScheme(.dark)
    }

    // =============================================================
    // MARK: CUTE TITLE DECORATION
    // =============================================================

    private var cuteTitleDecoration: some View {

        ZStack {

            Image(systemName: "leaf.fill")
                .font(.system(size: 17))
                .foregroundStyle(
                    Color.cyan
                )
                .rotationEffect(
                    .degrees(-35)
                )
                .offset(
                    x: -3,
                    y: -8
                )

            Image(systemName: "leaf.fill")
                .font(.system(size: 13))
                .foregroundStyle(
                    Color.purple
                )
                .rotationEffect(
                    .degrees(28)
                )
                .offset(
                    x: 5,
                    y: 7
                )

            Image(systemName: "sparkle")
                .font(.system(size: 10))
                .foregroundStyle(
                    Color.pink
                )
                .offset(
                    x: 12,
                    y: -13
                )

            Image(systemName: "sparkle")
                .font(.system(size: 7))
                .foregroundStyle(
                    Color.blue
                )
                .offset(
                    x: -11,
                    y: 10
                )
        }
        .frame(
            width: 28,
            height: 45
        )
    }

    // =============================================================
    // MARK: TOTAL SPENT CARD
    // =============================================================

    private var totalSpentCard: some View {

        ZStack {

            RoundedRectangle(
                cornerRadius: 28
            )
            .fill(
                LinearGradient(
                    colors: [
                        Color.cyan,
                        Color.blue,
                        Color.purple,
                        Color.pink
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )

            // Background bubbles

            Circle()
                .fill(
                    Color.white.opacity(0.10)
                )
                .frame(
                    width: 155
                )
                .offset(
                    x: 125,
                    y: -55
                )

            Circle()
                .fill(
                    Color.white.opacity(0.08)
                )
                .frame(
                    width: 100
                )
                .offset(
                    x: 145,
                    y: 58
                )

            HStack {

                VStack(
                    alignment: .leading,
                    spacing: 11
                ) {

                    HStack(spacing: 10) {

                        Image(
                            systemName:
                                "wallet.pass.fill"
                        )
                        .font(.title2)

                        Text(
                            languageManager.totalSpent
                        )
                        .font(
                            .system(
                                size: 18,
                                weight: .semibold
                            )
                        )
                    }

                    Text(
                        "₹\(totalExpense, specifier: "%.2f")"
                    )
                    .font(
                        .system(
                            size: 38,
                            weight: .bold,
                            design: .rounded
                        )
                    )

                    HStack(spacing: 7) {

                        Image(
                            systemName:
                                "calendar"
                        )

                        Text(
                            languageManager.text(
                                english:
                                    "Your spending this month",
                                hindi:
                                    "इस महीने का आपका खर्च",
                                marathi:
                                    "या महिन्यातील तुमचा खर्च",
                                urdu:
                                    "اس مہینے کا آپ کا خرچ"
                            )
                        )
                    }
                    .font(.caption)
                }

                Spacer()

                walletIllustration
            }
            .foregroundStyle(.white)
            .padding(18)
        }
        .frame(
            height: 190
        )
        .clipShape(
            RoundedRectangle(
                cornerRadius: 28
            )
        )
        .shadow(
            color:
                Color.blue.opacity(0.35),
            radius: 15,
            y: 7
        )
    }

    // =============================================================
    // MARK: WALLET ILLUSTRATION
    // =============================================================

    private var walletIllustration: some View {

        ZStack {

            // -------------------------
            // Back leaves
            // -------------------------

            Image(systemName: "leaf.fill")
                .font(.system(size: 22))
                .foregroundStyle(
                    Color.cyan.opacity(0.9)
                )
                .rotationEffect(
                    .degrees(-35)
                )
                .offset(
                    x: -40,
                    y: 18
                )

            Image(systemName: "leaf.fill")
                .font(.system(size: 17))
                .foregroundStyle(
                    Color.mint.opacity(0.95)
                )
                .rotationEffect(
                    .degrees(27)
                )
                .offset(
                    x: -25,
                    y: 10
                )

            Image(systemName: "leaf.fill")
                .font(.system(size: 17))
                .foregroundStyle(
                    Color.cyan.opacity(0.85)
                )
                .rotationEffect(
                    .degrees(35)
                )
                .offset(
                    x: -43,
                    y: 43
                )

            Image(systemName: "leaf.fill")
                .font(.system(size: 14))
                .foregroundStyle(
                    Color.purple.opacity(0.9)
                )
                .rotationEffect(
                    .degrees(-25)
                )
                .offset(
                    x: 48,
                    y: 28
                )

            // -------------------------
            // Coins
            // -------------------------

            ZStack {

                Circle()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.yellow,
                                Color.orange
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(
                        width: 31,
                        height: 31
                    )
                    .overlay {

                        Text("₹")
                            .font(
                                .system(
                                    size: 14,
                                    weight: .bold
                                )
                            )
                            .foregroundStyle(.white)
                    }
                    .offset(
                        x: -7,
                        y: -2
                    )

                Circle()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.yellow,
                                Color.orange
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(
                        width: 34,
                        height: 34
                    )
                    .overlay {

                        Text("₹")
                            .font(
                                .system(
                                    size: 15,
                                    weight: .bold
                                )
                            )
                            .foregroundStyle(.white)
                    }
                    .offset(
                        x: 13,
                        y: -10
                    )
            }

            // -------------------------
            // Wallet back layer
            // -------------------------

            RoundedRectangle(
                cornerRadius: 10
            )
            .fill(
                Color.indigo.opacity(0.95)
            )
            .frame(
                width: 83,
                height: 55
            )
            .offset(
                x: -8,
                y: 7
            )

            // -------------------------
            // Main wallet
            // -------------------------

            ZStack {

                RoundedRectangle(
                    cornerRadius: 11
                )
                .fill(
                    LinearGradient(
                        colors: [
                            Color.blue,
                            Color.indigo
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

                RoundedRectangle(
                    cornerRadius: 11
                )
                .stroke(
                    Color.white.opacity(0.22),
                    lineWidth: 1
                )

                HStack {

                    Spacer()

                    Circle()
                        .fill(
                            Color.white.opacity(0.85)
                        )
                        .frame(
                            width: 10,
                            height: 10
                        )

                    Spacer()
                        .frame(width: 10)
                }
            }
            .frame(
                width: 86,
                height: 56
            )
            .rotationEffect(
                .degrees(-5)
            )
            .offset(
                x: 5,
                y: 13
            )

            // -------------------------
            // Wallet clasp
            // -------------------------

            Capsule()
                .fill(
                    Color.white.opacity(0.78)
                )
                .frame(
                    width: 7,
                    height: 14
                )
                .rotationEffect(
                    .degrees(-5)
                )
                .offset(
                    x: 43,
                    y: 14
                )

            // -------------------------
            // Sparkles
            // -------------------------

            Image(systemName: "sparkle")
                .font(.system(size: 15))
                .foregroundStyle(.white)
                .offset(
                    x: 48,
                    y: -43
                )

            Image(systemName: "sparkle")
                .font(.system(size: 8))
                .foregroundStyle(
                    Color.white.opacity(0.85)
                )
                .offset(
                    x: 61,
                    y: -28
                )
        }
        .frame(
            width: 135,
            height: 125
        )
    }

    // =============================================================
    // MARK: EXPENSE CARD
    // =============================================================

    private func expenseCard(
        expense: Expense
    ) -> some View {

        HStack(spacing: 14) {

            // Category icon

            ZStack {

                Circle()
                    .fill(
                        categoryColor(
                            expense.category
                        )
                    )

                Image(
                    systemName:
                        categoryIcon(
                            expense.category
                        )
                )
                .font(
                    .system(
                        size: 22,
                        weight: .medium
                    )
                )
                .foregroundStyle(.white)
            }
            .frame(
                width: 56,
                height: 56
            )

            // Details

            VStack(
                alignment: .leading,
                spacing: 4
            ) {

                Text(
                    translatedCategory(
                        expense.category
                    )
                )
                .font(
                    .system(
                        size: 18,
                        weight: .bold,
                        design: .rounded
                    )
                )
                .foregroundStyle(.white)

                if !expense.note.isEmpty {

                    Text(expense.note)
                        .font(.subheadline)
                        .foregroundStyle(
                            Color.white.opacity(0.72)
                        )
                        .lineLimit(1)
                }

                Text(
                    expense.date,
                    style: .date
                )
                .font(.caption)
                .foregroundStyle(
                    Color.white.opacity(0.52)
                )
            }

            Spacer()

            VStack(
                alignment: .trailing,
                spacing: 7
            ) {

                Text(
                    "₹\(expense.amount, specifier: "%.2f")"
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
                    systemName:
                        "chevron.right"
                )
                .font(
                    .caption
                )
                .fontWeight(.bold)
                .foregroundStyle(
                    Color.white.opacity(0.50)
                )
            }
        }
        .padding(15)
        .frame(
            maxWidth: .infinity,
            minHeight: 103
        )
        .background(
            categoryBackground(
                expense.category
            )
        )
        .overlay {

            RoundedRectangle(
                cornerRadius: 22
            )
            .stroke(
                categoryColor(
                    expense.category
                )
                .opacity(0.35),
                lineWidth: 1
            )
        }
        .clipShape(
            RoundedRectangle(
                cornerRadius: 22
            )
        )
    }

    // =============================================================
    // MARK: CATEGORY COLOR
    // =============================================================

    private func categoryColor(
        _ category: String
    ) -> Color {

        switch category {

        case "Food":
            return Color.pink

        case "Travel":
            return Color.orange

        case "Shopping":
            return Color.cyan

        case "Education":
            return Color.purple

        default:
            return Color.blue
        }
    }

    // =============================================================
    // MARK: CATEGORY BACKGROUND
    // =============================================================

    private func categoryBackground(
        _ category: String
    ) -> LinearGradient {

        switch category {

        case "Food":

            return LinearGradient(
                colors: [
                    Color.pink.opacity(0.20),
                    Color.purple.opacity(0.12)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

        case "Travel":

            return LinearGradient(
                colors: [
                    Color.orange.opacity(0.20),
                    Color.pink.opacity(0.10)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

        case "Shopping":

            return LinearGradient(
                colors: [
                    Color.cyan.opacity(0.20),
                    Color.blue.opacity(0.11)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

        case "Education":

            return LinearGradient(
                colors: [
                    Color.purple.opacity(0.22),
                    Color.blue.opacity(0.12)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

        default:

            return LinearGradient(
                colors: [
                    Color.blue.opacity(0.20),
                    Color.indigo.opacity(0.12)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }

    // =============================================================
    // MARK: CATEGORY ICON
    // =============================================================

    private func categoryIcon(
        _ category: String
    ) -> String {

        switch category {

        case "Food":
            return "fork.knife"

        case "Travel":
            return "airplane"

        case "Shopping":
            return "bag.fill"

        case "Education":
            return "graduationcap.fill"

        default:
            return "ellipsis.circle.fill"
        }
    }

    // =============================================================
    // MARK: DECORATIVE WAVES
    // =============================================================

    private var decorativeWaves: some View {

        ZStack(alignment: .bottom) {

            WaveShape()
                .fill(
                    LinearGradient(
                        colors: [
                            Color.purple.opacity(0.45),
                            Color.blue.opacity(0.45)
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(
                    height: 65
                )

            WaveShape()
                .fill(
                    LinearGradient(
                        colors: [
                            Color.blue.opacity(0.65),
                            Color.cyan.opacity(0.30)
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(
                    height: 42
                )

            HStack {

                Image(
                    systemName:
                        "leaf.fill"
                )
                .font(
                    .system(size: 29)
                )
                .foregroundStyle(
                    Color.cyan.opacity(0.90)
                )
                .rotationEffect(
                    .degrees(-25)
                )

                Spacer()
            }
            .padding(.leading, 8)
            .padding(.bottom, 4)
        }
        .frame(height: 65)
    }

    // =============================================================
    // MARK: TRANSLATION
    // =============================================================

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

// =============================================================
// MARK: WAVE SHAPE
// =============================================================

struct WaveShape: Shape {

    func path(
        in rect: CGRect
    ) -> Path {

        var path = Path()

        path.move(
            to: CGPoint(
                x: 0,
                y: rect.height * 0.65
            )
        )

        path.addCurve(
            to: CGPoint(
                x: rect.width * 0.35,
                y: rect.height * 0.35
            ),
            control1: CGPoint(
                x: rect.width * 0.12,
                y: rect.height * 0.15
            ),
            control2: CGPoint(
                x: rect.width * 0.22,
                y: rect.height * 0.80
            )
        )

        path.addCurve(
            to: CGPoint(
                x: rect.width * 0.70,
                y: rect.height * 0.50
            ),
            control1: CGPoint(
                x: rect.width * 0.48,
                y: rect.height * 0.05
            ),
            control2: CGPoint(
                x: rect.width * 0.58,
                y: rect.height * 0.75
            )
        )

        path.addCurve(
            to: CGPoint(
                x: rect.width,
                y: rect.height * 0.35
            ),
            control1: CGPoint(
                x: rect.width * 0.82,
                y: rect.height * 0.15
            ),
            control2: CGPoint(
                x: rect.width * 0.92,
                y: rect.height * 0.45
            )
        )

        path.addLine(
            to: CGPoint(
                x: rect.width,
                y: rect.height
            )
        )

        path.addLine(
            to: CGPoint(
                x: 0,
                y: rect.height
            )
        )

        path.closeSubpath()

        return path
    }
}

// =============================================================
// MARK: PREVIEW
// =============================================================

#Preview {
    ContentView()
        .environmentObject(
            LanguageManager()
        )
}
