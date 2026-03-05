package com.dananghub.entity;

import jakarta.annotation.Generated;
import jakarta.persistence.metamodel.EntityType;
import jakarta.persistence.metamodel.ListAttribute;
import jakarta.persistence.metamodel.SingularAttribute;
import jakarta.persistence.metamodel.StaticMetamodel;
import java.util.Date;

@StaticMetamodel(Order.class)
@Generated("org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
public abstract class Order_ {

	
	/**
	 * @see com.dananghub.entity.Order#totalAmount
	 **/
	public static volatile SingularAttribute<Order, Double> totalAmount;
	
	/**
	 * @see com.dananghub.entity.Order#orderId
	 **/
	public static volatile SingularAttribute<Order, Integer> orderId;
	
	/**
	 * @see com.dananghub.entity.Order#orderStatus
	 **/
	public static volatile SingularAttribute<Order, String> orderStatus;
	
	/**
	 * @see com.dananghub.entity.Order#cancelReason
	 **/
	public static volatile SingularAttribute<Order, String> cancelReason;
	
	/**
	 * @see com.dananghub.entity.Order#bookings
	 **/
	public static volatile ListAttribute<Order, Booking> bookings;
	
	/**
	 * @see com.dananghub.entity.Order
	 **/
	public static volatile EntityType<Order> class_;
	
	/**
	 * @see com.dananghub.entity.Order#orderDate
	 **/
	public static volatile SingularAttribute<Order, Date> orderDate;
	
	/**
	 * @see com.dananghub.entity.Order#paymentStatus
	 **/
	public static volatile SingularAttribute<Order, String> paymentStatus;
	
	/**
	 * @see com.dananghub.entity.Order#customer
	 **/
	public static volatile SingularAttribute<Order, User> customer;
	
	/**
	 * @see com.dananghub.entity.Order#updatedAt
	 **/
	public static volatile SingularAttribute<Order, Date> updatedAt;

	public static final String TOTAL_AMOUNT = "totalAmount";
	public static final String ORDER_ID = "orderId";
	public static final String ORDER_STATUS = "orderStatus";
	public static final String CANCEL_REASON = "cancelReason";
	public static final String BOOKINGS = "bookings";
	public static final String ORDER_DATE = "orderDate";
	public static final String PAYMENT_STATUS = "paymentStatus";
	public static final String CUSTOMER = "customer";
	public static final String UPDATED_AT = "updatedAt";

}

