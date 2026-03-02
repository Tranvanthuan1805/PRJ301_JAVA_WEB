package com.dananghub.util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JPAUtil {

    private static final String PERSISTENCE_UNIT = "DaNangTravelHubPU";
    private static EntityManagerFactory emf;
    private static String initError = null;

    private static synchronized void init() {
        if (emf != null && emf.isOpen()) return;
        try {
            System.out.println(">>> JPAUtil: Dang khoi tao EntityManagerFactory...");
            emf = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT);
            initError = null;
            System.out.println(">>> JPAUtil: EntityManagerFactory THANH CONG!");
        } catch (Exception e) {
            initError = e.getMessage();
            System.err.println(">>> JPAUtil: LOI khoi tao EntityManagerFactory!");
            System.err.println(">>> Chi tiet: " + e.getMessage());
            Throwable cause = e;
            while (cause.getCause() != null) {
                cause = cause.getCause();
                System.err.println(">>> Root cause: " + cause.getClass().getSimpleName() + " - " + cause.getMessage());
            }
            e.printStackTrace();
        }
    }

    public static EntityManager getEntityManager() {
        if (emf == null || !emf.isOpen()) {
            init();
        }
        if (emf == null) {
            throw new RuntimeException("JPA khong the ket noi database. Error: " + initError);
        }
        return emf.createEntityManager();
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
