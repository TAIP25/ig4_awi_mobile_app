//
//  SignupState.swift
//  test
//
//  Created by etud on 18/03/2024.
//

enum ProfileState: Equatable{
    static func == (lhs: ProfileState, rhs: ProfileState) -> Bool {
        switch lhs{
        case .idle:
            if case .idle = rhs{
                return true
            }else{
                return false
            }
            
        case .loading:
            if case .loading = rhs{
                return true
            }else{
                return false
            }
            
        case .success:
            if case .success = rhs{
                return true
            }else{
                return false
            }
            
        case .failure:
            if case .failure(_) = rhs{
                return true
            }else{
                return false
            }
        }
        
    }
    
    case idle
    case loading
    case success
    case failure(String)
    
    
    
}
