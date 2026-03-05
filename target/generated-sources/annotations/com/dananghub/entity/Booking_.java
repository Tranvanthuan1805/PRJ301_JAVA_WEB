package com.dananghub.entity;

import jakarta.annotation.Generated;
import jakarta.persistence.metamodel.EntityType;
import jakarta.persistence.metamodel.SingularAttribute;
import jakarta.persistence.metamodel.StaticMetamodel;
import java.util.Date;

@StaticMetamodel(Booking.class)
@Generated("org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
public abstract class Booking_ {

	
	/**
	 * @see com.dananghub.entity.Booking#quantity
	 **/
	public static volatile SingularAttribute<Booking, Integer> quantity;
	
	/**
	 * @see com.dananghub.entity.Booking#bookingStatus
	 **/
	public static volatile SingularAttribute<Booking, String> bookingStatus;
	
	/**
	 * @see com.dananghub.entity.Booking#bookingDate
	 **/
	public static volatile SingularAttribute<Booking, Date> bookingDate;
	
	/**
	 * @see com.dananghub.entity.Booking#subTotal
	 **/
	public static volatile SingularAttribute<Booking, Double> subTotal;
	
	/**
	 * @see com.dananghub.entity.Booking
	 **/
	public static volatile EntityType<Booking> class_;
	
	/**
	 * @see com.dananghub.entity.Booking#bookingId
	 **/
	public static volatile SingularAttribute<Booking, Integer> bookingId;
	
	/**
	 * @see com.dananghub.entity.Booking#tour
	 **/
	public static volatile SingularAttribute<Booking, Tour> tour;
	
	/**
	 * @see com.dananghub.entity.Booking#order
	 **/
	public static volatile SingularAttribute<Booking, Order> order;

	public static final String QUANTITY = "quantity";
	public static final String BOOKING_STATUS = "bookingStatus";
	public static final String BOOKING_DATE = "bookingDate";
	public static final String SUB_TOTAL = "subTotal";
	public static final String BOOKING_ID = "bookingId";
	public static final String TOUR = "tour";
	public static final String ORDER = "order";

}

