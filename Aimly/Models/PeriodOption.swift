import Foundation

struct PeriodOption: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let days: Int
}

let periods: [PeriodOption] = [
    PeriodOption(title: "1 Week", days: 7),
    PeriodOption(title: "2 Weeks", days: 14),
    PeriodOption(title: "1 Month (30 Days)", days: 30),
    PeriodOption(title: "3 Months (90 Days)", days: 90),
    PeriodOption(title: "6 Months (180 Days)", days: 180),
    PeriodOption(title: "1 Year (365 Days)", days: 365)
]
