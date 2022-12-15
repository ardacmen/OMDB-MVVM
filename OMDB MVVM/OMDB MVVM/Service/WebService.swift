
import Foundation
import Alamofire

struct WebService
{
    func getCharacters( completion: @escaping ([Result]?) -> Void) {
        
        AF.request(urlRemainder()).responseDecodable(of: Model.self) { data in
            guard let data = data.value else {
                completion(nil)
                return
            }
            completion(data.results)
        }
    }
    
    func urlRemainder() -> String{
        let baseURL = "https://api.themoviedb.org/3/discover/movie?"
        let apiKey = "4c9ecc63a00e441445caed7eb26bed17"
        
        return  "\(baseURL)api_key=\(apiKey)"
    }
}
