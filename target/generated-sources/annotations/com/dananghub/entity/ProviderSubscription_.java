package com.dananghub.entity;

import jakarta.annotation.Generated;
import jakarta.persistence.metamodel.EntityType;
import jakarta.persistence.metamodel.SingularAttribute;
import jakarta.persistence.metamodel.StaticMetamodel;
import java.util.Date;

@StaticMetamodel(ProviderSubscription.class)
@Generated("org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
public abstract class ProviderSubscription_ {

	
	/**
	 * @see com.dananghub.entity.ProviderSubscription#subId
	 **/
	public static volatile SingularAttribute<ProviderSubscription, Integer> subId;
	
	/**
	 * @see com.dananghub.entity.ProviderSubscription#amount
	 **/
	public static volatile SingularAttribute<ProviderSubscription, Double> amount;
	
	/**
	 * @see com.dananghub.entity.ProviderSubscription#provider
	 **/
	public static volatile SingularAttribute<ProviderSubscription, Provider> provider;
	
	/**
	 * @see com.dananghub.entity.ProviderSubscription#endDate
	 **/
	public static volatile SingularAttribute<ProviderSubscription, Date> endDate;
	
	/**
	 * @see com.dananghub.entity.ProviderSubscription#isActive
	 **/
	public static volatile SingularAttribute<ProviderSubscription, Boolean> isActive;
	
	/**
	 * @see com.dananghub.entity.ProviderSubscription
	 **/
	public static volatile EntityType<ProviderSubscription> class_;
	
	/**
	 * @see com.dananghub.entity.ProviderSubscription#plan
	 **/
	public static volatile SingularAttribute<ProviderSubscription, SubscriptionPlan> plan;
	
	/**
	 * @see com.dananghub.entity.ProviderSubscription#startDate
	 **/
	public static volatile SingularAttribute<ProviderSubscription, Date> startDate;
	
	/**
	 * @see com.dananghub.entity.ProviderSubscription#paymentStatus
	 **/
	public static volatile SingularAttribute<ProviderSubscription, String> paymentStatus;
	
	/**
	 * @see com.dananghub.entity.ProviderSubscription#status
	 **/
	public static volatile SingularAttribute<ProviderSubscription, String> status;

	public static final String SUB_ID = "subId";
	public static final String AMOUNT = "amount";
	public static final String PROVIDER = "provider";
	public static final String END_DATE = "endDate";
	public static final String IS_ACTIVE = "isActive";
	public static final String PLAN = "plan";
	public static final String START_DATE = "startDate";
	public static final String PAYMENT_STATUS = "paymentStatus";
	public static final String STATUS = "status";

}

