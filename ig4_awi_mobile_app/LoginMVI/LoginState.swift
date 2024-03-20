
enum LoginState: Equatable{
    
    static func == (lhs: LoginState, rhs: LoginState) -> Bool {
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
    case failure(Error)
    

}
