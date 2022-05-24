package com.system.blog.config;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Target(ElementType.PARAMETER)
@Retention(RetentionPolicy.RUNTIME)
public @interface Login {
}


//@interface : 해당 파일을 Annotation Class로 지정, @ResultJWT 라는 Annotation이 생성됨

//@Target(ElementType.PARAMETER) : 해당 Annotation이 생성될 위치 지정,
//PARAMETER로 지정 시 Method의 Parameter에서만 사용 가능

//@Retention(RetentionPolicy.RUNTIME) : Annotation 유지 정책을 설정,
//RUNTIME은 Byte Code File까지 Annotation 정보를 유지,
//reflection을 이용 Runtime시에 해당 Annotation 정보를 획득.
//reflection : 구체적인 Class Type을 알지 못해도, 그 Class의 method, type, field들에 접근할 수 있도록 해주는 Java API