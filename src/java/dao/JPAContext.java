package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JPAContext {
    
    // Tạo nhà máy chỉ 1 lần duy nhất (Singleton)
    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("MyUnit");

    // Hàm lấy EntityManager (dùng để truy vấn)
    public static EntityManager getEntityManager() {
        return emf.createEntityManager();
    }
    
    // Hàm đóng nhà máy khi tắt web (để giải phóng RAM)
    public static void shutdown() {
        if (emf != null && isOpened()) {
            emf.close();
        }
    }

    public static boolean isOpened() {
        return emf.isOpen();
    }
}