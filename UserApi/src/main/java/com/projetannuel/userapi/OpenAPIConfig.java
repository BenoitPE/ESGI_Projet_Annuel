package com.projetannuel.userapi;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.License;
import io.swagger.v3.oas.models.servers.Server;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.ArrayList;
import java.util.List;

/**
 * The type Open api config.
 */
@Configuration
public class OpenAPIConfig {
    /**
     * Custom open api open api.
     *
     * @return the open api
     */
    @Bean
    public OpenAPI customOpenAPI() {
        License license = new License().name("Apache 2.0").url("https://springdoc.org/");
        Info info = new Info().title("User REST API").version("v1").license(license);
        List<Server> servers = new ArrayList<Server>();
        servers.add(new Server().url("/"));
        return new OpenAPI().info(info).servers(servers);
    }
}
