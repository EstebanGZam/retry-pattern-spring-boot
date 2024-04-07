package github.io.truongbn.orderservice.config;

import java.util.Arrays;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestTemplate;

import github.io.truongbn.orderservice.model.Order;
import github.io.truongbn.orderservice.repository.OrderRepository;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;

@Configuration
@RequiredArgsConstructor
public class AppConfig {
    private final OrderRepository orderRepository;
    @Bean
    public RestTemplate restTemplate() {
        return new RestTemplate();
    }

    @PostConstruct
    public void setupData() {
        orderRepository.saveAll(Arrays.asList(
                Order.builder().id(1).orderNumber("0c70c0c2").postalCode("1000001").build(),
                Order.builder().id(2).orderNumber("7f8f9f15").postalCode("1100000").build(),
                Order.builder().id(3).orderNumber("394627b2").postalCode("2100001").build(),
                Order.builder().id(4).orderNumber("825364c9").postalCode("1001111").build()));
    }
}
