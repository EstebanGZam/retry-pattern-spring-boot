package github.io.truongbn.addressservice.controller;

import java.net.SocketTimeoutException;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import github.io.truongbn.addressservice.model.Address;
import github.io.truongbn.addressservice.service.AddressService;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("addresses")
@RequiredArgsConstructor
public class AddressController {
    private final AddressService addressService;
    @GetMapping("/{postalCode}")
    public Address getAddressByPostalCode(@PathVariable("postalCode") String postalCode)
            throws SocketTimeoutException {
        return addressService.getAddressByPostalCode(postalCode);
    }
}
