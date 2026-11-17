package com.quickbite.payment;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

class PaymentApplicationTests {

    @Test
    void healthReturnsUpMessage() {
        HealthController controller = new HealthController();
        assertEquals("payment-service is up", controller.health());
    }
}
