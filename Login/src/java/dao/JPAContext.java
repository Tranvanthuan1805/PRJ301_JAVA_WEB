package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

/**
 * JPA Context - Singleton pattern for EntityManagerFactory
 * Manages database connections for Order Management module
 */
public class JPAContext {
    
    // Persistence unit name from persistence.xml
    private static final String PERSISTENCE_UNIT = "OrderManagementPU";
    
    // Singleton EntityManagerFactory (created once, reused)
    private static final EntityManagerFactory emf;
    
    static {
        try {
            emf = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT);
            System.out.println(">>> JPAContext: EntityManagerFactory created successfully");
        } catch (Exception e) {
            System.err.println(">>> JPAContext: Failed to create EntityManagerFactory");
            e.printStackTrace();
            throw new RuntimeException("Failed to initialize JPA", e);
        }
    }

    /**
     * Get a new EntityManager for database operations
     * Remember to close it after use!
     */
    public static EntityManager getEntityManager() {
        return emf.createEntityManager();
    }
    
    /**
     * Check if the factory is open
     */
    public static boolean isOpen() {
        return emf != null && emf.isOpen();
    }
    
    /**
     * Shutdown the factory (call when application stops)
     */
    public static void shutdown() {
        if (emf != null && emf.isOpen()) {
            emf.close();
            System.out.println(">>> JPAContext: EntityManagerFactory closed");
        }
    }
}
