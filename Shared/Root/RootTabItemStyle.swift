import SwiftUI
import TabBar

struct RootTabItemStyle: TabItemStyle {
    
    @ViewBuilder
    public func tabItem(icon: String, title: String, isSelected: Bool) -> some View {
        let color = isSelected
        ? Color("colors/tabbar/text_active")
        : Color("colors/inactive")
        
        
        VStack {
            if icon == NO_ICON {
                Text(title)
                    .font(.body)
                    .foregroundColor(color)
            } else {
                Image("icons/menu")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(color)
                    .frame(width: 22, height: 22, alignment: .center)
            }
            
            
        }
        .padding(.horizontal, 16)
        .frame(height: 42.0)
        
        
    }
    
}
