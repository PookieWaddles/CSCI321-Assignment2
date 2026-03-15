import Foundation

//
// Game.swift
// PlatTrack
//
// CSCI 321 Assignment 2
// Defines the primary data model representing a game tracked for trophies.
//

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

//
// TrophyStats.swift
// Secondary model supporting the Game model
//

/// Represents trophy counts for a game
struct TrophyStats {
    
    /// Number of bronze trophies
    var bronze: Int
    
    /// Number of silver trophies
    var silver: Int
    
    /// Number of gold trophies
    var gold: Int
    
    /// Number of platinum trophies
    var platinum: Int
}

//
// CompletionStatus.swift
// Enum representing progress state
//

/// Represents the completion status of a game
enum CompletionStatus {
    
    /// Game has not been started
    case notStarted
    
    /// Game is currently in progress
    case inProgress
    
    /// Game has been completed
    case completed
    
    /// Player has earned the platinum trophy
    case platinum
    
    /// Custom completion percentage
    case custom(Double)
}

//
// SampleData.swift
// Provides sample games for testing
//

extension Game {
    
    /// Sample data used for testing and previews
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

// MARK: - Exercise 1: Error Handling
// Z-ID: Z1948468
/// Errors that can occur during validation
enum ValidationError: Error {
    case emptyField(fieldName: String)
    case invalidFormat(fieldName: String)
    case valueTooLong(fieldName: String, maxLength: Int)
}

/// Validates a username according to several rules
func validateUsername(_ username: String?) throws -> String {
    
    guard let username = username else {
        throw ValidationError.emptyField(fieldName: "username")
    }
    
    if username.isEmpty {
        throw ValidationError.emptyField(fieldName: "username")
    }
    
    if username.count > 20 {
        throw ValidationError.valueTooLong(fieldName: "username", maxLength: 20)
    }
    
    let allowedCharacters = CharacterSet.alphanumerics
    
    if username.rangeOfCharacter(from: allowedCharacters.inverted) != nil {
        throw ValidationError.invalidFormat(fieldName: "username")
    }
    
    return username
}

// Using do-catch
do {
    let validUser = try validateUsername("Player123")
    print("Valid username:", validUser)
} catch {
    print("Validation failed:", error)
}

// Using try?
let optionalUser = try? validateUsername("Invalid@Name")
print("Result using try?:", optionalUser as Any)

// Using try! (safe because input is valid)
let forcedUser = try! validateUsername("SafeUsername")
print("Result using try!:", forcedUser)

/*
 do-catch is used when you want to handle errors explicitly and respond to them.

 try? converts the result into an optional. If an error occurs, the result becomes nil.

 try! should only be used when you are absolutely certain the function will not throw an error.
 If an error occurs, the program will crash.
*/

// MARK: - Exercise 2: Protocols
// Z-ID: Z1948468
/// A protocol representing objects that can display formatted information
protocol Displayable {
    
    /// Main title for display
    var title: String { get }
    
    /// Subtitle or secondary text
    var subtitle: String { get }
    
    /// Returns a formatted description
    func formattedDescription() -> String
}

extension Game: Displayable {
    
    var subtitle: String {
        platform
    }
    
    func formattedDescription() -> String {
        return "\(title) (\(platform)) - Trophies Earned: \(totalTrophiesEarned)"
    }
}

/// Represents an event such as a gaming convention or tournament
struct Event: Displayable {
    
    var title: String
    var subtitle: String
    var location: String
    
    func formattedDescription() -> String {
        return "\(title) - \(subtitle) at \(location)"
    }
}

/// Prints formatted information for any Displayable item
func printInfo(for item: Displayable) {
    print(item.formattedDescription())
}

print("\nProtocol Demonstration:")

let gameExample = Game.sampleData[0]

let eventExample = Event(
    title: "PlayStation Showcase",
    subtitle: "Gaming Announcement Event",
    location: "Los Angeles"
)

printInfo(for: gameExample)
printInfo(for: eventExample)

// MARK: - Exercise 3: Generics
// Z-ID: Z1948468
/// Returns the first element in an array that matches a condition
func findFirst<T: Equatable>(in array: [T], where predicate: (T) -> Bool) -> T? {
    
    for element in array {
        if predicate(element) {
            return element
        }
    }
    
    return nil
}

print("\nGeneric Function Demonstration:")

let numbers = [3, 7, 12, 18, 25]

if let firstLargeNumber = findFirst(in: numbers, where: { $0 > 10 }) {
    print("First number greater than 10:", firstLargeNumber)
}

let names = ["Alex", "Jordan", "Sam", "Taylor"]

if let firstNameWithJ = findFirst(in: names, where: { $0.hasPrefix("J") }) {
    print("First name starting with J:", firstNameWithJ)
}

/// A generic stack data structure
struct Stack<Element> {
    
    private var items: [Element] = []
    
    /// Adds an item to the top of the stack
    mutating func push(_ item: Element) {
        items.append(item)
    }
    
    /// Removes and returns the top item
    mutating func pop() -> Element? {
        return items.popLast()
    }
    
    /// Returns the top item without removing it
    func peek() -> Element? {
        return items.last
    }
}

print("\nStack Demonstration:")

var numberStack = Stack<Int>()

numberStack.push(10)
numberStack.push(20)
numberStack.push(30)

print("Top item:", numberStack.peek() ?? "None")

print("Popped:", numberStack.pop() ?? "None")

print("New top:", numberStack.peek() ?? "None")

// MARK: - Exercise 4: Type Casting
// Z-ID: Z1948468
/// Base class representing a media item
class MediaItem {
    
    /// Name of the media item
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

/// Represents a movie
class Movie: MediaItem {
    
    /// Director of the movie
    var director: String
    
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

/// Represents a song
class Song: MediaItem {
    
    /// Artist of the song
    var artist: String
    
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

let mediaLibrary: [MediaItem] = [
    Movie(name: "The Dark Knight", director: "Christopher Nolan"),
    Song(name: "Blinding Lights", artist: "The Weeknd"),
    Movie(name: "Inception", director: "Christopher Nolan"),
    Song(name: "Shape of You", artist: "Ed Sheeran")
]

var movieCount = 0
var songCount = 0

for item in mediaLibrary {
    
    if item is Movie {
        movieCount += 1
    }
    
    if item is Song {
        songCount += 1
    }
}

print("\nMedia Library Count:")
print("Movies:", movieCount)
print("Songs:", songCount)

print("\nMedia Details:")

for item in mediaLibrary {
    
    if let movie = item as? Movie {
        print("Movie:", movie.name, "- Directed by", movie.director)
    }
    
    else if let song = item as? Song {
        print("Song:", song.name, "- Artist:", song.artist)
    }
}
