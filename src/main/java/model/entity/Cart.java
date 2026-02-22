package model.entity;

import java.util.ArrayList;
import java.util.List;

public class Cart {
    private List<CartItem> items;

    public Cart() {
        this.items = new ArrayList<>();
    }

    public void addItem(CartItem item) {
        // Check if same tour on same date exists
        for (CartItem existing : items) {
            if (existing.getTour().getTourId() == item.getTour().getTourId() && 
                existing.getTravelDate().equals(item.getTravelDate())) {
                existing.setQuantity(existing.getQuantity() + item.getQuantity());
                return;
            }
        }
        items.add(item);
    }

    public void removeItem(int tourId, String travelDateStr) {
        items.removeIf(item -> 
            item.getTour().getTourId() == tourId && 
            item.getTravelDate().toString().startsWith(travelDateStr)
        );
    }

    public List<CartItem> getItems() {
        return items;
    }

    public double getTotalValue() {
        return items.stream().mapToDouble(CartItem::getTotalPrice).sum();
    }

    public int getItemCount() {
        return items.size();
    }
    
    public void clear() {
        items.clear();
    }
}
