import UIKit


final class  MainPageViewModel
{
    var isSearching = false
    let service = WebService()
    var result = [Result]()
    var resultAfterSearch = [Result]()
    
    func getMoviesData(completion: @escaping (Bool) -> Void)
    {
        service.getCharacters(completion: {  data in
              DispatchQueue.main.async {  [self] in
                  self.result = data!
                  completion(true)
              }
            completion(false)
          })
    }
    
    
    
    
    func darkMode()
    {
        
       
    }
    
    func updateSearchResult(text : String)
    {
        if !text.isEmpty
        {
            isSearching = true
            resultAfterSearch.removeAll(keepingCapacity: false)
            for movie in  result
            {
                if movie.title!.lowercased().contains(text.lowercased())
                {
                    resultAfterSearch.append(movie)
                }
            }
            
        }else
        {
            isSearching = false
            resultAfterSearch.removeAll(keepingCapacity: false)
            resultAfterSearch =  result
        }
    }
    
    func arrayCount() -> Int
    {
        if isSearching == false
        {
            return  result.count
        }
        else
        {
            return resultAfterSearch.count
        }
    }
    
    func selectedNameChooser(indexForName : Int) -> String
    {
        if isSearching == false
        {
            return result[indexForName].title!
        }
        else
        {
            return resultAfterSearch[indexForName].title!
        }
    }
    
    func voteLH()
    {
        var n = result.count
           while (n > 0) {
               var lastModifiedIndex = 0
               for currentIndex in 1..<n {
                   if  result[currentIndex - 1].vote_average! >  result[currentIndex].vote_average! {
                       let temp = result[currentIndex - 1]
                       result[currentIndex - 1] = result[currentIndex]
                       result[currentIndex] = temp
                       lastModifiedIndex = currentIndex
                   }
               }
               n = lastModifiedIndex
           }
    }
    func voteHL()
    {
        var n = result.count
           while (n > 0) {
               var lastModifiedIndex = 0
               for currentIndex in 1..<n {
                   if  result[currentIndex - 1].vote_average! <  result[currentIndex].vote_average! {
                       let temp = result[currentIndex - 1]
                       result[currentIndex - 1] = result[currentIndex]
                      result[currentIndex] = temp
                       lastModifiedIndex = currentIndex
                   }
               }
               n = lastModifiedIndex
           }
    }
    
    
    func popularityHL()
    {
        var n =  result.count
           while (n > 0) {
               var lastModifiedIndex = 0
               for currentIndex in 1..<n {
                   if  result[currentIndex - 1].popularity! < result[currentIndex].popularity! {
                       let temp = result[currentIndex - 1]
                      result[currentIndex - 1] = result[currentIndex]
                       result[currentIndex] = temp
                       lastModifiedIndex = currentIndex
                   }
               }
               n = lastModifiedIndex
           }
    }
    
    func popularityLH()
    {
        var n =  result.count
           while (n > 0) {
               var lastModifiedIndex = 0
               for currentIndex in 1..<n {
                   if  result[currentIndex - 1].popularity! > result[currentIndex].popularity! {
                       let temp =  result[currentIndex - 1]
                      result[currentIndex - 1] = result[currentIndex]
                       result[currentIndex] = temp
                       lastModifiedIndex = currentIndex
                   }
               }

               n = lastModifiedIndex
           }
    }
    
    func searchBarCancelButtonClicked()
    {
        isSearching = false
        resultAfterSearch.removeAll(keepingCapacity: false)
    }
}







