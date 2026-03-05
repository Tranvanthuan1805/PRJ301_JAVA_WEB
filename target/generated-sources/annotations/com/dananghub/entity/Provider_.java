package com.dananghub.entity;

import jakarta.annotation.Generated;
import jakarta.persistence.metamodel.EntityType;
import jakarta.persistence.metamodel.ListAttribute;
import jakarta.persistence.metamodel.SingularAttribute;
import jakarta.persistence.metamodel.StaticMetamodel;
import java.time.LocalDate;
import java.time.LocalDateTime;

@StaticMetamodel(Provider.class)
@Generated("org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
public abstract class Provider_ {

	
	/**
	 * @see com.dananghub.entity.Provider#businessLicense
	 **/
	public static volatile SingularAttribute<Provider, String> businessLicense;
	
	/**
	 * @see com.dananghub.entity.Provider#totalTours
	 **/
	public static volatile SingularAttribute<Provider, Integer> totalTours;
	
	/**
	 * @see com.dananghub.entity.Provider#isVerified
	 **/
	public static volatile SingularAttribute<Provider, Boolean> isVerified;
	
	/**
	 * @see com.dananghub.entity.Provider#businessName
	 **/
	public static volatile SingularAttribute<Provider, String> businessName;
	
	/**
	 * @see com.dananghub.entity.Provider#rating
	 **/
	public static volatile SingularAttribute<Provider, Double> rating;
	
	/**
	 * @see com.dananghub.entity.Provider#description
	 **/
	public static volatile SingularAttribute<Provider, String> description;
	
	/**
	 * @see com.dananghub.entity.Provider#isActive
	 **/
	public static volatile SingularAttribute<Provider, Boolean> isActive;
	
	/**
	 * @see com.dananghub.entity.Provider#providerType
	 **/
	public static volatile SingularAttribute<Provider, String> providerType;
	
	/**
	 * @see com.dananghub.entity.Provider#createdAt
	 **/
	public static volatile SingularAttribute<Provider, LocalDateTime> createdAt;
	
	/**
	 * @see com.dananghub.entity.Provider#joinDate
	 **/
	public static volatile SingularAttribute<Provider, LocalDate> joinDate;
	
	/**
	 * @see com.dananghub.entity.Provider#providerId
	 **/
	public static volatile SingularAttribute<Provider, Integer> providerId;
	
	/**
	 * @see com.dananghub.entity.Provider
	 **/
	public static volatile EntityType<Provider> class_;
	
	/**
	 * @see com.dananghub.entity.Provider#user
	 **/
	public static volatile SingularAttribute<Provider, User> user;
	
	/**
	 * @see com.dananghub.entity.Provider#priceHistory
	 **/
	public static volatile ListAttribute<Provider, ProviderPriceHistory> priceHistory;
	
	/**
	 * @see com.dananghub.entity.Provider#status
	 **/
	public static volatile SingularAttribute<Provider, String> status;
	
	/**
	 * @see com.dananghub.entity.Provider#updatedAt
	 **/
	public static volatile SingularAttribute<Provider, LocalDateTime> updatedAt;

	public static final String BUSINESS_LICENSE = "businessLicense";
	public static final String TOTAL_TOURS = "totalTours";
	public static final String IS_VERIFIED = "isVerified";
	public static final String BUSINESS_NAME = "businessName";
	public static final String RATING = "rating";
	public static final String DESCRIPTION = "description";
	public static final String IS_ACTIVE = "isActive";
	public static final String PROVIDER_TYPE = "providerType";
	public static final String CREATED_AT = "createdAt";
	public static final String JOIN_DATE = "joinDate";
	public static final String PROVIDER_ID = "providerId";
	public static final String USER = "user";
	public static final String PRICE_HISTORY = "priceHistory";
	public static final String STATUS = "status";
	public static final String UPDATED_AT = "updatedAt";

}

