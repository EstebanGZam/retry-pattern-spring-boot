package github.io.truongbn.orderservice.model;

import lombok.Data;

@Data
public class Failure implements Type {
    private final String msg;
}
