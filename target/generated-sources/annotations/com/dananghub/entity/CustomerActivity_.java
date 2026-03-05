package com.dananghub.entity;

import jakarta.annotation.Generated;
import jakarta.persistence.metamodel.EntityType;
import jakarta.persistence.metamodel.SingularAttribute;
import jakarta.persistence.metamodel.StaticMetamodel;
import java.util.Date;

@StaticMetamodel(CustomerActivity.class)
@Generated("org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
public abstract class CustomerActivity_ {

	
	/**
	 * @see com.dananghub.entity.CustomerActivity#actionType
	 **/
	public static volatile SingularAttribute<CustomerActivity, String> actionType;
	
	/**
	 * @see com.dananghub.entity.CustomerActivity#createdAt
	 **/
	public static volatile SingularAttribute<CustomerActivity, Date> createdAt;
	
	/**
	 * @see com.dananghub.entity.CustomerActivity#metadata
	 **/
	public static volatile SingularAttribute<CustomerActivity, String> metadata;
	
	/**
	 * @see com.dananghub.entity.CustomerActivity#customerId
	 **/
	public static volatile SingularAttribute<CustomerActivity, Integer> customerId;
	
	/**
	 * @see com.dananghub.entity.CustomerActivity#description
	 **/
	public static volatile SingularAttribute<CustomerActivity, String> description;
	
	/**
	 * @see com.dananghub.entity.CustomerActivity#id
	 **/
	public static volatile SingularAttribute<CustomerActivity, Integer> id;
	
	/**
	 * @see com.dananghub.entity.CustomerActivity
	 **/
	public static volatile EntityType<CustomerActivity> class_;

	public static final String ACTION_TYPE = "actionType";
	public static final String CREATED_AT = "createdAt";
	public static final String METADATA = "metadata";
	public static final String CUSTOMER_ID = "customerId";
	public static final String DESCRIPTION = "description";
	public static final String ID = "id";

}

