
import Foundation

extension WebService
{
    
    func urlRemainder() -> String{
        let baseURL = "https://api.themoviedb.org/3/discover/movie?"
        let apiKey = "59d1ea6d131e11d3a7f4921da8243138"
        
        return  "\(baseURL)api_key=\(apiKey)"
    }
    
}
