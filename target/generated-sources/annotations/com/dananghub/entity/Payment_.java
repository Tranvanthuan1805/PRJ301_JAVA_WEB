package com.dananghub.entity;

import jakarta.annotation.Generated;
import jakarta.persistence.metamodel.EntityType;
import jakarta.persistence.metamodel.SingularAttribute;
import jakarta.persistence.metamodel.StaticMetamodel;
import java.util.Date;

@StaticMetamodel(Payment.class)
@Generated("org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
public abstract class Payment_ {

	
	/**
	 * @see com.dananghub.entity.Payment#amount
	 **/
	public static volatile SingularAttribute<Payment, Double> amount;
	
	/**
	 * @see com.dananghub.entity.Payment#paymentId
	 **/
	public static volatile SingularAttribute<Payment, Integer> paymentId;
	
	/**
	 * @see com.dananghub.entity.Payment#paymentMethod
	 **/
	public static volatile SingularAttribute<Payment, String> paymentMethod;
	
	/**
	 * @see com.dananghub.entity.Payment#paidAt
	 **/
	public static volatile SingularAttribute<Payment, Date> paidAt;
	
	/**
	 * @see com.dananghub.entity.Payment
	 **/
	public static volatile EntityType<Payment> class_;
	
	/**
	 * @see com.dananghub.entity.Payment#transactionId
	 **/
	public static volatile SingularAttribute<Payment, String> transactionId;
	
	/**
	 * @see com.dananghub.entity.Payment#paymentStatus
	 **/
	public static volatile SingularAttribute<Payment, String> paymentStatus;
	
	/**
	 * @see com.dananghub.entity.Payment#order
	 **/
	public static volatile SingularAttribute<Payment, Order> order;

	public static final String AMOUNT = "amount";
	public static final String PAYMENT_ID = "paymentId";
	public static final String PAYMENT_METHOD = "paymentMethod";
	public static final String PAID_AT = "paidAt";
	public static final String TRANSACTION_ID = "transactionId";
	public static final String PAYMENT_STATUS = "paymentStatus";
	public static final String ORDER = "order";

}

