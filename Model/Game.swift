import Foundation

/// Represents a PlayStation game tracked by the PlatTrack application
struct Game: Identifiable {

    /// Unique identifier for the game
    let id: UUID
    
    /// Title of the game
    var title: String
    
    /// Platform the game is played on
    var platform: String
    
    /// Trophy statistics for the game
    var trophyStats: TrophyStats
    
    /// Indicates whether the platinum trophy has been earned
    var isPlatinumEarned: Bool
    
    /// Optional notes about the game
    var notes: String? = nil
    
    /// Date the game was released
    var releaseDate: Date
    
    /// Status of the player's completion progress
    var completionStatus: CompletionStatus
    
    /// Computed property returning total trophies earned
    var totalTrophiesEarned: Int {
        trophyStats.bronze + trophyStats.silver + trophyStats.gold + trophyStats.platinum
    }
}
