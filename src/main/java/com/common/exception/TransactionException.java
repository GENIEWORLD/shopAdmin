package com.common.exception;

public class TransactionException extends Exception {

	static final long serialVersionUID = 7983809402295082280L;

	public TransactionException(String msg){
		super(msg);
	}
}
