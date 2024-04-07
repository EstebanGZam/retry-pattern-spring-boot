package github.io.truongbn.addressservice.service;

import java.net.SocketTimeoutException;

import github.io.truongbn.addressservice.model.Address;

public interface AddressService {
    Address getAddressByPostalCode(String postalCode) throws SocketTimeoutException;
}
