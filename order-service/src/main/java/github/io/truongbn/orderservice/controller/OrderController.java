package github.io.truongbn.orderservice.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import github.io.truongbn.orderservice.model.Type;
import github.io.truongbn.orderservice.service.OrderService;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/orders")
@RequiredArgsConstructor
public class OrderController {
    private final OrderService orderService;
    @GetMapping
    public Type getByOrderNumber(@RequestParam("orderNumber") String orderNumber) {
        return orderService.getOrderByPostCode(orderNumber);
    }
}
