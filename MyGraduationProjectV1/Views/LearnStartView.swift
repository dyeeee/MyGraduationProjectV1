//
//  LearnStartView.swift
//  MyGraduationProjectV1
//
//  Created by YES on 2021/1/19.
//

import SwiftUI

struct LearnStartView: View {
    @State var startLearning = false
    
    var body: some View {
        NavigationView
        {
            VStack {
                
                
                Text("Hello, World!")
            }
        }
    }
}

struct LearnStartView_Previews: PreviewProvider {
    static var previews: some View {
        LearnStartView()
    }
}
