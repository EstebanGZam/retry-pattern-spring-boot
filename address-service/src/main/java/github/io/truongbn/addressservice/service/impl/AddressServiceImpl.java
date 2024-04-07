package github.io.truongbn.addressservice.service.impl;

import org.springframework.stereotype.Service;

import github.io.truongbn.addressservice.model.Address;
import github.io.truongbn.addressservice.repository.AddressRepository;
import github.io.truongbn.addressservice.service.AddressService;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AddressServiceImpl implements AddressService {
    private final AddressRepository addressRepository;
    public Address getAddressByPostalCode(String postalCode) {
        return addressRepository.findByPostalCode(postalCode)
                .orElseThrow(() -> new IllegalStateException("Address Not Found: " + postalCode));
    }
}
