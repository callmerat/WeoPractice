package com.system.blog.config;

import com.system.blog.ResponseVO;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindException;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import java.util.HashMap;
import java.util.Map;

@ControllerAdvice
public class MyExceptionController {

    @ExceptionHandler(value = MyLoginException.class)
    public String loginExceptionHandler(MyLoginException ex) {
        return "user/login";
    }

    @ExceptionHandler(value = MyApiLoginException.class)
    public ResponseEntity<String> apiLoginExceptionHandler(MyApiLoginException ex) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json;charset=UTF-8");
        return new ResponseEntity(ResponseVO.of(ex.getMsg()), headers, HttpStatus.OK);
    }

    @ExceptionHandler({BindException.class})
    public ResponseEntity<String> processValidationError(BindException exception) {
        BindingResult bindingResult = exception.getBindingResult();

        StringBuffer msg = new StringBuffer();
        for (ObjectError error : bindingResult.getAllErrors()) {
            msg.append(error.getDefaultMessage() + "\n");
        }

        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json;charset=UTF-8");
        return new ResponseEntity(ResponseVO.of(msg.toString()), headers, HttpStatus.OK);
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<Map<String, String>> handleValidationExceptions(MethodArgumentNotValidException ex){
        Map<String, String> errors = new HashMap<>();
//        ex.getBindingResult().getAllErrors()
//                .forEach(c -> errors.put(((FieldError) c).getField(), c.getDefaultMessage()));
        return ResponseEntity.badRequest().body(errors);
    }

}
