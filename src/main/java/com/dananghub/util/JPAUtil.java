package com.dananghub.util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JPAUtil {

    private static final String PERSISTENCE_UNIT = "DaNangTravelHubPU";
    private static EntityManagerFactory emf;

    static {
        try {
            emf = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT);
            System.out.println(">>> JPAUtil: EntityManagerFactory created OK");
        } catch (Exception e) {
            System.err.println(">>> JPAUtil: Failed to create EntityManagerFactory");
            e.printStackTrace();
            throw new RuntimeException("Failed to initialize JPA", e);
        }
    }

    public static EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public static boolean isOpen() {
        return emf != null && emf.isOpen();
    }

    public static void shutdown() {
        if (emf != null && emf.isOpen()) {
            emf.close();
            System.out.println(">>> JPAUtil: EntityManagerFactory closed");
        }
    }
}
