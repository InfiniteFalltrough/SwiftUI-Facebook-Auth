//
//  ContentView.swift
//  FacebookAuth
//
//  Created by Viktor Golubenkov on 16.03.2021.
//

import SwiftUI
import FBSDKLoginKit

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    
    //User Defaults
    @AppStorage("logged") var logged: Bool = false
//    @AppStorage("email") var email: String = ""
    @AppStorage("id") var id: String = ""
    @AppStorage("name") var name: String = ""
    
    @State var manager = LoginManager()
    
    var body: some View {
        
        VStack(spacing: 50) {
            
            //Button
            Button(action: {
                
                if logged {
                    manager.logOut()
                    logged = false
                    name = ""
                    id = ""
//                    email = ""
                } else {
                    manager.logIn(permissions: ["id", "name"], from: nil) { (result, error) in
                        
                        if error != nil {
                            print(error?.localizedDescription ?? "Error: LOL!")
                            return
                        }
                        
                        if ((result?.isCancelled) != nil) {
                        logged = true
                        
                        let request = GraphRequest(graphPath: "me", parameters: ["fields": "id, name"], httpMethod: HTTPMethod(rawValue: "GET"))
                        
                        request.start { (_, res, _) in
                            defer { print("REQ FIN ")}
                            print("REQ START")
                            guard let userData = res as? [String: Any] else { return }
                            print("REQ END")
                            name = userData["name"] as! String
                            id = userData["id"] as! String
                            print(name + " " + id)
                            }
                        }
                    }
                }
                
            }, label: {
                Text(logged ? "Logout" : "Login")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 35)
                    .background(Color.blue)
                    .clipShape(Capsule())
            })
            Text(name + " " + id)
                .fontWeight(.bold)
            
            
        }
        
    }
    
}
