package com.example.springboot.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
public class HomeController {

    @GetMapping("/")
    public Map<String, Object> home() {
        Map<String, Object> info = new HashMap<>();
        info.put("message", "Spring Boot API funcionando!");
        info.put("version", "1.0.0");
        info.put("status", "UP");
        info.put("endpoints", Map.of(
            "health", "/actuator/health",
            "produtos", "/api/produtos"
        ));
        return info;
    }
}

