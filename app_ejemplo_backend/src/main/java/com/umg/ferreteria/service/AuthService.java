package com.umg.ferreteria.service;

import com.umg.ferreteria.dto.request.LoginRequest;
import com.umg.ferreteria.dto.response.AuthResponse;
import com.umg.ferreteria.dto.response.UserResponse;

public interface AuthService {
    AuthResponse login(LoginRequest request);
    UserResponse getCurrentUser(String email);
}
