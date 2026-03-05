package com.dananghub.entity;

import jakarta.annotation.Generated;
import jakarta.persistence.metamodel.EntityType;
import jakarta.persistence.metamodel.SingularAttribute;
import jakarta.persistence.metamodel.StaticMetamodel;
import java.util.Date;

@StaticMetamodel(User.class)
@Generated("org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
public abstract class User_ {

	
	/**
	 * @see com.dananghub.entity.User#role
	 **/
	public static volatile SingularAttribute<User, Role> role;
	
	/**
	 * @see com.dananghub.entity.User#address
	 **/
	public static volatile SingularAttribute<User, String> address;
	
	/**
	 * @see com.dananghub.entity.User#avatarUrl
	 **/
	public static volatile SingularAttribute<User, String> avatarUrl;
	
	/**
	 * @see com.dananghub.entity.User#fullName
	 **/
	public static volatile SingularAttribute<User, String> fullName;
	
	/**
	 * @see com.dananghub.entity.User#dateOfBirth
	 **/
	public static volatile SingularAttribute<User, Date> dateOfBirth;
	
	/**
	 * @see com.dananghub.entity.User#isActive
	 **/
	public static volatile SingularAttribute<User, Boolean> isActive;
	
	/**
	 * @see com.dananghub.entity.User#userId
	 **/
	public static volatile SingularAttribute<User, Integer> userId;
	
	/**
	 * @see com.dananghub.entity.User#passwordHash
	 **/
	public static volatile SingularAttribute<User, String> passwordHash;
	
	/**
	 * @see com.dananghub.entity.User#createdAt
	 **/
	public static volatile SingularAttribute<User, Date> createdAt;
	
	/**
	 * @see com.dananghub.entity.User#phoneNumber
	 **/
	public static volatile SingularAttribute<User, String> phoneNumber;
	
	/**
	 * @see com.dananghub.entity.User
	 **/
	public static volatile EntityType<User> class_;
	
	/**
	 * @see com.dananghub.entity.User#email
	 **/
	public static volatile SingularAttribute<User, String> email;
	
	/**
	 * @see com.dananghub.entity.User#username
	 **/
	public static volatile SingularAttribute<User, String> username;
	
	/**
	 * @see com.dananghub.entity.User#updatedAt
	 **/
	public static volatile SingularAttribute<User, Date> updatedAt;

	public static final String ROLE = "role";
	public static final String ADDRESS = "address";
	public static final String AVATAR_URL = "avatarUrl";
	public static final String FULL_NAME = "fullName";
	public static final String DATE_OF_BIRTH = "dateOfBirth";
	public static final String IS_ACTIVE = "isActive";
	public static final String USER_ID = "userId";
	public static final String PASSWORD_HASH = "passwordHash";
	public static final String CREATED_AT = "createdAt";
	public static final String PHONE_NUMBER = "phoneNumber";
	public static final String EMAIL = "email";
	public static final String USERNAME = "username";
	public static final String UPDATED_AT = "updatedAt";

}

