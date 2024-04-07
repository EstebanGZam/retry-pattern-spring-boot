package github.io.truongbn.orderservice.repository;

import github.io.truongbn.orderservice.model.Order;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface OrderRepository extends JpaRepository<Order, Integer> {
    Optional<Order> findByOrderNumber(String orderNumber);
}
