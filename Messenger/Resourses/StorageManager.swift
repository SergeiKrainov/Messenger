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
    /// Upload image that will be send in a converastion message
    public func uploadMessagePhoto(with data: Data, fileName: String, complition: @escaping UploadPictureComplition) {
        
        storage.child("message_images/\(fileName)").putData(data, metadata: nil, completion: { [weak self] metadata, error in
            guard error == nil else {
                //failed
                print("failed to upload data to firebase for picture")
                complition(.failure(StorageErrors.failedToUpload))
                return
            }
            
            self?.storage.child("message_images/\(fileName)").downloadURL(completion: { url, error in
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
    
    /// Upload video that will be send in a converastion message
    public func uploadMessageVideo(with fileUrl: URL, fileName: String, complition: @escaping UploadPictureComplition) {
        
        storage.child("message_videos/\(fileName)").putFile(from: fileUrl, metadata: nil, completion: { [weak self] metadata, error in
            guard error == nil else {
                //failed
                print("failed to upload video file to firebase for picture")
                complition(.failure(StorageErrors.failedToUpload))
                return
            }
            
            self?.storage.child("message_videos/\(fileName)").downloadURL(completion: { url, error in
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
    
    public func downloadUrl(for path: String, completion: @escaping (Result<URL, Error>) -> Void) {
        let reference = storage.child(path)
        
        reference.downloadURL(completion: {url, error in
            guard let url = url, error == nil else {
                completion(.failure((StorageErrors.failedToGetDowloadUrl)))
                return
            }
            completion(.success(url))
        })
    }
}
