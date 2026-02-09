package dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import model.HotelComparison;
import model.PriceHistory;
import model.Supplier;
import model.TourComparison;
import util.DatabaseConnection;

/**
 * DAO class for Suppliers - Updated for TourManager Database
 */
public class SupplierDAO {

    // Updated SQL queries for TourManager database with JOINs
    private static final String INSERT_SQL = 
        "INSERT INTO Suppliers (SupplierCode, SupplierName, ServiceTypeID, Email, PhoneNumber, StatusID, BasePrice, " +
        "ContactPerson, Address, Description, City, Province, Country, Notes) " +
        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    
    private static final String SELECT_BY_ID = 
        "SELECT s.*, st.ServiceTypeName as ServiceType, cs.StatusName as Status " +
        "FROM Suppliers s " +
        "LEFT JOIN ServiceTypes st ON s.ServiceTypeID = st.ServiceTypeID " +
        "LEFT JOIN CooperationStatus cs ON s.StatusID = cs.StatusID " +
        "WHERE s.SupplierID = ?";
        
    private static final String SELECT_ALL = 
        "SELECT s.*, st.ServiceTypeName as ServiceType, cs.StatusName as Status " +
        "FROM Suppliers s " +
        "LEFT JOIN ServiceTypes st ON s.ServiceTypeID = st.ServiceTypeID " +
        "LEFT JOIN CooperationStatus cs ON s.StatusID = cs.StatusID " +
        "ORDER BY st.ServiceTypeName, s.SupplierName";
        
    private static final String DELETE_SQL = "DELETE FROM Suppliers WHERE SupplierID = ?";
    
    private static final String UPDATE_SQL = 
        "UPDATE Suppliers SET SupplierCode = ?, SupplierName = ?, ServiceTypeID = ?, Email = ?, PhoneNumber = ?, " +
        "StatusID = ?, BasePrice = ?, ContactPerson = ?, Address = ?, Description = ?, City = ?, Province = ?, " +
        "Country = ?, Notes = ?, UpdatedDate = GETDATE() WHERE SupplierID = ?";
    
    private static final String SELECT_BY_TYPE = 
        "SELECT s.*, st.ServiceTypeName as ServiceType, cs.StatusName as Status " +
        "FROM Suppliers s " +
        "LEFT JOIN ServiceTypes st ON s.ServiceTypeID = st.ServiceTypeID " +
        "LEFT JOIN CooperationStatus cs ON s.StatusID = cs.StatusID " +
        "WHERE st.ServiceTypeName = ? ORDER BY s.BasePrice ASC";
        
    private static final String SELECT_ACTIVE = 
        "SELECT s.*, st.ServiceTypeName as ServiceType, cs.StatusName as Status " +
        "FROM Suppliers s " +
        "LEFT JOIN ServiceTypes st ON s.ServiceTypeID = st.ServiceTypeID " +
        "LEFT JOIN CooperationStatus cs ON s.StatusID = cs.StatusID " +
        "WHERE cs.StatusName = N'Đang hợp tác' ORDER BY st.ServiceTypeName, s.BasePrice";
        
    private static final String SEARCH_SQL = 
        "SELECT s.*, st.ServiceTypeName as ServiceType, cs.StatusName as Status " +
        "FROM Suppliers s " +
        "LEFT JOIN ServiceTypes st ON s.ServiceTypeID = st.ServiceTypeID " +
        "LEFT JOIN CooperationStatus cs ON s.StatusID = cs.StatusID " +
        "WHERE (s.SupplierName LIKE ? OR s.SupplierCode LIKE ? OR s.ContactPerson LIKE ? OR s.Email LIKE ?) " +
        "ORDER BY st.ServiceTypeName, s.SupplierName";

    public SupplierDAO() {
    }

    // Helper method to get ServiceTypeID by name
    private int getServiceTypeID(String serviceTypeName) {
        if (serviceTypeName == null) return 1; // Default to first service type
        
        String sql = "SELECT ServiceTypeID FROM ServiceTypes WHERE ServiceTypeName = ?";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            
            ps.setString(1, serviceTypeName);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt("ServiceTypeID");
            }
        } catch (SQLException e) {
            System.err.println("Error getting ServiceTypeID: " + e.getMessage());
        }
        return 1; // Default to first service type
    }
    
    // Helper method to get StatusID by name
    private int getStatusID(String statusName) {
        if (statusName == null) return 1; // Default to first status
        
        String sql = "SELECT StatusID FROM CooperationStatus WHERE StatusName = ?";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            
            ps.setString(1, statusName);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt("StatusID");
            }
        } catch (SQLException e) {
            System.err.println("Error getting StatusID: " + e.getMessage());
        }
        return 1; // Default to first status
    }

    // Create - Updated to handle foreign key relationships
    public void insertSupplier(Supplier supplier) throws SQLException {
        System.out.println("DEBUG: Inserting supplier: " + supplier.getSupplierName());
        
        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(INSERT_SQL)) {
            
            preparedStatement.setString(1, supplier.getSupplierCode());
            preparedStatement.setString(2, supplier.getSupplierName());
            preparedStatement.setInt(3, getServiceTypeID(supplier.getServiceType())); // Convert to ID
            preparedStatement.setString(4, supplier.getEmail());
            preparedStatement.setString(5, supplier.getPhoneNumber());
            preparedStatement.setInt(6, getStatusID(supplier.getStatus())); // Convert to ID
            preparedStatement.setBigDecimal(7, supplier.getBasePrice());
            preparedStatement.setString(8, supplier.getContactPerson());
            preparedStatement.setString(9, supplier.getAddress());
            preparedStatement.setString(10, supplier.getDescription());
            preparedStatement.setString(11, supplier.getCity());
            preparedStatement.setString(12, supplier.getProvince());
            preparedStatement.setString(13, supplier.getCountry());
            preparedStatement.setString(14, supplier.getNotes());
            
            int result = preparedStatement.executeUpdate();
            System.out.println("DEBUG: Insert result: " + result + " rows affected");
            
        } catch (SQLException e) {
            System.err.println("ERROR in insertSupplier: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

    // Read by ID
    public Supplier selectSupplier(int id) {
        Supplier supplier = null;
        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(SELECT_BY_ID)) {
            
            preparedStatement.setInt(1, id);
            ResultSet rs = preparedStatement.executeQuery();

            if (rs.next()) {
                supplier = mapResultSetToSupplier(rs);
                System.out.println("DEBUG: Found supplier with ID " + id + ": " + supplier.getSupplierName());
            } else {
                System.out.println("DEBUG: No supplier found with ID " + id);
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR in selectSupplier: " + e.getMessage());
            e.printStackTrace();
        }
        return supplier;
    }

    // Read All - Enhanced with better error handling
    public List<Supplier> selectAllSuppliers() {
        List<Supplier> suppliers = new ArrayList<>();
        
        try (Connection connection = DatabaseConnection.getConnection()) {
            if (connection == null) {
                System.err.println("ERROR: Database connection is null");
                return suppliers;
            }
            
            try (PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL)) {
                System.out.println("DEBUG: Executing query: " + SELECT_ALL);
                
                ResultSet rs = preparedStatement.executeQuery();
                
                while (rs.next()) {
                    Supplier supplier = mapResultSetToSupplier(rs);
                    suppliers.add(supplier);
                }
                
                System.out.println("DEBUG: Successfully loaded " + suppliers.size() + " suppliers from database");
                
                // Log first few suppliers for debugging
                for (int i = 0; i < Math.min(3, suppliers.size()); i++) {
                    Supplier s = suppliers.get(i);
                    System.out.println("DEBUG: Supplier " + (i+1) + ": " + s.getSupplierName() + 
                                     " (" + s.getServiceType() + ") - " + s.getBasePrice() + " VND");
                }
                
            }
        } catch (SQLException e) {
            System.err.println("ERROR in selectAllSuppliers: " + e.getMessage());
            e.printStackTrace();
        }
        
        return suppliers;
    }

    // Update - Enhanced to handle foreign key relationships
    public boolean updateSupplier(Supplier supplier) throws SQLException {
        boolean rowUpdated = false;
        
        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_SQL)) {
            
            preparedStatement.setString(1, supplier.getSupplierCode());
            preparedStatement.setString(2, supplier.getSupplierName());
            preparedStatement.setInt(3, getServiceTypeID(supplier.getServiceType())); // Convert to ID
            preparedStatement.setString(4, supplier.getEmail());
            preparedStatement.setString(5, supplier.getPhoneNumber());
            preparedStatement.setInt(6, getStatusID(supplier.getStatus())); // Convert to ID
            preparedStatement.setBigDecimal(7, supplier.getBasePrice());
            preparedStatement.setString(8, supplier.getContactPerson());
            preparedStatement.setString(9, supplier.getAddress());
            preparedStatement.setString(10, supplier.getDescription());
            preparedStatement.setString(11, supplier.getCity());
            preparedStatement.setString(12, supplier.getProvince());
            preparedStatement.setString(13, supplier.getCountry());
            preparedStatement.setString(14, supplier.getNotes());
            preparedStatement.setInt(15, supplier.getSupplierID());

            int result = preparedStatement.executeUpdate();
            rowUpdated = result > 0;
            
            System.out.println("DEBUG: Update result: " + result + " rows affected");
            
        } catch (SQLException e) {
            System.err.println("ERROR in updateSupplier: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
        
        return rowUpdated;
    }

    // Delete
    public boolean deleteSupplier(int id) throws SQLException {
        boolean rowDeleted = false;
        
        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(DELETE_SQL)) {
            
            preparedStatement.setInt(1, id);
            int result = preparedStatement.executeUpdate();
            rowDeleted = result > 0;
            
            System.out.println("DEBUG: Delete result: " + result + " rows affected");
            
        } catch (SQLException e) {
            System.err.println("ERROR in deleteSupplier: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
        
        return rowDeleted;
    }

    // Get Suppliers by Service Type
    public List<Supplier> getSuppliersByServiceType(String serviceType) {
        List<Supplier> suppliers = new ArrayList<>();
        
        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(SELECT_BY_TYPE)) {
            
            preparedStatement.setString(1, serviceType);
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                suppliers.add(mapResultSetToSupplier(rs));
            }
            
            System.out.println("DEBUG: Found " + suppliers.size() + " suppliers for service type: " + serviceType);
            
        } catch (SQLException e) {
            System.err.println("ERROR in getSuppliersByServiceType: " + e.getMessage());
            e.printStackTrace();
        }
        
        return suppliers;
    }

    // Get Active Suppliers Only
    public List<Supplier> getActiveSuppliers() {
        List<Supplier> suppliers = new ArrayList<>();
        
        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ACTIVE)) {
            
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                suppliers.add(mapResultSetToSupplier(rs));
            }
            
            System.out.println("DEBUG: Found " + suppliers.size() + " active suppliers");
            
        } catch (SQLException e) {
            System.err.println("ERROR in getActiveSuppliers: " + e.getMessage());
            e.printStackTrace();
        }
        
        return suppliers;
    }

    // Search Suppliers
    public List<Supplier> searchSuppliers(String keyword) {
        List<Supplier> suppliers = new ArrayList<>();
        
        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(SEARCH_SQL)) {
            
            String searchPattern = "%" + keyword + "%";
            preparedStatement.setString(1, searchPattern);
            preparedStatement.setString(2, searchPattern);
            preparedStatement.setString(3, searchPattern);
            preparedStatement.setString(4, searchPattern);
            
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                suppliers.add(mapResultSetToSupplier(rs));
            }
            
            System.out.println("DEBUG: Search for '" + keyword + "' found " + suppliers.size() + " suppliers");
            
        } catch (SQLException e) {
            System.err.println("ERROR in searchSuppliers: " + e.getMessage());
            e.printStackTrace();
        }
        
        return suppliers;
    }

    // Get all available service types for forms
    public List<String> getServiceTypes() {
        List<String> serviceTypes = new ArrayList<>();
        String sql = "SELECT ServiceTypeName FROM ServiceTypes WHERE IsActive = 1 ORDER BY DisplayOrder, ServiceTypeName";
        
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                serviceTypes.add(rs.getString("ServiceTypeName"));
            }
            
            System.out.println("DEBUG: Found " + serviceTypes.size() + " service types");
            
        } catch (SQLException e) {
            System.err.println("ERROR in getServiceTypes: " + e.getMessage());
            e.printStackTrace();
        }
        
        return serviceTypes;
    }
    
    // Get all available cooperation statuses for forms
    public List<String> getCooperationStatuses() {
        List<String> statuses = new ArrayList<>();
        String sql = "SELECT StatusName FROM CooperationStatus WHERE IsActive = 1 ORDER BY DisplayOrder, StatusName";
        
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                statuses.add(rs.getString("StatusName"));
            }
            
            System.out.println("DEBUG: Found " + statuses.size() + " cooperation statuses");
            
        } catch (SQLException e) {
            System.err.println("ERROR in getCooperationStatuses: " + e.getMessage());
            e.printStackTrace();
        }
        
        return statuses;
    }
    private Supplier mapResultSetToSupplier(ResultSet rs) throws SQLException {
        Supplier supplier = new Supplier();
        
        // Basic fields
        supplier.setSupplierID(rs.getInt("SupplierID"));
        supplier.setSupplierName(rs.getString("SupplierName"));
        supplier.setServiceType(rs.getString("ServiceType")); // From JOIN
        supplier.setEmail(rs.getString("Email"));
        supplier.setPhoneNumber(rs.getString("PhoneNumber"));
        supplier.setStatus(rs.getString("Status")); // From JOIN
        supplier.setBasePrice(rs.getBigDecimal("BasePrice"));
        
        // Additional fields - handle null values safely
        supplier.setSupplierCode(rs.getString("SupplierCode"));
        supplier.setContactPerson(rs.getString("ContactPerson"));
        supplier.setAddress(rs.getString("Address"));
        supplier.setDescription(rs.getString("Description"));
        supplier.setCity(rs.getString("City"));
        supplier.setProvince(rs.getString("Province"));
        supplier.setCountry(rs.getString("Country"));
        supplier.setNotes(rs.getString("Notes"));
        
        return supplier;
    }
    
    // =============================================
    // PRICE HISTORY METHODS
    // =============================================
    
    /**
     * Get price history for a supplier using stored procedure
     */
    public List<PriceHistory> getPriceHistory(int supplierID, LocalDate fromDate, LocalDate toDate) {
        List<PriceHistory> priceHistoryList = new ArrayList<>();
        
        if (fromDate == null) {
            fromDate = LocalDate.now().minusMonths(12);
        }
        if (toDate == null) {
            toDate = LocalDate.now();
        }
        
        String sql = "{CALL sp_GetPriceHistory(?, ?, ?)}";
        
        try (Connection connection = DatabaseConnection.getConnection();
             CallableStatement stmt = connection.prepareCall(sql)) {
            
            stmt.setInt(1, supplierID);
            stmt.setDate(2, Date.valueOf(fromDate));
            stmt.setDate(3, Date.valueOf(toDate));
            
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                PriceHistory ph = new PriceHistory();
                ph.setPriceHistoryID(rs.getInt("PriceHistoryID"));
                ph.setSupplierName(rs.getString("SupplierName"));
                ph.setServiceTypeName(rs.getString("ServiceTypeName"));
                ph.setOldPrice(rs.getBigDecimal("OldPrice"));
                ph.setNewPrice(rs.getBigDecimal("NewPrice"));
                ph.setPriceChange(rs.getBigDecimal("PriceChange"));
                ph.setChangePercent(rs.getBigDecimal("ChangePercent"));
                ph.setChangeType(rs.getString("ChangeType"));
                ph.setChangeReason(rs.getString("ChangeReason"));
                ph.setEffectiveDate(rs.getDate("EffectiveDate").toLocalDate());
                ph.setCreatedDate(rs.getDate("CreatedDate").toLocalDate());
                
                priceHistoryList.add(ph);
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR in getPriceHistory: " + e.getMessage());
            e.printStackTrace();
        }
        
        return priceHistoryList;
    }
    
    // =============================================
    // HOTEL COMPARISON METHODS
    // =============================================
    
    /**
     * Compare hotels by price range using stored procedure
     */
    public List<HotelComparison> compareHotelsByPriceRange(java.math.BigDecimal minPrice, 
                                                           java.math.BigDecimal maxPrice, 
                                                           String orderBy) {
        List<HotelComparison> hotels = new ArrayList<>();
        
        if (minPrice == null) minPrice = java.math.BigDecimal.ZERO;
        if (maxPrice == null) maxPrice = new java.math.BigDecimal("999999999");
        if (orderBy == null || orderBy.isEmpty()) orderBy = "Rating";
        
        String sql = "{CALL sp_CompareHotelsByPriceRange(?, ?, ?)}";
        
        try (Connection connection = DatabaseConnection.getConnection();
             CallableStatement stmt = connection.prepareCall(sql)) {
            
            stmt.setBigDecimal(1, minPrice);
            stmt.setBigDecimal(2, maxPrice);
            stmt.setString(3, orderBy);
            
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                HotelComparison hotel = mapResultSetToHotelComparison(rs);
                hotels.add(hotel);
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR in compareHotelsByPriceRange: " + e.getMessage());
            e.printStackTrace();
        }
        
        return hotels;
    }
    
    /**
     * Get hotel comparison data from view
     */
    public List<HotelComparison> getHotelComparison(String hotelCategory) {
        List<HotelComparison> hotels = new ArrayList<>();
        
        StringBuilder sql = new StringBuilder(
            "SELECT * FROM vw_DanangHotelPriceComparison WHERE 1=1"
        );
        
        if (hotelCategory != null && !hotelCategory.isEmpty()) {
            sql.append(" AND HotelCategory = ?");
        }
        
        sql.append(" ORDER BY Rating DESC, TotalReviews DESC");
        
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            
            if (hotelCategory != null && !hotelCategory.isEmpty()) {
                ps.setString(1, hotelCategory);
            }
            
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                HotelComparison hotel = mapResultSetToHotelComparison(rs);
                hotels.add(hotel);
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR in getHotelComparison: " + e.getMessage());
            e.printStackTrace();
        }
        
        return hotels;
    }
    
    /**
     * Get distinct hotel categories
     */
    public List<String> getHotelCategories() {
        List<String> categories = new ArrayList<>();
        String sql = "SELECT DISTINCT HotelCategory FROM vw_DanangHotelPriceComparison ORDER BY HotelCategory DESC";
        
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                categories.add(rs.getString("HotelCategory"));
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR in getHotelCategories: " + e.getMessage());
            e.printStackTrace();
        }
        
        return categories;
    }
    
    // =============================================
    // TOUR COMPARISON METHODS
    // =============================================
    
    /**
     * Compare tours by type using stored procedure
     */
    public List<TourComparison> compareToursByType(String tourType) {
        List<TourComparison> tours = new ArrayList<>();
        
        String sql = "{CALL sp_CompareToursByType(?)}";
        
        try (Connection connection = DatabaseConnection.getConnection();
             CallableStatement stmt = connection.prepareCall(sql)) {
            
            if (tourType != null && !tourType.isEmpty()) {
                stmt.setString(1, tourType);
            } else {
                stmt.setNull(1, java.sql.Types.NVARCHAR);
            }
            
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                TourComparison tour = mapResultSetToTourComparison(rs);
                tours.add(tour);
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR in compareToursByType: " + e.getMessage());
            e.printStackTrace();
        }
        
        return tours;
    }
    
    /**
     * Get tour comparison data from view
     */
    public List<TourComparison> getTourComparison(String tourType) {
        List<TourComparison> tours = new ArrayList<>();
        
        StringBuilder sql = new StringBuilder(
            "SELECT * FROM vw_DanangTourPriceComparison WHERE 1=1"
        );
        
        if (tourType != null && !tourType.isEmpty()) {
            sql.append(" AND TourType = ?");
        }
        
        sql.append(" ORDER BY Rating DESC, TotalReviews DESC");
        
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            
            if (tourType != null && !tourType.isEmpty()) {
                ps.setString(1, tourType);
            }
            
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                TourComparison tour = mapResultSetToTourComparison(rs);
                tours.add(tour);
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR in getTourComparison: " + e.getMessage());
            e.printStackTrace();
        }
        
        return tours;
    }
    
    /**
     * Get distinct tour types
     */
    public List<String> getTourTypes() {
        List<String> types = new ArrayList<>();
        String sql = "SELECT DISTINCT TourType FROM vw_DanangTourPriceComparison ORDER BY TourType DESC";
        
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                types.add(rs.getString("TourType"));
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR in getTourTypes: " + e.getMessage());
            e.printStackTrace();
        }
        
        return types;
    }
    
    // =============================================
    // HELPER METHODS FOR MAPPING
    // =============================================
    
    private HotelComparison mapResultSetToHotelComparison(ResultSet rs) throws SQLException {
        HotelComparison hotel = new HotelComparison();
        
        hotel.setSupplierID(rs.getInt("SupplierID"));
        hotel.setSupplierCode(rs.getString("SupplierCode"));
        hotel.setSupplierName(rs.getString("SupplierName"));
        hotel.setAddress(rs.getString("Address"));
        hotel.setCurrentPrice(rs.getBigDecimal("CurrentPrice"));
        hotel.setAvgPrice6Months(rs.getBigDecimal("AvgPrice6Months"));
        hotel.setLowestPrice(rs.getBigDecimal("LowestPrice"));
        hotel.setHighestPrice(rs.getBigDecimal("HighestPrice"));
        hotel.setRating(rs.getBigDecimal("Rating"));
        hotel.setTotalReviews(rs.getInt("TotalReviews"));
        hotel.setQualityScore(rs.getInt("QualityScore"));
        hotel.setHotelCategory(rs.getString("HotelCategory"));
        hotel.setPriceChangeCount(rs.getInt("PriceChangeCount"));
        
        // Optional fields from stored procedure
        try {
            hotel.setPriceVsAvgPercent(rs.getBigDecimal("PriceVsAvgPercent"));
            hotel.setValueRating(rs.getString("ValueRating"));
        } catch (SQLException e) {
            // These fields may not exist in view query
        }
        
        try {
            hotel.setTags(rs.getString("Tags"));
        } catch (SQLException e) {
            // Tags may not exist
        }
        
        return hotel;
    }
    
    private TourComparison mapResultSetToTourComparison(ResultSet rs) throws SQLException {
        TourComparison tour = new TourComparison();
        
        tour.setSupplierID(rs.getInt("SupplierID"));
        tour.setSupplierCode(rs.getString("SupplierCode"));
        tour.setSupplierName(rs.getString("SupplierName"));
        
        try {
            tour.setShortDescription(rs.getString("ShortDescription"));
        } catch (SQLException e) {
            // ShortDescription may not exist in view
            try {
                String desc = rs.getString("Description");
                if (desc != null && desc.length() > 100) {
                    tour.setShortDescription(desc.substring(0, 100) + "...");
                } else {
                    tour.setShortDescription(desc);
                }
            } catch (SQLException ex) {
                // No description available
            }
        }
        
        tour.setCurrentPrice(rs.getBigDecimal("CurrentPrice"));
        tour.setAvgPriceAllTime(rs.getBigDecimal("AvgPriceAllTime"));
        tour.setLowestPrice(rs.getBigDecimal("LowestPrice"));
        tour.setHighestPrice(rs.getBigDecimal("HighestPrice"));
        tour.setPriceChangePercent(rs.getBigDecimal("PriceChangePercent"));
        tour.setRating(rs.getBigDecimal("Rating"));
        tour.setTotalReviews(rs.getInt("TotalReviews"));
        tour.setTourType(rs.getString("TourType"));
        
        // Optional fields from stored procedure
        try {
            tour.setPriceTrend(rs.getString("PriceTrend"));
            tour.setRecommendation(rs.getString("Recommendation"));
        } catch (SQLException e) {
            // These fields may not exist in view query
        }
        
        try {
            tour.setTags(rs.getString("Tags"));
        } catch (SQLException e) {
            // Tags may not exist
        }
        
        return tour;
    }
}
