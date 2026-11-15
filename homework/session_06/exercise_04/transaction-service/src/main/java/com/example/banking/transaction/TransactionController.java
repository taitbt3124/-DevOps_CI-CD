package com.example.banking.transaction;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

@RestController
@RequestMapping("/api/transactions")
public class TransactionController {

    private final RestTemplate restTemplate;

    public TransactionController(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    @PostMapping("/transfer")
    public ResponseEntity<String> transferMoney(@RequestBody TransactionRequest request) {
        String accountServiceUrl = "http://account-service:8080/api/accounts";
        try {
            ResponseEntity<Object[]> response = restTemplate.getForEntity(accountServiceUrl, Object[].class);
            if (response.getStatusCode().is2xxSuccessful()) {
                return ResponseEntity.status(HttpStatus.CREATED)
                        .body("Transfer processed successfully for source account: " + request.getSourceAccountNumber());
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body("Transfer failed: Account service unreachable or source account not found.");
        }
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Transfer failed.");
    }
}
