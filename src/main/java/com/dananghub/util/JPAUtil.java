package com.dananghub.util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JPAUtil {

    private static final String PERSISTENCE_UNIT = "DaNangTravelHubPU";
    private static EntityManagerFactory emf;
    private static String initError = null;

    static {
        try {
            System.out.println(">>> JPAUtil: Dang khoi tao EntityManagerFactory...");
            emf = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT);
            System.out.println(">>> JPAUtil: EntityManagerFactory THANH CONG!");
        } catch (Exception e) {
            initError = e.getMessage();
            System.err.println(">>> JPAUtil: LOI khoi tao EntityManagerFactory!");
            System.err.println(">>> Chi tiet: " + e.getMessage());

            // In ra root cause
            Throwable cause = e;
            while (cause.getCause() != null) {
                cause = cause.getCause();
                System.err.println(">>> Root cause: " + cause.getClass().getSimpleName() + " - " + cause.getMessage());
            }
            e.printStackTrace();
        }
    }

    public static EntityManager getEntityManager() {
        if (emf == null) {
            // Thu khoi tao lai 1 lan nua
            try {
                System.out.println(">>> JPAUtil: Thu khoi tao lai EntityManagerFactory...");
                emf = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT);
                initError = null;
                System.out.println(">>> JPAUtil: Khoi tao lai THANH CONG!");
            } catch (Exception e) {
                initError = e.getMessage();
                Throwable root = e;
                while (root.getCause() != null) root = root.getCause();
                throw new RuntimeException("JPA khong the ket noi database. Root: " + root.getMessage(), e);
            }
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
