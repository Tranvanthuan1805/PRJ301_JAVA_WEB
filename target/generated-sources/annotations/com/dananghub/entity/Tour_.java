package com.dananghub.entity;

import jakarta.annotation.Generated;
import jakarta.persistence.metamodel.EntityType;
import jakarta.persistence.metamodel.ListAttribute;
import jakarta.persistence.metamodel.SingularAttribute;
import jakarta.persistence.metamodel.StaticMetamodel;
import java.util.Date;

@StaticMetamodel(Tour.class)
@Generated("org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
public abstract class Tour_ {

	
	/**
	 * @see com.dananghub.entity.Tour#images
	 **/
	public static volatile ListAttribute<Tour, TourImage> images;
	
	/**
	 * @see com.dananghub.entity.Tour#destination
	 **/
	public static volatile SingularAttribute<Tour, String> destination;
	
	/**
	 * @see com.dananghub.entity.Tour#description
	 **/
	public static volatile SingularAttribute<Tour, String> description;
	
	/**
	 * @see com.dananghub.entity.Tour#itinerary
	 **/
	public static volatile SingularAttribute<Tour, String> itinerary;
	
	/**
	 * @see com.dananghub.entity.Tour#transport
	 **/
	public static volatile SingularAttribute<Tour, String> transport;
	
	/**
	 * @see com.dananghub.entity.Tour#isActive
	 **/
	public static volatile SingularAttribute<Tour, Boolean> isActive;
	
	/**
	 * @see com.dananghub.entity.Tour#tourName
	 **/
	public static volatile SingularAttribute<Tour, String> tourName;
	
	/**
	 * @see com.dananghub.entity.Tour#duration
	 **/
	public static volatile SingularAttribute<Tour, String> duration;
	
	/**
	 * @see com.dananghub.entity.Tour#createdAt
	 **/
	public static volatile SingularAttribute<Tour, Date> createdAt;
	
	/**
	 * @see com.dananghub.entity.Tour#startLocation
	 **/
	public static volatile SingularAttribute<Tour, String> startLocation;
	
	/**
	 * @see com.dananghub.entity.Tour#provider
	 **/
	public static volatile SingularAttribute<Tour, Provider> provider;
	
	/**
	 * @see com.dananghub.entity.Tour#tourId
	 **/
	public static volatile SingularAttribute<Tour, Integer> tourId;
	
	/**
	 * @see com.dananghub.entity.Tour#price
	 **/
	public static volatile SingularAttribute<Tour, Double> price;
	
	/**
	 * @see com.dananghub.entity.Tour#imageUrl
	 **/
	public static volatile SingularAttribute<Tour, String> imageUrl;
	
	/**
	 * @see com.dananghub.entity.Tour#shortDesc
	 **/
	public static volatile SingularAttribute<Tour, String> shortDesc;
	
	/**
	 * @see com.dananghub.entity.Tour#maxPeople
	 **/
	public static volatile SingularAttribute<Tour, Integer> maxPeople;
	
	/**
	 * @see com.dananghub.entity.Tour#category
	 **/
	public static volatile SingularAttribute<Tour, Category> category;
	
	/**
	 * @see com.dananghub.entity.Tour
	 **/
	public static volatile EntityType<Tour> class_;
	
	/**
	 * @see com.dananghub.entity.Tour#updatedAt
	 **/
	public static volatile SingularAttribute<Tour, Date> updatedAt;

	public static final String IMAGES = "images";
	public static final String DESTINATION = "destination";
	public static final String DESCRIPTION = "description";
	public static final String ITINERARY = "itinerary";
	public static final String TRANSPORT = "transport";
	public static final String IS_ACTIVE = "isActive";
	public static final String TOUR_NAME = "tourName";
	public static final String DURATION = "duration";
	public static final String CREATED_AT = "createdAt";
	public static final String START_LOCATION = "startLocation";
	public static final String PROVIDER = "provider";
	public static final String TOUR_ID = "tourId";
	public static final String PRICE = "price";
	public static final String IMAGE_URL = "imageUrl";
	public static final String SHORT_DESC = "shortDesc";
	public static final String MAX_PEOPLE = "maxPeople";
	public static final String CATEGORY = "category";
	public static final String UPDATED_AT = "updatedAt";

}

