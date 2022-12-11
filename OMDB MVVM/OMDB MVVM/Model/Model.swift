import Foundation

struct Model: Codable {
    
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    
    let title: String
    let overview: String
    let poster_path: String
    let original_language: String
    let vote_average: Double
}
