package com.common.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Inherited;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import com.common.model.Role.ROLE;


@Documented
@Target({ ElementType.TYPE, ElementType.METHOD })
@Inherited
@Retention(RetentionPolicy.RUNTIME)
public @interface AccessLevel {
    /**
     * Value.
     *
     * @return the rOLE
     */
    ROLE value() default ROLE.guest;
}
