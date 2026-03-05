package com.dananghub.entity;

import jakarta.annotation.Generated;
import jakarta.persistence.metamodel.EntityType;
import jakarta.persistence.metamodel.SingularAttribute;
import jakarta.persistence.metamodel.StaticMetamodel;
import java.util.Date;

@StaticMetamodel(PaymentTransaction.class)
@Generated("org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
public abstract class PaymentTransaction_ {

	
	/**
	 * @see com.dananghub.entity.PaymentTransaction#amount
	 **/
	public static volatile SingularAttribute<PaymentTransaction, Double> amount;
	
	/**
	 * @see com.dananghub.entity.PaymentTransaction#createdDate
	 **/
	public static volatile SingularAttribute<PaymentTransaction, Date> createdDate;
	
	/**
	 * @see com.dananghub.entity.PaymentTransaction#paidDate
	 **/
	public static volatile SingularAttribute<PaymentTransaction, Date> paidDate;
	
	/**
	 * @see com.dananghub.entity.PaymentTransaction#orderId
	 **/
	public static volatile SingularAttribute<PaymentTransaction, Integer> orderId;
	
	/**
	 * @see com.dananghub.entity.PaymentTransaction#sePayReference
	 **/
	public static volatile SingularAttribute<PaymentTransaction, String> sePayReference;
	
	/**
	 * @see com.dananghub.entity.PaymentTransaction#planId
	 **/
	public static volatile SingularAttribute<PaymentTransaction, Integer> planId;
	
	/**
	 * @see com.dananghub.entity.PaymentTransaction#transactionCode
	 **/
	public static volatile SingularAttribute<PaymentTransaction, String> transactionCode;
	
	/**
	 * @see com.dananghub.entity.PaymentTransaction
	 **/
	public static volatile EntityType<PaymentTransaction> class_;
	
	/**
	 * @see com.dananghub.entity.PaymentTransaction#userId
	 **/
	public static volatile SingularAttribute<PaymentTransaction, Integer> userId;
	
	/**
	 * @see com.dananghub.entity.PaymentTransaction#transactionId
	 **/
	public static volatile SingularAttribute<PaymentTransaction, Integer> transactionId;
	
	/**
	 * @see com.dananghub.entity.PaymentTransaction#status
	 **/
	public static volatile SingularAttribute<PaymentTransaction, String> status;
	
	/**
	 * @see com.dananghub.entity.PaymentTransaction#paymentGateway
	 **/
	public static volatile SingularAttribute<PaymentTransaction, String> paymentGateway;

	public static final String AMOUNT = "amount";
	public static final String CREATED_DATE = "createdDate";
	public static final String PAID_DATE = "paidDate";
	public static final String ORDER_ID = "orderId";
	public static final String SE_PAY_REFERENCE = "sePayReference";
	public static final String PLAN_ID = "planId";
	public static final String TRANSACTION_CODE = "transactionCode";
	public static final String USER_ID = "userId";
	public static final String TRANSACTION_ID = "transactionId";
	public static final String STATUS = "status";
	public static final String PAYMENT_GATEWAY = "paymentGateway";

}

