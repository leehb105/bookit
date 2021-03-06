package com.finale.security.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.finale.security.model.dao.SecurityDao;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class SecurityService implements UserDetailsService {

	
	@Autowired
	private SecurityDao securityDao;
	
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		log.debug("username = {}", username);
		UserDetails member = securityDao.loadUserByUsername(username);
		
		log.debug("security member = {}", member);
		
		if(member == null) {
			throw new UsernameNotFoundException(username);
		}
		return member;
	}

}