package com.quickbite.user;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

class UserApplicationTests {

    @Test
    void healthReturnsUpMessage() {
        HealthController controller = new HealthController();
        assertEquals("user-service is up", controller.health());
    }
}
