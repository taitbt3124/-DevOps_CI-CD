package com.quickbite.cart;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

class CartApplicationTests {

    @Test
    void healthReturnsUpMessage() {
        HealthController controller = new HealthController();
        assertEquals("cart-service is up", controller.health());
    }
}
