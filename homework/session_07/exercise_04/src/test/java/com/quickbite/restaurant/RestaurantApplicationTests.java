package com.quickbite.restaurant;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

class RestaurantApplicationTests {

    @Test
    void healthReturnsUpMessage() {
        HealthController controller = new HealthController();
        assertEquals("restaurant-service is up", controller.health());
    }
}
