import Foundation
import Alamofire

extension ItemListController {
    func getSortedData(completion:@escaping([Item]) -> (Void)){
        requestList { [weak self] (err, items) in
            if err != nil{
                print("ERROR HERE", err)
                completion([])
            }
            else{
                if let sortedItems = self?.sortItems(items: items){
                    completion(sortedItems)
                }
                else{
                    completion([])
                }
            }
        }
    }
    
    func sortItems(items: [Item]) -> [Item]{
        let filteredItems = deleteEmptyValues(items: items)
        let sortedItems = filteredItems.sorted(by: { (a, b) -> Bool in
            if let a_name = a.name, let b_name = b.name{
                let a_listId = a.listId
                let b_listId = b.listId
                if a_listId != b_listId{
                    return a_listId < b_listId
                }
                return a_name < b_name
            }
            return true
        })
        return sortedItems
    }
    
    func deleteEmptyValues(items: [Item]) -> [Item]{
        return items.filter({ (item) -> Bool in
            if let name = item.name{
                return !name.isEmpty
            }
            return false
        })
    }
    
    func requestList(completion:@escaping(String?, [Item]) -> (Void)){
        let headers = [
            "Content-Type" : "application/json",
            "secret-key": SECRET_KEY
        ]
        
        Alamofire.request(SERVER_ADDRESS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            switch response.result {
            case .success:
                if let itemData = response.data {
                    do {
                        let itemList = try JSONDecoder().decode([Item].self, from: itemData)
                        completion(nil, itemList)
                    }
                    catch let error{
                        completion(error.localizedDescription, [])
                    }
                }
                break
                
            case .failure(let err):
                let error_string = "There was an error fetching your data :(" + err.localizedDescription
                completion(error_string, [])
                break
            }
        }
    }
}
