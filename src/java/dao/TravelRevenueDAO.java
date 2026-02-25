package dao;

import model.TravelRevenue;
import util.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * DAO class for TravelRevenue
 */
public class TravelRevenueDAO {

    /**
     * Get all travel revenue records
     */
    public List<TravelRevenue> getAllRevenue() {
        List<TravelRevenue> revenues = new ArrayList<>();
        String sql = "SELECT * FROM TravelRevenue ORDER BY ReportYear DESC, ReportMonth DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                revenues.add(mapResultSetToRevenue(rs));
            }
            
            System.out.println("DEBUG: Loaded " + revenues.size() + " revenue records");
            
        } catch (SQLException e) {
            System.err.println("ERROR in getAllRevenue: " + e.getMessage());
            e.printStackTrace();
        }
        
        return revenues;
    }

    /**
     * Get revenue by year and month
     */
    public List<TravelRevenue> getRevenueByYearMonth(int year, int month) {
        List<TravelRevenue> revenues = new ArrayList<>();
        String sql = "SELECT * FROM TravelRevenue WHERE ReportYear = ? AND ReportMonth = ? ORDER BY Category, SupplierName";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, year);
            ps.setInt(2, month);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                revenues.add(mapResultSetToRevenue(rs));
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR in getRevenueByYearMonth: " + e.getMessage());
            e.printStackTrace();
        }
        
        return revenues;
    }

    /**
     * Get revenue by category (Khách sạn or Hàng không)
     */
    public List<TravelRevenue> getRevenueByCategory(String category) {
        List<TravelRevenue> revenues = new ArrayList<>();
        String sql = "SELECT * FROM TravelRevenue WHERE Category LIKE ? ORDER BY ReportYear DESC, ReportMonth DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            // Tìm kiếm linh hoạt hơn để xử lý encoding issues
            String searchPattern;
            if (category.contains("Khách") || category.contains("khách") || category.contains("hotel")) {
                searchPattern = "%Kh%ch%s%n%"; // Tìm bất kỳ text có pattern "Kh*ch*s*n"
            } else if (category.contains("Hàng") || category.contains("hàng") || category.contains("airline")) {
                searchPattern = "%H%ng%kh%ng%"; // Tìm bất kỳ text có pattern "H*ng*kh*ng"
            } else {
                searchPattern = "%" + category + "%";
            }
            
            ps.setString(1, searchPattern);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                revenues.add(mapResultSetToRevenue(rs));
            }
            
            System.out.println("DEBUG: Found " + revenues.size() + " records for category pattern: " + searchPattern);
            
        } catch (SQLException e) {
            System.err.println("ERROR in getRevenueByCategory: " + e.getMessage());
            e.printStackTrace();
        }
        
        return revenues;
    }

    /**
     * Get latest month/year data
     */
    public Map<String, Integer> getLatestMonthYear() {
        Map<String, Integer> result = new HashMap<>();
        String sql = "SELECT TOP 1 ReportYear, ReportMonth FROM TravelRevenue ORDER BY ReportYear DESC, ReportMonth DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            if (rs.next()) {
                result.put("year", rs.getInt("ReportYear"));
                result.put("month", rs.getInt("ReportMonth"));
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR in getLatestMonthYear: " + e.getMessage());
            e.printStackTrace();
        }
        
        return result;
    }

    /**
     * Get total revenue by year
     */
    public Double getTotalRevenueByYear(int year) {
        String sql = "SELECT SUM(EstimatedRevenue_Billion) as TotalRevenue FROM TravelRevenue WHERE ReportYear = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, year);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getDouble("TotalRevenue");
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR in getTotalRevenueByYear: " + e.getMessage());
            e.printStackTrace();
        }
        
        return 0.0;
    }
    
    /**
     * Get total revenue for ALL years (2020-2025)
     */
    public Double getTotalRevenueAllYears() {
        String sql = "SELECT SUM(EstimatedRevenue_Billion) as TotalRevenue FROM TravelRevenue";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            if (rs.next()) {
                double total = rs.getDouble("TotalRevenue");
                System.out.println("DEBUG: Total revenue ALL YEARS = " + total);
                return total;
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR in getTotalRevenueAllYears: " + e.getMessage());
            e.printStackTrace();
        }
        
        return 0.0;
    }

    /**
     * Get total guests by year
     */
    public Integer getTotalGuestsByYear(int year) {
        String sql = "SELECT SUM(GuestCount) as TotalGuests FROM TravelRevenue WHERE ReportYear = ? AND Category = N'Khách sạn'";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, year);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                int total = rs.getInt("TotalGuests");
                System.out.println("DEBUG: Total guests for year " + year + " = " + total);
                return total;
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR in getTotalGuestsByYear: " + e.getMessage());
            e.printStackTrace();
        }
        
        return 0;
    }
    
    /**
     * Get total guests for ALL years (2020-2025)
     */
    public Integer getTotalGuestsAllYears() {
        String sql = "SELECT SUM(GuestCount) as TotalGuests FROM TravelRevenue WHERE Category = N'Khách sạn'";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            if (rs.next()) {
                int total = rs.getInt("TotalGuests");
                System.out.println("DEBUG: Total guests ALL YEARS = " + total);
                return total;
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR in getTotalGuestsAllYears: " + e.getMessage());
            e.printStackTrace();
        }
        
        return 0;
    }

    /**
     * Get top hotels by revenue
     */
    public List<TravelRevenue> getTopHotelsByRevenue(int year, int limit) {
        List<TravelRevenue> hotels = new ArrayList<>();
        String sql = "SELECT TOP " + limit + " SupplierName, SUM(EstimatedRevenue_Billion) as TotalRevenue, " +
                     "AVG(AvgHotelPrice_VND) as AvgPrice, SUM(GuestCount) as TotalGuests " +
                     "FROM TravelRevenue " +
                     "WHERE ReportYear = ? AND Category = N'Khách sạn' " +
                     "GROUP BY SupplierName " +
                     "ORDER BY TotalRevenue DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, year);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                TravelRevenue hotel = new TravelRevenue();
                hotel.setSupplierName(rs.getString("SupplierName"));
                hotel.setEstimatedRevenueBillion(rs.getDouble("TotalRevenue"));
                hotel.setAvgHotelPriceVND(rs.getBigDecimal("AvgPrice"));
                hotel.setGuestCount(rs.getInt("TotalGuests"));
                hotels.add(hotel);
            }
            
            System.out.println("DEBUG: Found " + hotels.size() + " top hotels for year " + year);
            
        } catch (SQLException e) {
            System.err.println("ERROR in getTopHotelsByRevenue: " + e.getMessage());
            e.printStackTrace();
        }
        
        return hotels;
    }
    
    /**
     * Get top hotels by revenue for ALL years (2020-2025)
     */
    public List<TravelRevenue> getTopHotelsByRevenueAllYears(int limit) {
        List<TravelRevenue> hotels = new ArrayList<>();
        String sql = "SELECT TOP " + limit + " SupplierName, SUM(EstimatedRevenue_Billion) as TotalRevenue, " +
                     "AVG(AvgHotelPrice_VND) as AvgPrice, SUM(GuestCount) as TotalGuests " +
                     "FROM TravelRevenue " +
                     "WHERE Category = N'Khách sạn' " +
                     "GROUP BY SupplierName " +
                     "ORDER BY TotalRevenue DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                TravelRevenue hotel = new TravelRevenue();
                hotel.setSupplierName(rs.getString("SupplierName"));
                hotel.setEstimatedRevenueBillion(rs.getDouble("TotalRevenue"));
                hotel.setAvgHotelPriceVND(rs.getBigDecimal("AvgPrice"));
                hotel.setGuestCount(rs.getInt("TotalGuests"));
                hotels.add(hotel);
            }
            
            System.out.println("DEBUG: Found " + hotels.size() + " top hotels ALL YEARS (2020-2025)");
            
        } catch (SQLException e) {
            System.err.println("ERROR in getTopHotelsByRevenueAllYears: " + e.getMessage());
            e.printStackTrace();
        }
        
        return hotels;
    }

    /**
     * Get top airlines by revenue
     */
    public List<TravelRevenue> getTopAirlinesByRevenue(int year, int limit) {
        List<TravelRevenue> airlines = new ArrayList<>();
        String sql = "SELECT TOP " + limit + " SupplierName, SUM(EstimatedRevenue_Billion) as TotalRevenue, " +
                     "AVG(AvgFlightTicket_VND) as AvgTicket, SUM(GuestCount) as TotalPassengers " +
                     "FROM TravelRevenue " +
                     "WHERE ReportYear = ? AND Category = N'Hàng không' " +
                     "GROUP BY SupplierName " +
                     "ORDER BY TotalRevenue DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, year);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                TravelRevenue airline = new TravelRevenue();
                airline.setSupplierName(rs.getString("SupplierName"));
                airline.setEstimatedRevenueBillion(rs.getDouble("TotalRevenue"));
                airline.setAvgFlightTicketVND(rs.getBigDecimal("AvgTicket"));
                airline.setGuestCount(rs.getInt("TotalPassengers"));
                airlines.add(airline);
            }
            
            System.out.println("DEBUG: Found " + airlines.size() + " top airlines for year " + year);
            
        } catch (SQLException e) {
            System.err.println("ERROR in getTopAirlinesByRevenue: " + e.getMessage());
            e.printStackTrace();
        }
        
        return airlines;
    }
    
    /**
     * Get top airlines by revenue for ALL years (2020-2025)
     */
    public List<TravelRevenue> getTopAirlinesByRevenueAllYears(int limit) {
        List<TravelRevenue> airlines = new ArrayList<>();
        String sql = "SELECT TOP " + limit + " SupplierName, SUM(EstimatedRevenue_Billion) as TotalRevenue, " +
                     "AVG(AvgFlightTicket_VND) as AvgTicket, SUM(GuestCount) as TotalPassengers " +
                     "FROM TravelRevenue " +
                     "WHERE Category = N'Hàng không' " +
                     "GROUP BY SupplierName " +
                     "ORDER BY TotalRevenue DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                TravelRevenue airline = new TravelRevenue();
                airline.setSupplierName(rs.getString("SupplierName"));
                airline.setEstimatedRevenueBillion(rs.getDouble("TotalRevenue"));
                airline.setAvgFlightTicketVND(rs.getBigDecimal("AvgTicket"));
                airline.setGuestCount(rs.getInt("TotalPassengers"));
                airlines.add(airline);
            }
            
            System.out.println("DEBUG: Found " + airlines.size() + " top airlines ALL YEARS (2020-2025)");
            
        } catch (SQLException e) {
            System.err.println("ERROR in getTopAirlinesByRevenueAllYears: " + e.getMessage());
            e.printStackTrace();
        }
        
        return airlines;
    }

    /**
     * Get monthly revenue trend for a year
     */
    public List<Map<String, Object>> getMonthlyRevenueTrend(int year) {
        List<Map<String, Object>> trend = new ArrayList<>();
        String sql = "SELECT ReportMonth, SUM(EstimatedRevenue_Billion) as TotalRevenue, SUM(GuestCount) as TotalGuests " +
                     "FROM TravelRevenue " +
                     "WHERE ReportYear = ? " +
                     "GROUP BY ReportMonth " +
                     "ORDER BY ReportMonth";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, year);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Map<String, Object> monthData = new HashMap<>();
                monthData.put("month", rs.getInt("ReportMonth"));
                monthData.put("revenue", rs.getDouble("TotalRevenue"));
                monthData.put("guests", rs.getInt("TotalGuests"));
                trend.add(monthData);
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR in getMonthlyRevenueTrend: " + e.getMessage());
            e.printStackTrace();
        }
        
        return trend;
    }

    /**
     * Get cheapest hotel price
     */
    public java.math.BigDecimal getCheapestHotelPrice(int year, int month) {
        String sql = "SELECT MIN(AvgHotelPrice_VND) as MinPrice FROM TravelRevenue " +
                     "WHERE ReportYear = ? AND ReportMonth = ? AND Category = N'Khách sạn' AND AvgHotelPrice_VND IS NOT NULL";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, year);
            ps.setInt(2, month);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                java.math.BigDecimal price = rs.getBigDecimal("MinPrice");
                System.out.println("DEBUG: Cheapest hotel price for " + month + "/" + year + " = " + price);
                return price;
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR in getCheapestHotelPrice: " + e.getMessage());
            e.printStackTrace();
        }
        
        return java.math.BigDecimal.ZERO;
    }

    /**
     * Get cheapest flight ticket
     */
    public java.math.BigDecimal getCheapestFlightTicket(int year, int month) {
        String sql = "SELECT MIN(AvgFlightTicket_VND) as MinPrice FROM TravelRevenue " +
                     "WHERE ReportYear = ? AND ReportMonth = ? AND Category = N'Hàng không' AND AvgFlightTicket_VND IS NOT NULL";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, year);
            ps.setInt(2, month);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                java.math.BigDecimal price = rs.getBigDecimal("MinPrice");
                System.out.println("DEBUG: Cheapest flight ticket for " + month + "/" + year + " = " + price);
                return price;
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR in getCheapestFlightTicket: " + e.getMessage());
            e.printStackTrace();
        }
        
        return java.math.BigDecimal.ZERO;
    }

    // Helper method to map ResultSet to TravelRevenue object
    private TravelRevenue mapResultSetToRevenue(ResultSet rs) throws SQLException {
        TravelRevenue revenue = new TravelRevenue();
        
        revenue.setId(rs.getInt("Id"));
        revenue.setReportMonth(rs.getInt("ReportMonth"));
        revenue.setReportYear(rs.getInt("ReportYear"));
        revenue.setCategory(rs.getString("Category"));
        revenue.setSupplierName(rs.getString("SupplierName"));
        revenue.setEstimatedRevenueBillion(rs.getDouble("EstimatedRevenue_Billion"));
        revenue.setAvgHotelPriceVND(rs.getBigDecimal("AvgHotelPrice_VND"));
        revenue.setGuestCount(rs.getInt("GuestCount"));
        revenue.setAvgFlightTicketVND(rs.getBigDecimal("AvgFlightTicket_VND"));
        
        return revenue;
    }
    
    /**
     * Get hotel details by year
     */
    public List<TravelRevenue> getHotelDetailsByYear(String hotelName, int year) {
        List<TravelRevenue> details = new ArrayList<>();
        String sql = "SELECT * FROM TravelRevenue WHERE SupplierName = ? AND ReportYear = ? AND Category = N'Khách sạn' ORDER BY ReportMonth";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, hotelName);
            ps.setInt(2, year);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                details.add(mapResultSetToRevenue(rs));
            }
            
            System.out.println("DEBUG: Found " + details.size() + " records for hotel: " + hotelName + " in year " + year);
            
        } catch (SQLException e) {
            System.err.println("ERROR in getHotelDetailsByYear: " + e.getMessage());
            e.printStackTrace();
        }
        
        return details;
    }
    
    /**
     * Get airline details by year
     */
    public List<TravelRevenue> getAirlineDetailsByYear(String airlineName, int year) {
        List<TravelRevenue> details = new ArrayList<>();
        String sql = "SELECT * FROM TravelRevenue WHERE SupplierName = ? AND ReportYear = ? AND Category = N'Hàng không' ORDER BY ReportMonth";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, airlineName);
            ps.setInt(2, year);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                details.add(mapResultSetToRevenue(rs));
            }
            
            System.out.println("DEBUG: Found " + details.size() + " records for airline: " + airlineName + " in year " + year);
            
        } catch (SQLException e) {
            System.err.println("ERROR in getAirlineDetailsByYear: " + e.getMessage());
            e.printStackTrace();
        }
        
        return details;
    }
    
    /**
     * Delete supplier (hotel or airline) - deletes all records
     */
    public boolean deleteSupplier(String supplierName) {
        String sql = "DELETE FROM TravelRevenue WHERE SupplierName = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, supplierName);
            int rowsDeleted = ps.executeUpdate();
            
            System.out.println("DEBUG: Deleted " + rowsDeleted + " records for supplier: " + supplierName);
            return rowsDeleted > 0;
            
        } catch (SQLException e) {
            System.err.println("ERROR in deleteSupplier: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Get all hotel data (all years and months)
     */
    public List<TravelRevenue> getAllHotelData(String hotelName) {
        List<TravelRevenue> details = new ArrayList<>();
        String sql = "SELECT * FROM TravelRevenue WHERE SupplierName = ? AND Category = N'Khách sạn' ORDER BY ReportYear DESC, ReportMonth DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, hotelName);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                details.add(mapResultSetToRevenue(rs));
            }
            
            System.out.println("DEBUG: Found " + details.size() + " total records for hotel: " + hotelName);
            
        } catch (SQLException e) {
            System.err.println("ERROR in getAllHotelData: " + e.getMessage());
            e.printStackTrace();
        }
        
        return details;
    }
    
    /**
     * Get all airline data (all years and months)
     */
    public List<TravelRevenue> getAllAirlineData(String airlineName) {
        List<TravelRevenue> details = new ArrayList<>();
        String sql = "SELECT * FROM TravelRevenue WHERE SupplierName = ? AND Category = N'Hàng không' ORDER BY ReportYear DESC, ReportMonth DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, airlineName);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                details.add(mapResultSetToRevenue(rs));
            }
            
            System.out.println("DEBUG: Found " + details.size() + " total records for airline: " + airlineName);
            
        } catch (SQLException e) {
            System.err.println("ERROR in getAllAirlineData: " + e.getMessage());
            e.printStackTrace();
        }
        
        return details;
    }
    
    /**
     * Update supplier name
     */
    public boolean updateSupplierName(String oldName, String newName) {
        String sql = "UPDATE TravelRevenue SET SupplierName = ? WHERE SupplierName = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, newName);
            ps.setString(2, oldName);
            int rowsUpdated = ps.executeUpdate();
            
            System.out.println("DEBUG: Updated " + rowsUpdated + " records from '" + oldName + "' to '" + newName + "'");
            return rowsUpdated > 0;
            
        } catch (SQLException e) {
            System.err.println("ERROR in updateSupplierName: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Update hotel record
     */
    public boolean updateHotelRecord(int recordId, Double revenue, java.math.BigDecimal price, Integer guests) {
        String sql = "UPDATE TravelRevenue SET EstimatedRevenue_Billion = ?, AvgHotelPrice_VND = ?, GuestCount = ? WHERE Id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setDouble(1, revenue != null ? revenue : 0.0);
            ps.setBigDecimal(2, price);
            ps.setInt(3, guests != null ? guests : 0);
            ps.setInt(4, recordId);
            
            int rowsUpdated = ps.executeUpdate();
            System.out.println("DEBUG: Updated hotel record ID " + recordId + " - rows affected: " + rowsUpdated);
            return rowsUpdated > 0;
            
        } catch (SQLException e) {
            System.err.println("ERROR in updateHotelRecord: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Update airline record
     */
    public boolean updateAirlineRecord(int recordId, Double revenue, java.math.BigDecimal ticketPrice, Integer passengers) {
        String sql = "UPDATE TravelRevenue SET EstimatedRevenue_Billion = ?, AvgFlightTicket_VND = ?, GuestCount = ? WHERE Id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setDouble(1, revenue != null ? revenue : 0.0);
            ps.setBigDecimal(2, ticketPrice);
            ps.setInt(3, passengers != null ? passengers : 0);
            ps.setInt(4, recordId);
            
            int rowsUpdated = ps.executeUpdate();
            System.out.println("DEBUG: Updated airline record ID " + recordId + " - rows affected: " + rowsUpdated);
            return rowsUpdated > 0;
            
        } catch (SQLException e) {
            System.err.println("ERROR in updateAirlineRecord: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
