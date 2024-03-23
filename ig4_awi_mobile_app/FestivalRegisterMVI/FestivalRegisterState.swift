//
//  FestivalRegisterState.swift
//  test
//
//  Created by etud on 21/03/2024.
//

enum FestivalRegisterState: Equatable {
    
    static func == (lhs: FestivalRegisterState, rhs: FestivalRegisterState) -> Bool {
        switch lhs{
        case .initial:
            if case .initial = rhs{
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
            
        case .error:
            if case .error =
                rhs{
                return true
            }else{
                return false
            }
            
        case .success:
            if case .success =
                rhs{
                return true
            }else{
                return false
            }
        }
    }
    
    case initial
    case loading
    case error(String)
    case success
}
