package com.dananghub.util;

import java.time.LocalDate;
import java.util.regex.Pattern;

public class ValidationUtil {

    private static final Pattern EMAIL_PATTERN =
        Pattern.compile("^[A-Za-z0-9+_.-]+@([A-Za-z0-9.-]+\\.[A-Za-z]{2,})$");

    private static final Pattern PHONE_PATTERN =
        Pattern.compile("^(\\+84|0)[1-9][0-9]{8,9}$");

    public static boolean isValidEmail(String email) {
        if (email == null || email.trim().isEmpty()) return false;
        return EMAIL_PATTERN.matcher(email.trim()).matches();
    }

    public static boolean isValidPhone(String phone) {
        if (phone == null || phone.trim().isEmpty()) return true;
        return PHONE_PATTERN.matcher(phone.trim().replaceAll("\\s+", "")).matches();
    }

    public static boolean isValidString(String value, int minLength, int maxLength) {
        if (value == null || value.trim().isEmpty()) return false;
        int length = value.trim().length();
        return length >= minLength && length <= maxLength;
    }

    public static boolean isValidCustomerName(String name) {
        return isValidString(name, 2, 100);
    }

    public static boolean isValidTourName(String name) {
        return isValidString(name, 5, 200);
    }

    public static boolean isValidDestination(String destination) {
        return isValidString(destination, 2, 100);
    }

    public static boolean isValidAddress(String address) {
        if (address == null || address.trim().isEmpty()) return true;
        return address.trim().length() <= 255;
    }

    public static boolean isValidPrice(double price) {
        return price > 0 && price <= 999999999.99;
    }

    public static boolean isValidCapacity(int capacity) {
        return capacity > 0 && capacity <= 1000;
    }

    public static boolean isValidDateRange(LocalDate startDate, LocalDate endDate) {
        if (startDate == null || endDate == null) return false;
        return startDate.isAfter(LocalDate.now()) && endDate.isAfter(startDate);
    }

    public static boolean isValidDescription(String description) {
        if (description == null || description.trim().isEmpty()) return true;
        return description.trim().length() <= 2000;
    }

    public static String sanitizeString(String input) {
        if (input == null) return null;
        return input.trim()
                   .replaceAll("<", "&lt;")
                   .replaceAll(">", "&gt;")
                   .replaceAll("\"", "&quot;")
                   .replaceAll("'", "&#x27;")
                   .replaceAll("/", "&#x2F;");
    }

    public static boolean isSafeString(String input) {
        if (input == null) return true;
        return input.matches("^[a-zA-Z0-9\\s.,!?()-]+$");
    }

    public static boolean isValidId(String idStr) {
        if (idStr == null || idStr.trim().isEmpty()) return false;
        try {
            return Integer.parseInt(idStr.trim()) > 0;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    public static Integer parseValidInteger(String value, int min, int max) {
        if (value == null || value.trim().isEmpty()) return null;
        try {
            int intValue = Integer.parseInt(value.trim());
            if (intValue >= min && intValue <= max) return intValue;
        } catch (NumberFormatException e) {}
        return null;
    }

    public static Double parseValidDouble(String value, double min, double max) {
        if (value == null || value.trim().isEmpty()) return null;
        try {
            double doubleValue = Double.parseDouble(value.trim());
            if (doubleValue >= min && doubleValue <= max) return doubleValue;
        } catch (NumberFormatException e) {}
        return null;
    }
}
