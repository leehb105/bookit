package com.finale.bookit.member.model.vo;

import java.io.Serializable;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

/**
 * Security가 Member를 관리하기 위한 규격 UserDetails
 * 
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString(callSuper = true)
public class Member extends MemberEntity implements Serializable, UserDetails {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private List<SimpleGrantedAuthority> authorities;
	
	@Builder
	public Member(String id, String password, String email, String nickname, String name, String phone, boolean enabled,
			Date enrollDate, String reportYn, int cash, String profileImage, String roadAddress, String jibunAddress, float latitude,
			float longitude, List<SimpleGrantedAuthority> authorities) {
		super(id, password, email, nickname, name, phone, enabled, enrollDate, reportYn, cash, profileImage, roadAddress,
				jibunAddress, latitude, longitude);
		this.authorities = authorities;
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		// TODO Auto-generated method stub
		return authorities;
	}

	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return getId();
	}

	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}


	

}
