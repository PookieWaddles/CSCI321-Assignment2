import Foundation

extension Game {

    /// Sample data used for testing
    static let sampleData: [Game] = [
        
        Game(
            id: UUID(),
            title: "Spider-Man 2",
            platform: "PS5",
            trophyStats: TrophyStats(bronze: 30, silver: 15, gold: 5, platinum: 1),
            isPlatinumEarned: true,
            notes: "One of my favorite platinums!",
            releaseDate: Date(),
            completionStatus: .platinum
        ),
        
        Game(
            id: UUID(),
            title: "God of War Ragnarok",
            platform: "PS5",
            trophyStats: TrophyStats(bronze: 28, silver: 10, gold: 8, platinum: 1),
            isPlatinumEarned: true,
            notes: "Amazing story and combat.",
            releaseDate: Date(),
            completionStatus: .platinum
        ),
        
        Game(
            id: UUID(),
            title: "Batman Arkham City",
            platform: "PS4",
            trophyStats: TrophyStats(bronze: 40, silver: 10, gold: 5, platinum: 0),
            isPlatinumEarned: false,
            notes: "Currently trophy hunting.",
            releaseDate: Date(),
            completionStatus: .inProgress
        ),
        
        Game(
            id: UUID(),
            title: "Minecraft",
            platform: "PS4",
            trophyStats: TrophyStats(bronze: 20, silver: 5, gold: 2, platinum: 0),
            isPlatinumEarned: false,
            notes: nil,
            releaseDate: Date(),
            completionStatus: .custom(65.0)
        ),
        
        Game(
            id: UUID(),
            title: "Elden Ring",
            platform: "PS5",
            trophyStats: TrophyStats(bronze: 25, silver: 10, gold: 5, platinum: 0),
            isPlatinumEarned: false,
            notes: "Very challenging!",
            releaseDate: Date(),
            completionStatus: .inProgress
        )
    ]
}
