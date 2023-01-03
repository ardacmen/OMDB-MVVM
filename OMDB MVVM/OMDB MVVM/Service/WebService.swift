// web service
import Foundation
import Alamofire

struct WebService
{
    func getCharacters( completion: @escaping ([Result]?) -> Void) {
        
        AF.request(urlRemainder()).responseDecodable(of: Array<Result>.self) { data in
            guard let data = data.value else {
                completion(nil)
                return
            }
            completion(data)
        }
    }
    
    func urlRemainder() -> String{
        let baseURL = "http://apps.hypersuperprojects.com/"
        let apiKey = "movieEndPoint1903190319031903.php"
        return  "\(baseURL)\(apiKey)"
        
    }
}

