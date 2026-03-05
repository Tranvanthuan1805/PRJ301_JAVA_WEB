package com.dananghub.entity;

import jakarta.annotation.Generated;
import jakarta.persistence.metamodel.EntityType;
import jakarta.persistence.metamodel.SingularAttribute;
import jakarta.persistence.metamodel.StaticMetamodel;
import java.util.Date;

@StaticMetamodel(AILog.class)
@Generated("org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
public abstract class AILog_ {

	
	/**
	 * @see com.dananghub.entity.AILog#outputData
	 **/
	public static volatile SingularAttribute<AILog, String> outputData;
	
	/**
	 * @see com.dananghub.entity.AILog#actionType
	 **/
	public static volatile SingularAttribute<AILog, String> actionType;
	
	/**
	 * @see com.dananghub.entity.AILog#createdAt
	 **/
	public static volatile SingularAttribute<AILog, Date> createdAt;
	
	/**
	 * @see com.dananghub.entity.AILog#inputData
	 **/
	public static volatile SingularAttribute<AILog, String> inputData;
	
	/**
	 * @see com.dananghub.entity.AILog#executionTimeMs
	 **/
	public static volatile SingularAttribute<AILog, Integer> executionTimeMs;
	
	/**
	 * @see com.dananghub.entity.AILog#logId
	 **/
	public static volatile SingularAttribute<AILog, Integer> logId;
	
	/**
	 * @see com.dananghub.entity.AILog
	 **/
	public static volatile EntityType<AILog> class_;
	
	/**
	 * @see com.dananghub.entity.AILog#userId
	 **/
	public static volatile SingularAttribute<AILog, Integer> userId;

	public static final String OUTPUT_DATA = "outputData";
	public static final String ACTION_TYPE = "actionType";
	public static final String CREATED_AT = "createdAt";
	public static final String INPUT_DATA = "inputData";
	public static final String EXECUTION_TIME_MS = "executionTimeMs";
	public static final String LOG_ID = "logId";
	public static final String USER_ID = "userId";

}

