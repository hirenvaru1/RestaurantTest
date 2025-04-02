import UIKit
import ProgressHUD

struct APIType {
    static let post = "POST"
    static let get = "GET"
}

func dataToJSON(_ data: Data) -> Any? {
    do {
        return try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    } catch let error {
        print(error)
    }
    return nil
}

func callAPI<elementT:Codable>(model dataModel:elementT.Type ,url apiUrl: String, method methodType:String, parameter parameters: NSDictionary, isHudShow isHudCall: Bool, completionHandler: @escaping (_ data: elementT) -> Void) {
    callMultiPartFormAPI(url: apiUrl, method: methodType, parameters: parameters, isHudShow: isHudCall) { (responseData) in
        if let data = responseData {
            do {
                let loginResponse = try JSONDecoder().decode(dataModel.self, from: data)
                completionHandler(loginResponse)
            } catch let error {
                print(error)
            }
        }
        
    }
}


func callMultiPartFormAPI(url apiUrl: String, method methodType:String,parameters params: NSDictionary, isHudShow isHudCall: Bool, withBlocks block: @escaping (Data?) -> Void) {
     
        if isHudCall {
            progressBar.SSProgressShowHUD()
        }
        let strUrl = apiUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        print(strUrl)
        let url = URL(string:strUrl)!
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = methodType
       
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    
        upload(multipartFormData: { multipartFormData in
            for (key, value) in params {
                multipartFormData.append((value as! String).data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key as! String)
            }
        }, with: urlRequest, encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (Progress) in
                    print("Upload Progress: \(Progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    if let data = response.data {
                        if data.count != 0 {
                            if response.value == nil {
                                block(nil)
                            }
                            else{
                                block(data)
                            }
                        }
                        else{
                            block(nil)
                        }
                        progressBar.SSProgressHideHUD()
                    }
                }
            case .failure(let error):
                print(error)
                progressBar.SSProgressHideHUD()
                block(nil)
            }
        })
}
  

class progressBar: UIViewController{
    class func SSProgressShowHUD(){
        ProgressHUD.colorAnimation = .systemRed
        ProgressHUD.animate("Loading...", .semiRingRotation)
    }
    
    class func SSProgressHideHUD(){
        ProgressHUD.dismiss()
    }
}
