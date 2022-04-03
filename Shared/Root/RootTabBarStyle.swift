import SwiftUI
import TabBar

var height = 42.0

struct RootTabBarStyle: TabBarStyle {
    
    public func tabBar(with geometry: GeometryProxy, itemsContainer: @escaping () -> AnyView) -> some View {
        itemsContainer()
            .background(Color("colors/primary"))
            .cornerRadius(height / 2)
            .frame(height: height)
            .frame(maxWidth: .infinity) // Center the view
            .padding(.bottom, geometry.safeAreaInsets.bottom + 6)
            .shadow(radius: 10)
        
    }
    
    public func fillSpaceBetwenItems () -> Bool {
        return false
    }
    
    
    public func stackSpacing () -> CGFloat? {
        return 0
    }
    
}
