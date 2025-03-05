# Retry Pattern

The **Retry Pattern** is a strategy used in software development to handle transient failures in communication between systems, especially in distributed environments like the cloud. This pattern is based on the idea of retrying a failed operation after a waiting period, with the expectation that the issue will resolve itself and the operation will succeed in a subsequent attempt.

![Image](https://learn.microsoft.com/en-us/azure/architecture/patterns/_images/retry-pattern.png)

## Context and Problem

In cloud environments, applications often interact with services and components that may experience transient failures. These failures include:

- Temporary loss of network connectivity.
- Short-term unavailability of a service.
- Timeouts due to service overload.

![Image](https://apiumhub.com/wp-content/uploads/2019/06/Screenshot-2019-06-30-at-21.02.30.png)

These issues are usually temporary and, in many cases, resolve automatically after a short period. For example, a database service processing a large number of simultaneous requests might implement a throttling strategy, temporarily rejecting new requests until its workload decreases. If an application tries to access this service and fails, retrying the operation after a delay may result in success.

## When Not to Use the Retry Pattern?

Although the Retry Pattern is useful in many situations, it is not suitable in all cases:

- **Non-transient errors:** If the error is caused by a permanent issue, such as incorrect credentials or an invalid URL, retries will only waste resources.
- **Application logic errors:** Errors in the application code will not be resolved by retries.
- **Permanently down services:** If a service is offline for an extended period, continuing to retry may overload other systems and will not solve the problem.

## Retry Strategies

When an application detects an error while trying to send a request to a remote service, it can handle the error using the following strategies:

- **Cancel:** If the error indicates that it is not transient or is unlikely to succeed if repeated, the application should cancel the operation and report an exception.
- **Retry immediately:** If the error is unusual or rare (e.g., a corrupted network packet), the best action may be to retry the request immediately.
- **Retry after a delay:** If the error is caused by connectivity issues or overload, the application can wait for a short period before retrying.

If the request continues to fail, the application can keep retrying with increasing delays until a maximum number of attempts is reached.

### Types of Retry Delays

The types of delays that can be implemented in the Retry Pattern are as follows:

- **Fixed delay retry:** The application retries after a constant time period (e.g., every 5 seconds).
- **Exponential retry:** The waiting time doubles with each attempt (e.g., 1s, 2s, 4s, 8s…).
- **Jitter (randomization):** Variability is added to the waiting time to avoid overloading the target system.

![Image](https://miro.medium.com/v2/resize:fit:1400/format:webp/0*kP3SVY85duuGixgC)

## Performance and Cost Considerations

Some important considerations when implementing the Retry Pattern are:

- **Performance impact:** Too many retries can negatively affect system performance, especially if they occur in a short time frame.
- **Cloud costs:** In pay-per-use services, excessive retries can unnecessarily increase costs.
- **Use of circuit breakers:** A circuit breaker can prevent the system from retrying indefinitely when a service is down, protecting resources and reducing costs.

## Conclusion

The Retry Pattern is a powerful tool for handling transient failures in distributed systems, but it must be used carefully. By implementing appropriate retry strategies and considering factors like performance and costs, developers can improve the resilience of their applications without compromising system efficiency. Additionally, using complementary techniques like circuit breakers can help prevent larger issues when services are down or experiencing prolonged failures.

# Resilience4j Retry Demo in Spring Boot

**Resilience4j** is an open-source library that provides tools for building resilient applications. Among its modules are **Circuit Breaker**, **Rate Limiter**, **Bulkhead**, and **Retry**. The latter is particularly useful for handling temporary failures in operations that may initially fail. It allows customization of the number of retries, the waiting time between them, and the exceptions that should trigger a retry.

## Demo Scenario

The demo consists of two services: `address-service` and `order-service`.

![Image](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*03fs1hgYWMQeonpSIzZEGA.png)

1. A client makes a request to `order-service` to get details of their order.
2. `order-service` calls `address-service` to get the shipping address using a postal code.
3. If `address-service` fails, `order-service` retries the request according to the Resilience4j-Retry configuration.

# References

1. [Retry Pattern](https://learn.microsoft.com/en-us/azure/architecture/patterns/retry)
2. [Microservice Patterns: Retry with Spring Boot - Medium](https://medium.com/@truongbui95/microservice-patterns-retry-with-spring-boot-03b4d59f7c8c)
3. [Retry Pattern in Microservices - GeeksforGeeks](https://www.geeksforgeeks.org/retry-pattern-in-microservices/)
4. [Building Resilient Systems: Retry Pattern in Microservices - Medium](https://medium.com/engineering-at-bajaj-health/building-resilient-systems-retry-pattern-in-microservices-1b857da0e0eb)
