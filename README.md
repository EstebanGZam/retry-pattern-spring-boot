# Retry Pattern Demo with Resilience4j and Spring Boot

## Authors ✒️

> - Esteban Gaviria Zambrano - A00396019
> - Juan David Colonia Aldana - A00395956

## Overview 📄

This project demonstrates the implementation of the **Retry Pattern** using **Resilience4j** in a **Spring Boot** application. The Retry Pattern is a strategy used to handle transient failures in distributed systems, such as temporary network issues or service unavailability. By retrying failed operations after a delay, the application can improve its resilience and reliability.

The demo consists of two microservices:

- `order-service`: Handles client requests for order details.
- `address-service`: Provides shipping address information based on a postal code.

When `order-service` calls `address-service` and encounters a failure, it retries the request according to the configured Resilience4j Retry settings.

## Features 📌

- **Resilience4j Integration**: Demonstrates how to use Resilience4j's Retry module to handle transient failures.
- **Customizable Retry Configuration**: Configure the number of retries, delay between retries, and exceptions to trigger retries.
- **Spring Boot Microservices**: A simple example of two microservices communicating in a distributed environment.
- **Error Handling**: Shows how to handle errors gracefully and avoid overloading the system with unnecessary retries.

## References 🫱🏻‍🫲🏼

1. [Retry Pattern](https://learn.microsoft.com/en-us/azure/architecture/patterns/retry)
2. [Microservice Patterns: Retry with Spring Boot - Medium](https://medium.com/@truongbui95/microservice-patterns-retry-with-spring-boot-03b4d59f7c8c)
3. [Retry Pattern in Microservices - GeeksforGeeks](https://www.geeksforgeeks.org/retry-pattern-in-microservices/)
4. [Building Resilient Systems: Retry Pattern in Microservices - Medium](https://medium.com/engineering-at-bajaj-health/building-resilient-systems-retry-pattern-in-microservices-1b857da0e0eb)
