package com.umg.ferreteria;

import org.junit.jupiter.api.Test;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class PasswordEncoderTest {

    @Test
    void printHashes() {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        System.out.println("BCRYPT_ADMIN: " + encoder.encode("admin123"));
        System.out.println("BCRYPT_USER: " + encoder.encode("user123"));
    }
}
