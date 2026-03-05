package com.dananghub.entity;

import jakarta.annotation.Generated;
import jakarta.persistence.metamodel.EntityType;
import jakarta.persistence.metamodel.SingularAttribute;
import jakarta.persistence.metamodel.StaticMetamodel;
import java.util.Date;

@StaticMetamodel(SepayTransaction.class)
@Generated("org.hibernate.jpamodelgen.JPAMetaModelEntityProcessor")
public abstract class SepayTransaction_ {

	
	/**
	 * @see com.dananghub.entity.SepayTransaction#code
	 **/
	public static volatile SingularAttribute<SepayTransaction, String> code;
	
	/**
	 * @see com.dananghub.entity.SepayTransaction#transferAmount
	 **/
	public static volatile SingularAttribute<SepayTransaction, Double> transferAmount;
	
	/**
	 * @see com.dananghub.entity.SepayTransaction#description
	 **/
	public static volatile SingularAttribute<SepayTransaction, String> description;
	
	/**
	 * @see com.dananghub.entity.SepayTransaction#transactionDate
	 **/
	public static volatile SingularAttribute<SepayTransaction, String> transactionDate;
	
	/**
	 * @see com.dananghub.entity.SepayTransaction#accountNumber
	 **/
	public static volatile SingularAttribute<SepayTransaction, String> accountNumber;
	
	/**
	 * @see com.dananghub.entity.SepayTransaction#content
	 **/
	public static volatile SingularAttribute<SepayTransaction, String> content;
	
	/**
	 * @see com.dananghub.entity.SepayTransaction#subAccount
	 **/
	public static volatile SingularAttribute<SepayTransaction, String> subAccount;
	
	/**
	 * @see com.dananghub.entity.SepayTransaction#createdAt
	 **/
	public static volatile SingularAttribute<SepayTransaction, Date> createdAt;
	
	/**
	 * @see com.dananghub.entity.SepayTransaction#transferType
	 **/
	public static volatile SingularAttribute<SepayTransaction, String> transferType;
	
	/**
	 * @see com.dananghub.entity.SepayTransaction#id
	 **/
	public static volatile SingularAttribute<SepayTransaction, Integer> id;
	
	/**
	 * @see com.dananghub.entity.SepayTransaction#referenceCode
	 **/
	public static volatile SingularAttribute<SepayTransaction, String> referenceCode;
	
	/**
	 * @see com.dananghub.entity.SepayTransaction
	 **/
	public static volatile EntityType<SepayTransaction> class_;
	
	/**
	 * @see com.dananghub.entity.SepayTransaction#gateway
	 **/
	public static volatile SingularAttribute<SepayTransaction, String> gateway;
	
	/**
	 * @see com.dananghub.entity.SepayTransaction#accumulated
	 **/
	public static volatile SingularAttribute<SepayTransaction, Double> accumulated;

	public static final String CODE = "code";
	public static final String TRANSFER_AMOUNT = "transferAmount";
	public static final String DESCRIPTION = "description";
	public static final String TRANSACTION_DATE = "transactionDate";
	public static final String ACCOUNT_NUMBER = "accountNumber";
	public static final String CONTENT = "content";
	public static final String SUB_ACCOUNT = "subAccount";
	public static final String CREATED_AT = "createdAt";
	public static final String TRANSFER_TYPE = "transferType";
	public static final String ID = "id";
	public static final String REFERENCE_CODE = "referenceCode";
	public static final String GATEWAY = "gateway";
	public static final String ACCUMULATED = "accumulated";

}

