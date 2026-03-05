package com.dananghub.entity;

import jakarta.annotation.Generated;
import jakarta.persistence.metamodel.EntityType;
import jakarta.persistence.metamodel.SingularAttribute;
import jakarta.persistence.metamodel.StaticMetamodel;

@StaticMetamodel(SubscriptionPlan.class)
@Generated("org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
public abstract class SubscriptionPlan_ {

	
	/**
	 * @see com.dananghub.entity.SubscriptionPlan#durationDays
	 **/
	public static volatile SingularAttribute<SubscriptionPlan, Integer> durationDays;
	
	/**
	 * @see com.dananghub.entity.SubscriptionPlan#features
	 **/
	public static volatile SingularAttribute<SubscriptionPlan, String> features;
	
	/**
	 * @see com.dananghub.entity.SubscriptionPlan#price
	 **/
	public static volatile SingularAttribute<SubscriptionPlan, Double> price;
	
	/**
	 * @see com.dananghub.entity.SubscriptionPlan#planName
	 **/
	public static volatile SingularAttribute<SubscriptionPlan, String> planName;
	
	/**
	 * @see com.dananghub.entity.SubscriptionPlan#description
	 **/
	public static volatile SingularAttribute<SubscriptionPlan, String> description;
	
	/**
	 * @see com.dananghub.entity.SubscriptionPlan#planId
	 **/
	public static volatile SingularAttribute<SubscriptionPlan, Integer> planId;
	
	/**
	 * @see com.dananghub.entity.SubscriptionPlan#isActive
	 **/
	public static volatile SingularAttribute<SubscriptionPlan, Boolean> isActive;
	
	/**
	 * @see com.dananghub.entity.SubscriptionPlan
	 **/
	public static volatile EntityType<SubscriptionPlan> class_;
	
	/**
	 * @see com.dananghub.entity.SubscriptionPlan#planCode
	 **/
	public static volatile SingularAttribute<SubscriptionPlan, String> planCode;

	public static final String DURATION_DAYS = "durationDays";
	public static final String FEATURES = "features";
	public static final String PRICE = "price";
	public static final String PLAN_NAME = "planName";
	public static final String DESCRIPTION = "description";
	public static final String PLAN_ID = "planId";
	public static final String IS_ACTIVE = "isActive";
	public static final String PLAN_CODE = "planCode";

}

