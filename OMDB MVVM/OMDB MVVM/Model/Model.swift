import Foundation

struct Model: Codable {
    
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    
    let title : String?
    let overview :  String?
    let poster_path : String?
    let originalLanguage:  String?
    let vote_average:  String?
    let popularity :  String?
   
}
/*
 
 import Foundation

 struct Result: Codable{
     var result : [ResultElement]?
 }

 struct ResultElement: Codable {
     let title : String?
     let overview :  String?
     let posterPath : String?
     let originalLanguage:  String?
     let voteAverage:  String?
     let popularity :  String?
   
 }

 */
