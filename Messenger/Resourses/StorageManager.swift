//
//  StorageManager.swift
//  Messenger
//
//  Created by Sergey on 20.06.2022.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    
    static let shared = StorageManager()
    
    private var storage = Storage.storage().reference()
    
    public typealias UploadPictureComplition = (Result<String, Error>) -> Void
    
    /// Upload picture to firebase storage and returns complition with url string to dowload
    public func uploadProfilePicture(with data: Data, fileName: String, complition: @escaping UploadPictureComplition) {
        
        storage.child("images/\(fileName)").putData(data, metadata: nil, completion: {metadata, error in
            guard error == nil else {
                //failed
                print("failed to upload data to firebase for picture")
                complition(.failure(StorageErrors.failedToUpload))
                return
            }
            
            self.storage.child("images/\(fileName)").downloadURL(completion: {url, error in
                guard let url = url else {
                    print("failed to get dowload url")
                    complition(.failure(StorageErrors.failedToGetDowloadUrl))
                    return
                }
                
                let urlString = url.absoluteString
                print("dowload url returned: \(urlString)")
                complition(.success(urlString))
            })
        })
        
    }
    
    public enum StorageErrors: Error {
        case failedToUpload
        case failedToGetDowloadUrl
    }
}
