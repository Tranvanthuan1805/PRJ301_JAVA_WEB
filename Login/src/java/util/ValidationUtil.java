package util;

import java.time.LocalDate;
import java.util.regex.Pattern;

public class ValidationUtil {

    // Email validation pattern
    private static final Pattern EMAIL_PATTERN =
        Pattern.compile("^[A-Za-z0-9+_.-]+@([A-Za-z0-9.-]+\\.[A-Za-z]{2,})$");

    // Phone validation pattern (Vietnamese phone numbers)
    private static final Pattern PHONE_PATTERN =
        Pattern.compile("^(\\+84|0)[1-9][0-9]{8,9}$");

    /**
     * Validate email format
     */
    public static boolean isValidEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        return EMAIL_PATTERN.matcher(email.trim()).matches();
    }

    /**
     * Validate phone number format
     */
    public static boolean isValidPhone(String phone) {
        if (phone == null || phone.trim().isEmpty()) {
            return true; // Phone is optional
        }
        return PHONE_PATTERN.matcher(phone.trim().replaceAll("\\s+", "")).matches();
    }

    /**
     * Validate required string field
     */
    public static boolean isValidString(String value, int minLength, int maxLength) {
        if (value == null || value.trim().isEmpty()) {
            return false;
        }
        int length = value.trim().length();
        return length >= minLength && length <= maxLength;
    }

    /**
     * Validate customer name
     */
    public static boolean isValidCustomerName(String name) {
        return isValidString(name, 2, 100);
    }

    /**
     * Validate tour name
     */
    public static boolean isValidTourName(String name) {
        return isValidString(name, 5, 200);
    }

    /**
     * Validate destination
     */
    public static boolean isValidDestination(String destination) {
        return isValidString(destination, 2, 100);
    }

    /**
     * Validate address
     */
    public static boolean isValidAddress(String address) {
        if (address == null || address.trim().isEmpty()) {
            return true; // Address is optional
        }
        return address.trim().length() <= 255;
    }

    /**
     * Validate tour price
     */
    public static boolean isValidPrice(double price) {
        return price > 0 && price <= 999999999.99;
    }

    /**
     * Validate tour capacity
     */
    public static boolean isValidCapacity(int capacity) {
        return capacity > 0 && capacity <= 1000;
    }

    /**
     * Validate date range for tour
     */
    public static boolean isValidDateRange(LocalDate startDate, LocalDate endDate) {
        if (startDate == null || endDate == null) {
            return false;
        }
        LocalDate today = LocalDate.now();
        return startDate.isAfter(today) && endDate.isAfter(startDate);
    }

    /**
     * Validate tour description
     */
    public static boolean isValidDescription(String description) {
        if (description == null || description.trim().isEmpty()) {
            return true; // Description is optional
        }
        return description.trim().length() <= 2000;
    }

    /**
     * Sanitize string input to prevent XSS
     */
    public static String sanitizeString(String input) {
        if (input == null) {
            return null;
        }
        return input.trim()
                   .replaceAll("<", "&lt;")
                   .replaceAll(">", "&gt;")
                   .replaceAll("\"", "&quot;")
                   .replaceAll("'", "&#x27;")
                   .replaceAll("/", "&#x2F;");
    }

    /**
     * Check if string contains only letters, numbers, spaces and common punctuation
     */
    public static boolean isSafeString(String input) {
        if (input == null) {
            return true;
        }
        return input.matches("^[a-zA-Z0-9\\s.,!?()-]+$");
    }

    /**
     * Validate ID parameter
     */
    public static boolean isValidId(String idStr) {
        if (idStr == null || idStr.trim().isEmpty()) {
            return false;
        }
        try {
            int id = Integer.parseInt(idStr.trim());
            return id > 0;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    /**
     * Parse and validate integer parameter
     */
    public static Integer parseValidInteger(String value, int min, int max) {
        if (value == null || value.trim().isEmpty()) {
            return null;
        }
        try {
            int intValue = Integer.parseInt(value.trim());
            if (intValue >= min && intValue <= max) {
                return intValue;
            }
        } catch (NumberFormatException e) {
            // Invalid number format
        }
        return null;
    }

    /**
     * Parse and validate double parameter
     */
    public static Double parseValidDouble(String value, double min, double max) {
        if (value == null || value.trim().isEmpty()) {
            return null;
        }
        try {
            double doubleValue = Double.parseDouble(value.trim());
            if (doubleValue >= min && doubleValue <= max) {
                return doubleValue;
            }
        } catch (NumberFormatException e) {
            // Invalid number format
        }
        return null;
    }
}
