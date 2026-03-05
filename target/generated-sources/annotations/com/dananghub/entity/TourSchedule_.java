package com.dananghub.entity;

import jakarta.annotation.Generated;
import jakarta.persistence.metamodel.EntityType;
import jakarta.persistence.metamodel.SingularAttribute;
import jakarta.persistence.metamodel.StaticMetamodel;
import java.util.Date;

@StaticMetamodel(TourSchedule.class)
@Generated("org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
public abstract class TourSchedule_ {

	
	/**
	 * @see com.dananghub.entity.TourSchedule#returnDate
	 **/
	public static volatile SingularAttribute<TourSchedule, Date> returnDate;
	
	/**
	 * @see com.dananghub.entity.TourSchedule#departureDate
	 **/
	public static volatile SingularAttribute<TourSchedule, Date> departureDate;
	
	/**
	 * @see com.dananghub.entity.TourSchedule#availableSlots
	 **/
	public static volatile SingularAttribute<TourSchedule, Integer> availableSlots;
	
	/**
	 * @see com.dananghub.entity.TourSchedule
	 **/
	public static volatile EntityType<TourSchedule> class_;
	
	/**
	 * @see com.dananghub.entity.TourSchedule#scheduleId
	 **/
	public static volatile SingularAttribute<TourSchedule, Integer> scheduleId;
	
	/**
	 * @see com.dananghub.entity.TourSchedule#tour
	 **/
	public static volatile SingularAttribute<TourSchedule, Tour> tour;
	
	/**
	 * @see com.dananghub.entity.TourSchedule#status
	 **/
	public static volatile SingularAttribute<TourSchedule, String> status;

	public static final String RETURN_DATE = "returnDate";
	public static final String DEPARTURE_DATE = "departureDate";
	public static final String AVAILABLE_SLOTS = "availableSlots";
	public static final String SCHEDULE_ID = "scheduleId";
	public static final String TOUR = "tour";
	public static final String STATUS = "status";

}

