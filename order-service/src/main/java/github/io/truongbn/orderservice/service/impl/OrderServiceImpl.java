package github.io.truongbn.orderservice.service.impl;

import java.time.Instant;
import java.util.stream.Stream;

import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.client.ResourceAccessException;
import org.springframework.web.client.RestTemplate;

import github.io.truongbn.orderservice.dto.AddressDTO;
import github.io.truongbn.orderservice.model.Failure;
import github.io.truongbn.orderservice.model.Order;
import github.io.truongbn.orderservice.model.Type;
import github.io.truongbn.orderservice.repository.OrderRepository;
import github.io.truongbn.orderservice.service.OrderService;
import io.github.resilience4j.retry.annotation.Retry;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class OrderServiceImpl implements OrderService {
    private static final String SERVICE_NAME = "order-service";
    private static final String ADDRESS_SERVICE_URL = "http://localhost:9090/addresses/";
    private final OrderRepository orderRepository;
    private final RestTemplate restTemplate;
    @Retry(name = SERVICE_NAME, fallbackMethod = "fallbackMethod")
    public Type getOrderByPostCode(String orderNumber) {
        Order order = orderRepository.findByOrderNumber(orderNumber)
                .orElseThrow(() -> new RuntimeException("Order Not Found: " + orderNumber));
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<AddressDTO> entity = new HttpEntity<>(null, headers);
        try {
            ResponseEntity<AddressDTO> response = restTemplate.exchange(
                    (ADDRESS_SERVICE_URL + order.getPostalCode()), HttpMethod.GET, entity,
                    AddressDTO.class);
            Stream.ofNullable(response.getBody()).forEach(it -> {
                order.setShippingState(it.getState());
                order.setShippingCity(it.getCity());
            });
        } catch (HttpServerErrorException e) {
            System.out.println("Retry due to http server error at: " + Instant.now());
            throw e;
        } catch (ResourceAccessException e) {
            System.out.println("Retry due to resource access at: " + Instant.now());
            throw e;
        }
        return order;
    }

    private Type fallbackMethod(Exception e) {
        return new Failure("Address service is not responding properly");
    }
}
