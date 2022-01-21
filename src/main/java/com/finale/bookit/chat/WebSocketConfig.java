package com.finale.bookit.chat;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {
    
    @Override
    public void configureMessageBroker(MessageBrokerRegistry config) {
    	
    	// /topic 해당 주소를 구독하고 있는 n명의 클라이언트들에게 전달
    	// /queue 한명이 message를 발행했을 떄 발행한 한명에게 다시 정보를 보내는 경우
    	
        config.enableSimpleBroker("/sub");
        
        /** 클라이언트에서 보낸 메세지를 받을 prefix	
        *	/topic/hello 라는 토픽에 대해 구독을 신청했을 떄 실제 경로는 /app/topic/hello가 되는 것
        */
        config.setApplicationDestinationPrefixes("/app");
    }
    
    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        registry.addEndpoint("/endpoint")	// SockJS 연결 주소
        		.setAllowedOrigins("*")
        		.withSockJS();				// 클라이언트와의 연결을 위해 소켓JS설정
        
    }
}
