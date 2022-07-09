package com.projetannuel.userapi;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@Configuration
@EntityScan("com.projetannuel.userapi")
@EnableJpaRepositories("com.projetannuel.userapi.repositories")
public class UserApiApplication extends SpringBootServletInitializer {
    public static void main(String[] args) {
        SpringApplication.run(UserApiApplication.class, args);
    }
    @Override
    protected SpringApplicationBuilder
    configure(SpringApplicationBuilder builder) {
        return builder.sources(UserApiApplication.class);
    }
}