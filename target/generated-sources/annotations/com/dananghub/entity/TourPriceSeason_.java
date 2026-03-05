package com.dananghub.entity;

import jakarta.annotation.Generated;
import jakarta.persistence.metamodel.EntityType;
import jakarta.persistence.metamodel.SingularAttribute;
import jakarta.persistence.metamodel.StaticMetamodel;
import java.util.Date;

@StaticMetamodel(TourPriceSeason.class)
@Generated("org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
public abstract class TourPriceSeason_ {

	
	/**
	 * @see com.dananghub.entity.TourPriceSeason#seasonId
	 **/
	public static volatile SingularAttribute<TourPriceSeason, Integer> seasonId;
	
	/**
	 * @see com.dananghub.entity.TourPriceSeason#endDate
	 **/
	public static volatile SingularAttribute<TourPriceSeason, Date> endDate;
	
	/**
	 * @see com.dananghub.entity.TourPriceSeason#seasonName
	 **/
	public static volatile SingularAttribute<TourPriceSeason, String> seasonName;
	
	/**
	 * @see com.dananghub.entity.TourPriceSeason#priceMultiplier
	 **/
	public static volatile SingularAttribute<TourPriceSeason, Double> priceMultiplier;
	
	/**
	 * @see com.dananghub.entity.TourPriceSeason#isActive
	 **/
	public static volatile SingularAttribute<TourPriceSeason, Boolean> isActive;
	
	/**
	 * @see com.dananghub.entity.TourPriceSeason
	 **/
	public static volatile EntityType<TourPriceSeason> class_;
	
	/**
	 * @see com.dananghub.entity.TourPriceSeason#tour
	 **/
	public static volatile SingularAttribute<TourPriceSeason, Tour> tour;
	
	/**
	 * @see com.dananghub.entity.TourPriceSeason#startDate
	 **/
	public static volatile SingularAttribute<TourPriceSeason, Date> startDate;

	public static final String SEASON_ID = "seasonId";
	public static final String END_DATE = "endDate";
	public static final String SEASON_NAME = "seasonName";
	public static final String PRICE_MULTIPLIER = "priceMultiplier";
	public static final String IS_ACTIVE = "isActive";
	public static final String TOUR = "tour";
	public static final String START_DATE = "startDate";

}

