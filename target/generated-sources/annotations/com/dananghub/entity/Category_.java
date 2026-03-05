package com.dananghub.entity;

import jakarta.annotation.Generated;
import jakarta.persistence.metamodel.EntityType;
import jakarta.persistence.metamodel.SingularAttribute;
import jakarta.persistence.metamodel.StaticMetamodel;

@StaticMetamodel(Category.class)
@Generated("org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
public abstract class Category_ {

	
	/**
	 * @see com.dananghub.entity.Category#description
	 **/
	public static volatile SingularAttribute<Category, String> description;
	
	/**
	 * @see com.dananghub.entity.Category#iconUrl
	 **/
	public static volatile SingularAttribute<Category, String> iconUrl;
	
	/**
	 * @see com.dananghub.entity.Category
	 **/
	public static volatile EntityType<Category> class_;
	
	/**
	 * @see com.dananghub.entity.Category#categoryName
	 **/
	public static volatile SingularAttribute<Category, String> categoryName;
	
	/**
	 * @see com.dananghub.entity.Category#categoryId
	 **/
	public static volatile SingularAttribute<Category, Integer> categoryId;

	public static final String DESCRIPTION = "description";
	public static final String ICON_URL = "iconUrl";
	public static final String CATEGORY_NAME = "categoryName";
	public static final String CATEGORY_ID = "categoryId";

}

