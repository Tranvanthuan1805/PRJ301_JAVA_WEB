package com.dananghub.util;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import java.io.*;
import java.lang.reflect.Type;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class ProviderBankManager {
    // Luu file o thu muc user home de tranh bi reset khi restart Tomcat
    private static final String FILE_PATH = System.getProperty("user.home") + "/.prj301_provider_banks.json";
    
    private static Map<Integer, ProviderBankInfo> bankMap = new ConcurrentHashMap<>();

    static {
        loadData();
    }

    private static void loadData() {
        try {
            File file = new File(FILE_PATH);
            if (file.exists()) {
                try (Reader reader = new FileReader(file)) {
                    Type type = new TypeToken<Map<Integer, ProviderBankInfo>>(){}.getType();
                    Map<Integer, ProviderBankInfo> loaded = new Gson().fromJson(reader, type);
                    if (loaded != null) {
                        bankMap.putAll(loaded);
                    }
                }
            }
        } catch (Exception e) {
            System.err.println("Error loading ProviderBankInfo: " + e.getMessage());
        }
    }

    private static synchronized void saveData() {
        try {
            File file = new File(FILE_PATH);
            try (Writer writer = new FileWriter(file)) {
                new Gson().toJson(bankMap, writer);
            }
        } catch (Exception e) {
            System.err.println("Error saving ProviderBankInfo: " + e.getMessage());
        }
    }

    public static ProviderBankInfo getBankInfo(int providerId) {
        return bankMap.get(providerId);
    }

    public static void saveBankInfo(ProviderBankInfo info) {
        if (info != null) {
            bankMap.put(info.getProviderId(), info);
            saveData();
        }
    }
}
