package com.projetannuel.userapi;

import java.util.ArrayList;
import java.util.List;

import org.springdoc.core.GroupedOpenApi;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.License;
import io.swagger.v3.oas.models.servers.Server;

@Configuration
public class OpenAPIConfig {
    @Bean
    public OpenAPI customOpenAPI() {
        License license = new License().name("Apache 2.0").url("https://springdoc.org/");
        Info info = new Info().title("User REST API").version("v1").license(license);
        List<Server> servers = new ArrayList<Server>();
        servers.add(new Server().url("https://userapi.youges.fr").description("Production server"))
        return new OpenAPI().info(info).servers(servers);
    }
    @Bean
    public GroupedOpenApi completeApi() {
        return GroupedOpenApi.builder().group("Complete").pathsToMatch("/**").build();
    }
}
