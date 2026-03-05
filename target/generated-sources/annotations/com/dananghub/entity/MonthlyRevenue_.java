package com.dananghub.entity;

import jakarta.annotation.Generated;
import jakarta.persistence.metamodel.EntityType;
import jakarta.persistence.metamodel.SingularAttribute;
import jakarta.persistence.metamodel.StaticMetamodel;
import java.util.Date;

@StaticMetamodel(MonthlyRevenue.class)
@Generated("org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
public abstract class MonthlyRevenue_ {

	
	/**
	 * @see com.dananghub.entity.MonthlyRevenue#reportMonth
	 **/
	public static volatile SingularAttribute<MonthlyRevenue, Integer> reportMonth;
	
	/**
	 * @see com.dananghub.entity.MonthlyRevenue#reportYear
	 **/
	public static volatile SingularAttribute<MonthlyRevenue, Integer> reportYear;
	
	/**
	 * @see com.dananghub.entity.MonthlyRevenue#createdAt
	 **/
	public static volatile SingularAttribute<MonthlyRevenue, Date> createdAt;
	
	/**
	 * @see com.dananghub.entity.MonthlyRevenue#grossVolume
	 **/
	public static volatile SingularAttribute<MonthlyRevenue, Double> grossVolume;
	
	/**
	 * @see com.dananghub.entity.MonthlyRevenue#totalBookings
	 **/
	public static volatile SingularAttribute<MonthlyRevenue, Integer> totalBookings;
	
	/**
	 * @see com.dananghub.entity.MonthlyRevenue#revenueId
	 **/
	public static volatile SingularAttribute<MonthlyRevenue, Integer> revenueId;
	
	/**
	 * @see com.dananghub.entity.MonthlyRevenue
	 **/
	public static volatile EntityType<MonthlyRevenue> class_;
	
	/**
	 * @see com.dananghub.entity.MonthlyRevenue#platformFee
	 **/
	public static volatile SingularAttribute<MonthlyRevenue, Double> platformFee;

	public static final String REPORT_MONTH = "reportMonth";
	public static final String REPORT_YEAR = "reportYear";
	public static final String CREATED_AT = "createdAt";
	public static final String GROSS_VOLUME = "grossVolume";
	public static final String TOTAL_BOOKINGS = "totalBookings";
	public static final String REVENUE_ID = "revenueId";
	public static final String PLATFORM_FEE = "platformFee";

}

