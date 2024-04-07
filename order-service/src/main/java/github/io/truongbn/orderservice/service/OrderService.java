package github.io.truongbn.orderservice.service;


import github.io.truongbn.orderservice.model.Type;

public interface OrderService {
    Type getOrderByPostCode(String orderNumber);
}
