//
//  ProfilePictureView.swift
//  Respyr
//
//  Created by Kevin Parke on 12/20/21.
//

import SwiftUI

struct ProfilePictureView: View {
    var profilePicture: UIImage?
    var gradient1: [Color] = [
        Color.init(red: 101/255, green: 134/255, blue: 1),
        Color.init(red: 1, green: 64/255, blue: 80/255),
        Color.init(red: 109/255, green: 1, blue: 185/255),
        Color.init(red: 39/255, green: 232/255, blue: 1),
    ]

    @State private var angle: Double = 0

    var body: some View {
        ZStack {
            //Angular Gradient
            AngularGradient(gradient: Gradient(colors: gradient1), center: .center, angle: .degrees(angle))
                .mask(
                    Circle()
                        .frame(width: 90, height: 90, alignment: .center)
                        .blur(radius: 8.0)
                )
                .blur(radius: 8.0)
            
            //Frosted border
            VisualEffectBlur(blurStyle: .systemThinMaterial)
                .frame(width: 80, height: 80, alignment: .center)
                .mask(Circle()
                        .frame(width: 80, height: 80, alignment: .center)
                )
            
            //Profile Image
            if profilePicture != nil {
                Image(uiImage: profilePicture!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 70, height: 70, alignment: .center)
                    .mask(
                        Circle()
                )
            } else {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 70))
                    .foregroundColor(.white)
        }
        }
    
    
//    var profilePicture: UIImage?
//
//    var body: some View {
//        ZStack{
//            //Angular Gradient
//            AngularGradient(gradient: Gradient(colors: [Color("AngularGradient"), Color("AngularGradient1"), Color("AngularGradient2"), Color("AngularGradient3"), Color("AngularGradient4")]), center: .center, angle: .degrees(0))
//                .mask(
//                    Circle()
//                        .frame(width: 70, height: 70, alignment: .center)
//                        .blur(radius: 8.0)
//                )
//                .blur(radius: 8.0)
//
//            //Profile picture background
//            if profilePicture != nil {
//                Image(uiImage: profilePicture!)
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: 66, height: 66, alignment: .center)
//                    .mask(
//                        Circle()
//                )
//            } else {
//                Image(systemName: "person.circle.fill")
//                    .font(.system(size: 66))
//                    .foregroundColor(.white)
//            }
//        }
//    }
    }}

struct ProfilePictureView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePictureView()
    }
}
