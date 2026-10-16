import Foundation
import SwiftData

@Model
class Budget {
    
    var amount: Double
    var month: String
    
    init(amount: Double, month: String) {
        self.amount = amount
        self.month = month
    }
}
