package com.dananghub.util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JPAUtil {

    private static final String PERSISTENCE_UNIT = "DaNangTravelHubPU";
    private static volatile EntityManagerFactory emf;
    private static String initError = null;
    private static final int MAX_RETRIES = 1;
    
    // Cooldown: don't retry init more than once per 30 seconds
    private static volatile long lastFailTime = 0;
    private static final long COOLDOWN_MS = 30_000; // 30 seconds

    // Eagerly initialize on class load (moves cold-start to app startup)
    static {
        try {
            System.out.println(">>> JPAUtil: Eagerly initializing EntityManagerFactory at startup...");
            emf = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT);
            System.out.println(">>> JPAUtil: EntityManagerFactory READY (eager init)!");
        } catch (Exception e) {
            initError = e.getMessage();
            lastFailTime = System.currentTimeMillis();
            System.err.println(">>> JPAUtil: Eager init FAILED: " + e.getMessage());
        }
    }

    private static synchronized void init() {
        if (emf != null && emf.isOpen()) return;
        
        // If we failed recently, don't retry yet (fast-fail)
        long now = System.currentTimeMillis();
        if (lastFailTime > 0 && (now - lastFailTime) < COOLDOWN_MS) {
            System.out.println(">>> JPAUtil: Skipping init (cooldown active, retry in " 
                + ((COOLDOWN_MS - (now - lastFailTime)) / 1000) + "s)");
            return;
        }
        
        try {
            System.out.println(">>> JPAUtil: Dang khoi tao EntityManagerFactory...");
            
            // Close existing broken factory if any
            if (emf != null) {
                try { emf.close(); } catch (Exception e) { /* ignore */ }
                emf = null;
            }
            
            emf = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT);
            initError = null;
            lastFailTime = 0;
            System.out.println(">>> JPAUtil: EntityManagerFactory THANH CONG!");
        } catch (Exception e) {
            initError = e.getMessage();
            lastFailTime = System.currentTimeMillis();
            System.err.println(">>> JPAUtil: LOI khoi tao EntityManagerFactory!");
            System.err.println(">>> Chi tiet: " + e.getMessage());
            Throwable cause = e;
            while (cause.getCause() != null) {
                cause = cause.getCause();
                System.err.println(">>> Root cause: " + cause.getClass().getSimpleName() + " - " + cause.getMessage());
            }
        }
    }

    public static EntityManager getEntityManager() {
        if (emf == null || !emf.isOpen()) {
            // Only try once — don't loop retries to avoid blocking the request
            init();
        }
        if (emf == null || !emf.isOpen()) {
            throw new RuntimeException("JPA khong the ket noi database. Error: " + initError);
        }
        
        EntityManager em = emf.createEntityManager();
        return em;
    }

    /**
     * Reset the factory - forces reconnection on next getEntityManager() call.
     * Use this when connection errors are detected.
     */
    public static synchronized void reset() {
        System.out.println(">>> JPAUtil: Resetting EntityManagerFactory...");
        if (emf != null) {
            try { emf.close(); } catch (Exception e) { /* ignore */ }
            emf = null;
        }
        lastFailTime = 0;
        initError = null;
    }

    public static boolean isOpen() {
        return emf != null && emf.isOpen();
    }

    public static String getInitError() {
        return initError;
    }

    public static void shutdown() {
        if (emf != null && emf.isOpen()) {
            emf.close();
            System.out.println(">>> JPAUtil: EntityManagerFactory closed");
        }
    }
}

