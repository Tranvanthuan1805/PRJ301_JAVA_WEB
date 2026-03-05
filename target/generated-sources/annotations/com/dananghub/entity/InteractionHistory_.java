package com.dananghub.entity;

import jakarta.annotation.Generated;
import jakarta.persistence.metamodel.EntityType;
import jakarta.persistence.metamodel.SingularAttribute;
import jakarta.persistence.metamodel.StaticMetamodel;
import java.util.Date;

@StaticMetamodel(InteractionHistory.class)
@Generated("org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
public abstract class InteractionHistory_ {

	
	/**
	 * @see com.dananghub.entity.InteractionHistory#createdAt
	 **/
	public static volatile SingularAttribute<InteractionHistory, Date> createdAt;
	
	/**
	 * @see com.dananghub.entity.InteractionHistory#customerId
	 **/
	public static volatile SingularAttribute<InteractionHistory, Integer> customerId;
	
	/**
	 * @see com.dananghub.entity.InteractionHistory#action
	 **/
	public static volatile SingularAttribute<InteractionHistory, String> action;
	
	/**
	 * @see com.dananghub.entity.InteractionHistory#id
	 **/
	public static volatile SingularAttribute<InteractionHistory, Integer> id;
	
	/**
	 * @see com.dananghub.entity.InteractionHistory
	 **/
	public static volatile EntityType<InteractionHistory> class_;

	public static final String CREATED_AT = "createdAt";
	public static final String CUSTOMER_ID = "customerId";
	public static final String ACTION = "action";
	public static final String ID = "id";

}

