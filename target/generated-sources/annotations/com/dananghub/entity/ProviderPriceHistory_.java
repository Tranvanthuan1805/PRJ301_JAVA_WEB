package com.dananghub.entity;

import jakarta.annotation.Generated;
import jakarta.persistence.metamodel.EntityType;
import jakarta.persistence.metamodel.SingularAttribute;
import jakarta.persistence.metamodel.StaticMetamodel;
import java.math.BigDecimal;
import java.util.Date;

@StaticMetamodel(ProviderPriceHistory.class)
@Generated("org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
public abstract class ProviderPriceHistory_ {

	
	/**
	 * @see com.dananghub.entity.ProviderPriceHistory#serviceType
	 **/
	public static volatile SingularAttribute<ProviderPriceHistory, String> serviceType;
	
	/**
	 * @see com.dananghub.entity.ProviderPriceHistory#note
	 **/
	public static volatile SingularAttribute<ProviderPriceHistory, String> note;
	
	/**
	 * @see com.dananghub.entity.ProviderPriceHistory#provider
	 **/
	public static volatile SingularAttribute<ProviderPriceHistory, Provider> provider;
	
	/**
	 * @see com.dananghub.entity.ProviderPriceHistory#oldPrice
	 **/
	public static volatile SingularAttribute<ProviderPriceHistory, BigDecimal> oldPrice;
	
	/**
	 * @see com.dananghub.entity.ProviderPriceHistory#changeDate
	 **/
	public static volatile SingularAttribute<ProviderPriceHistory, Date> changeDate;
	
	/**
	 * @see com.dananghub.entity.ProviderPriceHistory#priceId
	 **/
	public static volatile SingularAttribute<ProviderPriceHistory, Integer> priceId;
	
	/**
	 * @see com.dananghub.entity.ProviderPriceHistory#serviceName
	 **/
	public static volatile SingularAttribute<ProviderPriceHistory, String> serviceName;
	
	/**
	 * @see com.dananghub.entity.ProviderPriceHistory
	 **/
	public static volatile EntityType<ProviderPriceHistory> class_;
	
	/**
	 * @see com.dananghub.entity.ProviderPriceHistory#newPrice
	 **/
	public static volatile SingularAttribute<ProviderPriceHistory, BigDecimal> newPrice;

	public static final String SERVICE_TYPE = "serviceType";
	public static final String NOTE = "note";
	public static final String PROVIDER = "provider";
	public static final String OLD_PRICE = "oldPrice";
	public static final String CHANGE_DATE = "changeDate";
	public static final String PRICE_ID = "priceId";
	public static final String SERVICE_NAME = "serviceName";
	public static final String NEW_PRICE = "newPrice";

}

