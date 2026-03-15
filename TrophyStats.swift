import Foundation

/// Represents trophy counts for a game
struct TrophyStats {

    var bronze: Int
    var silver: Int
    var gold: Int
    var platinum: Int
}

/// Represents the completion status of a game
enum CompletionStatus {
    
    case notStarted
    case inProgress
    case completed
    case platinum
    case custom(Double)
}
