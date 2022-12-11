
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
}
