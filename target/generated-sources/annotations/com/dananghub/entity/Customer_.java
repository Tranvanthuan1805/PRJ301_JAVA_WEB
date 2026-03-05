package com.dananghub.entity;

import jakarta.annotation.Generated;
import jakarta.persistence.metamodel.EntityType;
import jakarta.persistence.metamodel.SingularAttribute;
import jakarta.persistence.metamodel.StaticMetamodel;
import java.util.Date;

@StaticMetamodel(Customer.class)
@Generated("org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
public abstract class Customer_ {

	
	/**
	 * @see com.dananghub.entity.Customer#address
	 **/
	public static volatile SingularAttribute<Customer, String> address;
	
	/**
	 * @see com.dananghub.entity.Customer#customerId
	 **/
	public static volatile SingularAttribute<Customer, Integer> customerId;
	
	/**
	 * @see com.dananghub.entity.Customer#dateOfBirth
	 **/
	public static volatile SingularAttribute<Customer, Date> dateOfBirth;
	
	/**
	 * @see com.dananghub.entity.Customer
	 **/
	public static volatile EntityType<Customer> class_;
	
	/**
	 * @see com.dananghub.entity.Customer#user
	 **/
	public static volatile SingularAttribute<Customer, User> user;
	
	/**
	 * @see com.dananghub.entity.Customer#status
	 **/
	public static volatile SingularAttribute<Customer, String> status;

	public static final String ADDRESS = "address";
	public static final String CUSTOMER_ID = "customerId";
	public static final String DATE_OF_BIRTH = "dateOfBirth";
	public static final String USER = "user";
	public static final String STATUS = "status";

}

