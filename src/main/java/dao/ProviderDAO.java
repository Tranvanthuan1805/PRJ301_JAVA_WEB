package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Provider;

public class ProviderDAO {
    // Basic CRUD for Providers
    public List<Provider> getAll() {
        List<Provider> list = new ArrayList<>();
        // Mock data for now if table doesn't exist
        // list.add(new Provider(1, "Vietnam Airlines", "contact@vnair.com", "Transport", true));
        // Real DB call:
        // String sql = "SELECT * FROM Providers";
        // ... implementation ...
        return list;
    }
    
    // Stub for creating provider
    public boolean create(Provider p) {
        return true; 
    }
}
