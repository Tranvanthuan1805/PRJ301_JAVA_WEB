package com.dananghub.entity;

import jakarta.annotation.Generated;
import jakarta.persistence.metamodel.EntityType;
import jakarta.persistence.metamodel.SingularAttribute;
import jakarta.persistence.metamodel.StaticMetamodel;

@StaticMetamodel(TourImage.class)
@Generated("org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
public abstract class TourImage_ {

	
	/**
	 * @see com.dananghub.entity.TourImage#imageId
	 **/
	public static volatile SingularAttribute<TourImage, Integer> imageId;
	
	/**
	 * @see com.dananghub.entity.TourImage#imageUrl
	 **/
	public static volatile SingularAttribute<TourImage, String> imageUrl;
	
	/**
	 * @see com.dananghub.entity.TourImage#sortOrder
	 **/
	public static volatile SingularAttribute<TourImage, Integer> sortOrder;
	
	/**
	 * @see com.dananghub.entity.TourImage#caption
	 **/
	public static volatile SingularAttribute<TourImage, String> caption;
	
	/**
	 * @see com.dananghub.entity.TourImage
	 **/
	public static volatile EntityType<TourImage> class_;
	
	/**
	 * @see com.dananghub.entity.TourImage#tour
	 **/
	public static volatile SingularAttribute<TourImage, Tour> tour;

	public static final String IMAGE_ID = "imageId";
	public static final String IMAGE_URL = "imageUrl";
	public static final String SORT_ORDER = "sortOrder";
	public static final String CAPTION = "caption";
	public static final String TOUR = "tour";

}

