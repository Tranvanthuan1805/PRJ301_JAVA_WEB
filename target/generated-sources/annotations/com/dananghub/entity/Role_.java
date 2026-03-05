package com.dananghub.entity;

import jakarta.annotation.Generated;
import jakarta.persistence.metamodel.EntityType;
import jakarta.persistence.metamodel.SingularAttribute;
import jakarta.persistence.metamodel.StaticMetamodel;

@StaticMetamodel(Role.class)
@Generated("org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
public abstract class Role_ {

	
	/**
	 * @see com.dananghub.entity.Role#roleId
	 **/
	public static volatile SingularAttribute<Role, Integer> roleId;
	
	/**
	 * @see com.dananghub.entity.Role#roleName
	 **/
	public static volatile SingularAttribute<Role, String> roleName;
	
	/**
	 * @see com.dananghub.entity.Role
	 **/
	public static volatile EntityType<Role> class_;

	public static final String ROLE_ID = "roleId";
	public static final String ROLE_NAME = "roleName";

}

